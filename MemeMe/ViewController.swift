//
//  ViewController.swift
//  MemeMe
//
//  Created by Luiz Arantes Sa on 4/9/18.
//  Copyright © 2018 Luiz Arantes Sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!


    var topTextFieldDelegate: MemeMeTextFieldDelegate!
    var bottomTextFieldDelegate: MemeMeTextFieldDelegate!
    var memes = [Meme]();


    override func viewDidLoad() {
        super.viewDidLoad()
        let memeTextAttributes: [String: Any] = [
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeColor.rawValue: UIColor.white,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
            // Specify negative values to stroke and fill the text.
            NSAttributedStringKey.strokeWidth.rawValue: -3.0,
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.autocapitalizationType = .allCharacters
        topTextField.textAlignment = .center
        topTextFieldDelegate = MemeMeTextFieldDelegate()
        topTextField.delegate = topTextFieldDelegate

        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.autocapitalizationType = .allCharacters
        bottomTextField.textAlignment = .center
        bottomTextFieldDelegate = MemeMeTextFieldDelegate()
        bottomTextField.delegate = bottomTextFieldDelegate

        imageView.contentMode = .scaleAspectFit
        shareButton.isEnabled = false
    }

    // MARK: lifecycle
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotification()
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        subscribeToKeyboardNotification()
        super.viewWillDisappear(animated)
    }


    // MARK: choose image
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as! UIImage? {
            // do something with chosen image
            imageView.image = image
            shareButton.isEnabled = true
        }
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }

    @IBAction func pickImageFromCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
        }
        present(picker, animated: true, completion: nil)
    }

    // MARK: sharing image
    @IBAction func shareImage(_ sender: Any) {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        let activityItem: [AnyObject] = [memedImage as AnyObject]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)

        avc.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(meme);
            }
        };
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            present(avc, animated: true, completion: nil)
        } else if (UIDevice.current.userInterfaceIdiom == .pad) {
            avc.modalPresentationStyle = .popover
            avc.popoverPresentationController!.barButtonItem = shareButton
            present(avc, animated: true, completion: nil)
        }
    }

    func save(_ meme: Meme) {
        memes.append(meme)
    }

    func generateMemedImage() -> UIImage {

        let isPortrait = self.isPortrait();
        
        if (isPortrait) {
            // we set opacity so layout doesn't change
            setToolbarAlpha(to: 0)
        } else {
            setToolbarVisibility(to:  false)
        }
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        if (isPortrait) {
            setToolbarAlpha(to: 1)
        } else {
            setToolbarVisibility(to:  true)
        }

        return memedImage
    }

    // MARK: handlers
    @objc func keyboardWillShow(notification: NSNotification) {
        if (keyboardCanOverlapEditingField() && view.frame.origin.y == 0) {
            let height = getKeyboardHeight(notification)
            view.frame.origin.y -= height
        }
    }

    @objc func keyboardWillHide() {
        if (keyboardCanOverlapEditingField()) {
            view.frame.origin.y = 0
        }
    }

    // MARK: subscriptions
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }

    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    // MARK: other
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        if let frame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue? {
            return frame.cgRectValue.height
        }
        return CGFloat(0)
    }

    func keyboardCanOverlapEditingField() -> Bool {
        return bottomTextField.isFirstResponder
    }

    // used in portrait mode
    func setToolbarAlpha(to alpha: Int) {
        topToolbar.alpha = CGFloat(alpha);
        bottomToolbar.alpha = CGFloat(alpha);
    }

    // used in landscape mode
    func setToolbarVisibility(to visible: Bool) {
        topToolbar.isHidden = !visible;
        bottomToolbar.isHidden = !visible;
    }

    func isPortrait() -> Bool {
        //  UIDevice.current.orientation can sometimes return orientation status as unknown... what gives?
        if let size = UIApplication.shared.keyWindow?.rootViewController?.view.frame.size {
            return size.height > size.width;
        }
        // shouldn't reach, assume portrait.
        return true;
    }
}


//
//  MemeEditorViewController.swift
//  MemeMe2
//
//  Created by Luiz Arantes Sa on 3/30/19.
//  Copyright © 2019 Luiz Arantes Sa. All rights reserved.
//

import UIKit


class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTextField(textField: topTextField, defaultText: "TOP")
        topTextFieldDelegate = MemeMeTextFieldDelegate()
        topTextField.delegate = topTextFieldDelegate
        
        customizeTextField(textField: bottomTextField, defaultText: "BOTTOM")
        bottomTextFieldDelegate = MemeMeTextFieldDelegate()
        bottomTextField.delegate = bottomTextFieldDelegate
        
        imageView.contentMode = .scaleAspectFit
        shareButton.isEnabled = false
    }
    
    func customizeTextField(textField: UITextField, defaultText: String) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            // white with a black outline, and shrink to fit.
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            // Specify negative values to stroke and fill the text.
            NSAttributedString.Key.strokeWidth: -5.0,
        ]
        
        textField.autocapitalizationType = .allCharacters
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
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
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage? {
            // do something with chosen image
            imageView.image = image
            shareButton.isEnabled = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        showPicker(.photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        showPicker(.camera)
    }

    func showPicker(_ sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(sourceType)) {
            picker.sourceType = sourceType
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
                self.performSegue(withIdentifier: "unwind", sender: self)
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
        Meme.allMemes.append(meme)
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
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
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
        if (keyboardCanOverlapEditingField()) {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    // MARK: subscriptions
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: other
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue? {
            return frame.cgRectValue.height
        }
        return CGFloat(0)
    }
    
    func keyboardCanOverlapEditingField() -> Bool {
        return bottomTextField.isFirstResponder
    }
    
    // used in portrait mode
    func  setToolbarAlpha(to alpha: Int) {
        topToolbar.alpha = CGFloat(alpha);
        bottomToolbar.alpha = CGFloat(alpha);
    }
    
    // used in landscape mode
    func setToolbarVisibility(to visible: Bool) {
        topToolbar.isHidden = !visible;
        bottomToolbar.isHidden = !visible;
    }
    
    func isPortrait() -> Bool {
        let size = self.view.frame.size
        return size.height > size.width;
        
    }
    
}

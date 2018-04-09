//
//  ViewController.swift
//  MemeMe
//
//  Created by Luiz Arantes Sa on 4/9/18.
//  Copyright © 2018 Luiz Arantes Sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    var topTextFieldDelegate: MemeMeTextFieldDelegate!
    var bottomTextFieldDelegate: MemeMeTextFieldDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        let memeTextAttributes: [String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.white,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: 5
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        topTextFieldDelegate = MemeMeTextFieldDelegate()
        topTextField.delegate = topTextFieldDelegate

        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        bottomTextFieldDelegate = MemeMeTextFieldDelegate()
        bottomTextFieldDelegate.autoAdjustKeyboard = true
        bottomTextField.delegate = bottomTextFieldDelegate
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


    override func viewWillAppear(_ animated: Bool) {
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as! UIImage? {
            // do something with chosen image
            imageView.image = image

        }
        picker.dismiss(animated: true, completion: nil)
    }

    func save() {
        var memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
    }

    func generateMemedImage() -> UIImage {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return memedImage
    }
}


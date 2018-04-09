//
//  MemeMeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Luiz Arantes Sa on 4/9/18.
//  Copyright © 2018 Luiz Arantes Sa. All rights reserved.
//

import UIKit

class MemeMeTextFieldDelegate: NSObject, UITextFieldDelegate {

    var autoAdjustKeyboard = false;

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        subscribeToKeyboardNotification()
        textField.text = "";
        return true;
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        unsubscribeToKeyboardNotification()
    }

    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        if let frame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue? {
            return frame.cgRectValue.height
        }
        return CGFloat(0)
    }

    func getRootView() -> UIView {
        return (UIApplication.shared.keyWindow?.rootViewController?.view)!
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if (autoAdjustKeyboard) {
            let height = getKeyboardHeight(notification)
            getRootView().frame.origin.y -= height
        }
    }

    @objc func keyboardWillHide() {
        if (autoAdjustKeyboard) {
            getRootView().frame.origin.y = 0
        }
    }

    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }

    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

}

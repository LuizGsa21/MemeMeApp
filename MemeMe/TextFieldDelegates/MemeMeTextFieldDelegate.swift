//
//  MemeMeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Luiz Arantes Sa on 4/9/18.
//  Copyright © 2018 Luiz Arantes Sa. All rights reserved.
//

import UIKit

class MemeMeTextFieldDelegate: NSObject, UITextFieldDelegate {

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "";
    }
    
}

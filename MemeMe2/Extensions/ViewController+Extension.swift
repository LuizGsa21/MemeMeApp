//
//  ViewController+Extension.swift
//  MemeMe2
//
//  Created by Luiz Arantes Sa on 3/30/19.
//  Copyright © 2019 Luiz Arantes Sa. All rights reserved.
//

import UIKit


extension UIViewController {

    func setupMemeEditorButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(didTapMemeEditorButton))
    }

    @objc func didTapMemeEditorButton(button: UIBarButtonItem) {
        button.isEnabled = false
        let editor = storyboard!.instantiateViewController(withIdentifier: MemeEditorViewController.className)
        editor.modalPresentationStyle = .fullScreen
        self.present(editor, animated: true) {
            button.isEnabled = true
        }
    }

    @IBAction func unwind (_ sender:UIStoryboardSegue) {
        // do nothing
    }

}

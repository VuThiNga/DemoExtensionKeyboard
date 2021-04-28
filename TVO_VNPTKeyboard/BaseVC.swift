//
//  BaseVC.swift
//  TVO_VNPTKeyboard
//
//  Created by Ngavt on 4/27/21.
//

import UIKit

class BaseVC: UIViewController {
    func addCustomBarKeyboard(_ textField: UITextField) {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)

        let inputAccessory = CustomAccessoryView(frame: rect)
//
//        let keyboardToolbar = UIToolbar()
//        keyboardToolbar.sizeToFit()
//        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                            target: nil, action: nil)
//        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
//                                            target: self.view, action: #selector(UIView.endEditing(_:)))
//        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessory.addAction = { [weak self] textStr in
            textField.text = textStr
            textField.becomeFirstResponder()
            self?.view.endEditing(true)
        }
        textField.inputAccessoryView = inputAccessory
    }
    
}

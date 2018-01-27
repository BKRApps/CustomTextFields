//
//  ViewController.swift
//  CustomTextField
//
//  Created by kumar reddy on 27/01/18.
//  Copyright © 2018 kumar reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var simpleTextField: UITextField!
    @IBOutlet weak var lableTextField: LabelTextField!
    var textCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        simpleTextField.becomeFirstResponder()
//        simpleTextField.isSecureTextEntry = true
        
        let customButton = UIButton(type: .custom)
        customButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        customButton.setTitle("Show", for: .normal)
        customButton.setTitleColor(UIColor.red, for: .normal)
        customButton.addTarget(self, action: #selector(didTap(_:)), for: UIControlEvents.touchUpInside)
        simpleTextField.rightView = customButton
        simpleTextField.rightViewMode = UITextFieldViewMode.whileEditing
        
        let customLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        customLabel.text = "Card"
        simpleTextField.leftView = customLabel
        simpleTextField.leftViewMode = UITextFieldViewMode.always
        
        
//        lableTextField.leftView = customLabel
//        lableTextField.leftViewMode = .always
    }
    
    @objc func didTap(_ sender :UIButton) {
        print("Tapped on a button")
        //simpleTextField.isSecureTextEntry = !simpleTextField.isSecureTextEntry
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Textfield started editing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("range \(range)")
        print("textfield text \(textField.text ?? " ")")
        // when user removing the characters
        if string.isEmpty {
            textCount = textCount > 0 ? textCount-1 : 4
        }else if var presentText = textField.text{
            presentText = (presentText as NSString).replacingCharacters(in: range, with: string)
            print("edited textfield text \(presentText)")
            if textCount % 4 == 0 && textCount > 0{
                textField.text?.append("-")
                textCount = 1
            }else{
                textCount = textCount + 1
            }
        }
        print("replacement string \(string)")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Textfield ended editing")
    }
}


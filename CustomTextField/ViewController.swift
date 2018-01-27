//
//  ViewController.swift
//  CustomTextField
//
//  Created by kumar reddy on 27/01/18.
//  Copyright © 2018 kumar reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var showHidePasswordTF: UITextField!
    
    var showHideButton : UIButton!
    
    var textCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardTextField.becomeFirstResponder()
        
        // add a button to the right view
        let customButton = UIButton(type: .custom)
        customButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        customButton.setTitle("VISA", for: .normal)
        customButton.setTitleColor(UIColor.gray, for: .normal)
        customButton.addTarget(self, action: #selector(didTap(_:)), for: UIControlEvents.touchUpInside)
        creditCardTextField.rightView = customButton
        creditCardTextField.rightViewMode = UITextFieldViewMode.whileEditing
        
        // add a label to the left view
        let customLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        customLabel.text = "Card"
        creditCardTextField.leftView = customLabel
        creditCardTextField.leftViewMode = UITextFieldViewMode.always
        
        // add show/hide right view show hide text field
        showHideButton = UIButton(type: .custom)
        showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        showHideButton.setTitle("Show", for: .normal)
        showHideButton.setTitleColor(UIColor.orange, for: .normal)
        showHidePasswordTF.isSecureTextEntry = true
        showHideButton.addTarget(self, action: #selector(didTaponShowHideButton(_:)), for: .touchUpInside)
        showHidePasswordTF.rightView = showHideButton
        showHidePasswordTF.rightViewMode = .whileEditing
    }
    
    @objc func didTap(_ sender : UIButton) {
        print("Tapped on a button")
    }
    
    @objc func didTaponShowHideButton(_ sender : UIButton) {
        showHidePasswordTF.isSecureTextEntry = !showHidePasswordTF.isSecureTextEntry
        showHideButton.setTitle(showHidePasswordTF.isSecureTextEntry ? "Show" : "Hide", for: .normal)
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
        if textField == creditCardTextField {
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
        } else if textField == showHidePasswordTF /* https://stackoverflow.com/questions/34922331/getting-and-setting-cursor-position-of-uitextfield-and-uitextview-in-swift*/ {
            if var presentText = textField.text {
                presentText = (presentText as NSString).replacingCharacters(in: range, with: string)
                textField.text = presentText
                
                // any change of text in middle will place carriage at the end of text. to avoid these, set the proper selectedTextRange
                let selectedRange = NSMakeRange(range.location + string.count, 0)
                let from = textField.position(from: textField.beginningOfDocument, offset:selectedRange.location)
                let to = textField.position(from: from!, offset:selectedRange.length)
                textField.selectedTextRange = textField.textRange(from: from!, to: to!)
                
                print("Begin Position \(textField.beginningOfDocument)")
                print("End Position \(textField.endOfDocument)")
                print("Selected Range \(String(describing: textField.selectedTextRange?.start)) \(String(describing: textField.selectedTextRange?.end))")
            }
            return false
        }
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Textfield ended editing")
    }
}


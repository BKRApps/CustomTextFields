//
//  OTPTextField.swift
//  CustomTextField
//
//  Created by kumar reddy on 27/01/18.
//  Copyright © 2018 kumar reddy. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
final class OTPTextField : UITextField {
    
    var layerWidth : CGFloat = 0
    var numberSpacesRequired : Int = 0
    
    @IBInspectable var minSpaceInBetween: Int = 10
    @IBInspectable var otpLength = 4 {
        didSet {
            let validRect = textRect(forBounds: bounds)
            layerWidth = (validRect.width - CGFloat(((otpLength+1 ) * minSpaceInBetween )))/CGFloat(otpLength)
            let spaceString = "  "
            // find the size required for empty string.
            let attributes = [NSAttributedStringKey.font : self.font ?? UIFont.systemFont(ofSize: 15.0)]
            let spaceSize = spaceString.size(withAttributes: attributes)
            // find the size required for number string 
            let numberString = "1"
            let numberSize = numberString.size(withAttributes: attributes)
            numberSpacesRequired = Int((layerWidth-numberSize.width)/spaceSize.width)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customInit()
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: self)
        appendSpaces()
    }
    

    private func customInit(){
        otpLength = 4
        createALayer(xPosition: 10)
        createALayer(xPosition: 10 + layerWidth + 10)
        keyboardType = .numberPad
    }
    
    @objc func textfieldDidChange(_ sender : NSNotification) {
        let _ = sender.object as! UITextField
        appendSpaces()
    }
    
    func appendSpaces() {
        for _ in 0..<numberSpacesRequired/2 {
            text?.append("  ")
        }
    }
    
    func createALayer(xPosition:CGFloat) {
        let layer1 = CALayer()
        layer1.frame = CGRect(x: xPosition, y: frame.size.height-2, width: layerWidth, height: 2)
        layer1.backgroundColor = UIColor.red.cgColor
        layer.addSublayer(layer1)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 0)
    }
}

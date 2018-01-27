//
//  LabelTextField.swift
//  CustomTextField
//
//  Created by kumar reddy on 27/01/18.
//  Copyright © 2018 kumar reddy. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
final class LabelTextField : UITextField {
    
    let placeHolderLabel : UILabel = UILabel()
    var placeHolderFont: UIFont?
    var activeLayer : CALayer?
    var inActiveLayer : CALayer?
    
    override func draw(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: rect.size.width, height: rect.size.height))
        if self.subviews.contains(placeHolderLabel) {
            //nothing
        }else{
            placeHolderLabel.frame = frame.insetBy(dx: 0, dy: 14)
            placeHolderLabel.text = "PlaceHolder "
            placeHolderLabel.textColor = UIColor.gray
//            placeHolderLabel.backgroundColor = UIColor.red
            placeHolderLabel.sizeToFit()
            self.placeHolderFont = placeHolderLabel.font
            placeHolderLabel.font = UIFont(name: (self.placeHolderFont?.fontName)!, size: (self.placeHolderFont?.pointSize)!*1.0)
            addSubview(placeHolderLabel)
            activeLayer = CALayer()
            inActiveLayer = CALayer()
            layer.addSublayer(activeLayer!)
            layer.addSublayer(inActiveLayer!)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if (newSuperview != nil) {
            NotificationCenter.default.addObserver(self, selector: #selector(beginEditing1), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(endEditing1), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
        }
    }
    
    @objc func beginEditing1() {
        if text?.isEmpty ?? false {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.placeHolderLabel.frame.origin = CGPoint(x: 0, y: 4)
                self.placeHolderLabel.font = UIFont(name: (self.placeHolderFont?.fontName)!, size: (self.placeHolderFont?.pointSize)!*0.8)
            }), completion: { _ in
            })
            self.activeLayer?.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
            self.activeLayer?.backgroundColor = UIColor.red.cgColor
            self.inActiveLayer?.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 0, height: 1)
            self.inActiveLayer?.backgroundColor = UIColor.gray.cgColor

        }
    }
    
    @objc func endEditing1() {
        if text?.isEmpty ?? false {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.placeHolderLabel.frame.origin = CGPoint(x: 0, y: 14)
                self.placeHolderLabel.font = UIFont(name: (self.placeHolderFont?.fontName)!, size: (self.placeHolderFont?.pointSize)!*1.0)
                self.placeHolderLabel.alpha = 1.0
            }), completion: { _ in
            })
        }
        self.activeLayer?.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 0, height: 1)
        self.activeLayer?.backgroundColor = UIColor.red.cgColor
        self.inActiveLayer?.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.inActiveLayer?.backgroundColor = UIColor.gray.cgColor
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
        return bounds.offsetBy(dx: 0, dy: 12)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
        return bounds.offsetBy(dx: 0, dy: 12)
    }
}

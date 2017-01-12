//
//  OneDigitTextField.swift
//  sportshub
//
//  Created by wael ibrahim on 12/26/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//

import UIKit

class OneDigitTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable var allowedChars: Int = 1
    
    @IBOutlet open weak var nextResponderField: UIResponder?
    
    public var verifyDelegate :OTPVerifyDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
        self.font =  UIFont(name: (self.font?.fontName)!, size:32)!
        keyboardType = UIKeyboardType.numberPad
        addDoneButtonOnKeyboard()
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        autocorrectionType = .no
        self.font =  UIFont(name: (self.font?.fontName)!, size:32)!
        keyboardType = UIKeyboardType.numberPad
        addDoneButtonOnKeyboard()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        // if length is allowedChars then move to next
        if (text.utf16.count < allowedChars  && string.utf16.count == allowedChars){
            textField.text = string
            nextResponderField?.becomeFirstResponder()
            return false
        }
        return newLength <= allowedChars // Bool
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Vertify OTP", style: UIBarButtonItemStyle.done, target: self, action: #selector(OneDigitTextField.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.resignFirstResponder()
        verifyDelegate?.verify()
    }
    
}

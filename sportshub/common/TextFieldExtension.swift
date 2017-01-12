//
//  StringExtension.swift
//  sportshub
//
//  Created by wael ibrahim on 12/28/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//

import Foundation
import UIKit

extension UITextField
{
    func setBottomBorder()
    {
        self.borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(5.0)
        self.backgroundColor = UIColor.clear
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        //self.layer.masksToBounds = true
    }
    
}

//
//  StringExtension.swift
//  sportshub
//
//  Created by wael ibrahim on 12/28/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//

import Foundation

extension String {
    
    //validate PhoneNumber
    var isPhoneNumber: Bool {
        //let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let PHONE_REGEX = "^\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
        
    }
}

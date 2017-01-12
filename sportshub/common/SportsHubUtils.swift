//
//  OneDigitTextField.swift
//  sportshub
//
//  Created by wael ibrahim on 12/26/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//

import Foundation

class SportsHubUtils{
    
    static func formatDate(dateString:String,fromFormat:String,toFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date!)
    }
}

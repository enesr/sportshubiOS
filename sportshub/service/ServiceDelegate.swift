//
//  SportsHubService.swift
//  sportshub
//
//  Created by wael ibrahim on 12/25/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//

import Foundation


protocol ServiceDelegate  {
    func showRequestOTPError(response : [String: String])
    func receivedOTP(response : [String: String])
}


//
//  SportsHubService.swift
//  sportshub
//
//  Created by wael ibrahim on 12/25/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//

import Foundation


class SportsHubService  {
    static let sharedInstance = SportsHubService()
    let baseURL : String = "http://localhost:1337"
    
    func requestOTP(mobile : String,delegate : ServiceDelegate!) -> Bool{
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: baseURL + "/registeration/requestOTP?mobile=" + mobile )!
        let semaphore = DispatchSemaphore(value: 0)
        
        var responseData = [String: Any]()
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            defer {
                semaphore.signal()
            }
            if error != nil {
                print(error!.localizedDescription)
                responseData = ["response":"error","message":"Network Error"]
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        responseData = json
                    } else {
                        responseData = ["response":"error","message":"Error receving server response"]
                    }
                    
                } catch {
                    responseData = ["response":"error","message":"Unknown Error"]
                    print("error in JSONSerialization")
                }
                
            }
        })
        task.resume()
        semaphore.wait()
        // logic
        // {"response":"error", "message" : "Error validating mobile!"}
        // {"response":"already_registered", "message" : "This mobile is already registered!"}
        // {"response":"error", "message" : "Can't register mobile, try again later","mobile": mobile}
        // {"response":"otp_sent", "message" : "OTP is sent to mobile","otp": otp}
        print(responseData)
        if(responseData["response"]! as! String != "otp_sent"){
            if(delegate != nil) {
                delegate.showRequestOTPError(response: responseData as! [String:String])
            }
            return false
        }
        else {
            if(delegate != nil) {
                delegate.receivedOTP(response: responseData as! [String:String])
            }
            return true
        }
        
        
    }
}


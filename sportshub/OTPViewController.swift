//
//  OTPViewController.swift
//  sportshub
//
//  Created by wael ibrahim on 12/26/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//


import UIKit

class OTPViewController: UIViewController,OTPVerifyDelegate{
    
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var otpTextField4: UITextField!

    @IBOutlet var otpTextField3: UITextField!
    @IBOutlet var otpTextField1: UITextField!
    
    @IBOutlet var otpTextField2: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneLabel.text = SportsHubGlobals.phone
        // Do any additional setup after loading the view, typically from a nib.
        if let otp1 = otpTextField1 as? OneDigitTextField {
            otp1.verifyDelegate = self;
        }
        if let otp2 = otpTextField2 as? OneDigitTextField {
            otp2.verifyDelegate = self;
        }
        if let otp3 = otpTextField3 as? OneDigitTextField {
            otp3.verifyDelegate = self;
        }
        if let otp4 = otpTextField4 as? OneDigitTextField {
            otp4.verifyDelegate = self;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verify(){
        //print(otpTextField1.text! + otpTextField2.text!+otpTextField3.text!+otpTextField4.text!)
        let otp = otpTextField1.text! + otpTextField2.text!+otpTextField3.text!+otpTextField4.text!
        print(otp)
        print(SportsHubGlobals.otp)
        if(otp == SportsHubGlobals.otp){
            performSegue(withIdentifier: "showProfile", sender: nil)
        } else {
            self.view.window!.makeToast(message: "Invalid OTP", duration: 2,  position: "top" as AnyObject )
        }
    }
    
   }

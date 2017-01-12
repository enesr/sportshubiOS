//
//  RegViewController.swift
//  sportshub
//
//  Created by wael ibrahim on 12/26/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//


import UIKit

class RegViewController: UIViewController,UITextFieldDelegate ,EMCCountryDelegate,ServiceDelegate{
    @IBOutlet var phoneTextField: UITextField!

    @IBOutlet weak var otpRequestButton: UIButton!
    @IBOutlet var countryFlagImg: UIImageView!
    @IBOutlet var countryLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        phoneTextField.delegate=self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func requestOTP(_ sender: UIButton) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // open country list
        if (segue.identifier == "openCountryPicker") {
            let countryPicker = segue.destination as! EMCCountryPickerController
            countryPicker.showFlags = true
            countryPicker.countryDelegate = self
            countryPicker.drawFlagBorder = true
            countryPicker.flagBorderColor = UIColor.gray
            countryPicker.flagBorderWidth = 0.5
        }
   
    }

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        // mobile number validation
        if(identifier == "otpVerification"){
            let phoneNumber = phoneTextField.text! as String
            if(!phoneNumber.isPhoneNumber){
                self.view.endEditing(true)
                //self.view.window!.makeToast(message: "Invalid Mobile Number")
                self.view.window!.makeToast(message: "Invalid Mobile Number", duration: 2,  position: "top" as AnyObject )
                return false
            }
            else {
                // submit mobile number and generate OTP
                return SportsHubService.sharedInstance.requestOTP(mobile: phoneNumber,delegate: self)
            }
        }
        return true
    }
    
    
    func countryController(_ sender: Any, didSelect chosenCountry: EMCCountry){
        self.dismiss(animated: true, completion: { _ in })
        self.countryLabel.text = chosenCountry.countryCode
        let imagePath = "EMCCountryPickerController.bundle/" + chosenCountry.countryCode
        let image = UIImage(named: imagePath, in: Bundle(for: EMCCountryPickerController.classForCoder()), compatibleWith: nil)
        self.countryFlagImg.image = image
        self.countryFlagImg.layer.cornerRadius = 15
        self.countryFlagImg.layer.masksToBounds = true
    }
    
    // OTP Delegate methods
    func showRequestOTPError(response : [String: String]){
        self.view.window!.makeToast(message: response["message"]!, duration: 2,  position: "top" as AnyObject )
    }
    
    func receivedOTP(response : [String: String]){
        SportsHubGlobals.otp  = response["otp"]!
        SportsHubGlobals.phone = phoneTextField.text!
        
    }
    
   }



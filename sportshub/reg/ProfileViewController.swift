//
//  ProfileViewController.swift
//  sportshub
//
//  Created by wael ibrahim on 12/26/16.
//  Copyright © 2016 Sports Hub. All rights reserved.
//


import UIKit

class ProfileViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var birthDateTextField: UITextField!
    
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var genderSegment: TTSegmentedControl!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var fbContainer: UIView!
    
    let imagePicker = UIImagePickerController()
    let datePickerView = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        birthDateTextField.delegate = self
        
        genderSegment.itemTitles = ["Male","Female"]
        genderSegment.frame = CGRect(x: 50, y: 200, width: 100, height: 50)
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        birthDateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        imagePicker.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // fill sports grid
        
    }
    
    @IBAction func importFromFacebook(_ sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email","user_birthday"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, birthday, gender, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let result = result as? NSDictionary
                    self.firstNameTextField.text = result?["first_name"] as? String
                    self.lastNameTextField.text = result?["last_name"] as? String
                    let gender = result?["gender"] as? String
                    let picture = result?["picture"] as? NSDictionary
                    let data = picture?["data"] as? NSDictionary
                    let pictureURL = data?["url"] as? String
                    self.profileImageView.downloadedFrom(link: pictureURL!)
                    // birthday URL "12/15/1973";
                    let birthDay = result?["birthday"] as? String
                    self.birthDateTextField.text = SportsHubUtils.formatDate(dateString: birthDay!, fromFormat: "MM/dd/yyyy", toFormat: "MMM dd, yyyy")
                    if(gender=="male")
                    {
                        self.genderSegment.selectItemAt(index: 0)
                    } else {
                        self.genderSegment.selectItemAt(index: 1)
                    }
                }
            })
        }
    }
    
    func imageTapped(img: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]) {
        if let pickedImage = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func birthDateEditing(_ sender: UITextField) {
        datePickerView.isHidden = false
    }
    
    
    @IBAction func birthDateEndEditing(_ sender: UITextField) {
        datePickerView.isHidden = true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        birthDateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    
   }

//
//  ChangePasswordViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 08/02/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ChangePasswordViewController: UIViewController {
    
    
    var alertController = UIAlertController()
     var validation = Validation()
    @IBOutlet weak var OldPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    
//    @IBAction func WhenYesNoSegMentControllPressed(_ sender: UISegmentedControl) {
//        var  value  = (agreementSegmentedControll.selectedSegmentIndex == 0) ? false : true
//
//        submitButton.isHidden = value
//    }
    
//    @IBAction func WhenReadAgreementWasPressed(_ sender: UIButton) {
//        
//    }
    
    
    
    @IBAction func WhenSubmitButtonWasPressed(_ sender: UIButton) {
        let emailIdUserDefaults =  UserDefaults.standard.string(forKey: "emailid")
        let oldPasswordUserDefault = UserDefaults.standard.string(forKey: "password")
        
        let newPasswordString = newPassword.text!
        let oldPasswordString = OldPassword.text!
        let confirmPasswordString = confirmPassword.text!
      
        // Validation For Password
        if oldPasswordString != oldPasswordUserDefault {
          displayAlertMessage(messageToDisplay: "Please Enter the correct Old Password")
              return
        }
        
        // validation for Password TextField
               let isValidatePassword = self.validation.validatePassword(password: newPasswordString)
                                                   if (isValidatePassword == false) {
                                               print("Incorrect Password Format")
                                           //this code is working fine can be implemented further
                                                       displayAlertMessage(messageToDisplay: "Password should contain minimum 8 characters at least 1 Alphabet and 1 Number")
                                                       return
                                                   }
               
               
               // To check whether the password field is empty
               if newPasswordString == "" {
                   displayAlertMessage(messageToDisplay: "Please Enter the Password")
                   return
               }
               // To check whether the password and confirm password match
               if newPasswordString != confirmPasswordString {
                  
                   displayAlertMessage(messageToDisplay: "Password Field and Confirm Field does not match")
                   return
                   
               }
        
        // Database function to uodate in the dataBase
      let created =   DatabaseManager.shared.updatePassword(emailId: emailIdUserDefaults!, Oldassword: oldPasswordUserDefault!, newPassword: newPasswordString)
        print ("created for chsngePassword" , created)
         
        // Alert for password Change successfully
         alertController   = UIAlertController(title: "Alert",
                                                        message: "Password changed successfully", preferredStyle: .alert)
                
        
        let OKAction = UIAlertAction(title : "OK", style : .default){
                   (action :UIAlertAction) in
           // going back Home View Controller
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                             vc.modalPresentationStyle = .fullScreen
                             self.present(vc, animated: true)
                  
                   
                   
                   //Code in this block wiil trigger whern OK is pressed
                  
                   print("OK button is tapped");
               }
               alertController.addAction(OKAction)
               self.present(alertController, animated: true,completion: nil)

        
        
        
        
        
    }
    
    func displayAlertMessage(messageToDisplay : String)
    {
        let alertController = UIAlertController(title: "Alert",
                                                message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title : "Ok", style : .default){
            (action :UIAlertAction) in
          
            
            print ("Ok Button Pressed ")
           
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true,completion: nil)
        
        
    }
    
    
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                      vc.modalPresentationStyle = .fullScreen
                      self.present(vc, animated: true)
        
    }
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        
       let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
              vc.modalPresentationStyle = .fullScreen
              present(vc, animated: true, completion: nil)
    }
    
    // done buton for KeyBoard
       func doneButtonForKeyboard(){
              let toolbar = UIToolbar()
              toolbar.sizeToFit()
              
              let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
              
              let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
              
              
              toolbar.setItems([flexibleSpace,doneButton], animated: false)
              
           OldPassword.inputAccessoryView = toolbar
           newPassword.inputAccessoryView = toolbar
        confirmPassword.inputAccessoryView = toolbar
              
             }
          // for keyBoard Done Clicked
          @objc func doneClicked(){
              view.endEditing(true)
          }
      
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

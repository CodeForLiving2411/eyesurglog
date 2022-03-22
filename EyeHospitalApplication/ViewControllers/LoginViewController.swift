//
//  LoginViewController.swift
//  EyeHospitalApplication (Surg Log App )
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit



@available(iOS 13.0, *)
class LoginViewController: UIViewController , UITextFieldDelegate {
    var registrationDataList : [RegistrationModel]?
    var validation = Validation()
//   var regDataToHome = RegistrationModel()
   
   
    static var counter = 1
    var loginValue = 0
    var noOfReg = 0
    var rememberMeStatus = 1
    @IBOutlet var avoidingView: UIView!
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    @IBOutlet weak var remenberMeSwitch : UISwitch!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        print("login Value" , loginValue)
       
        var registrationInfo = RegistrationModel()
        registrationInfo.firstName = "Bishal"
        registrationInfo.lastName = "Bhandari"
        registrationInfo.emailid = "thebishalbhandari@gmail.com"
        registrationInfo.employeeCode = "Wills Eye Hospital"
        registrationInfo.password = "abhi2311"
        registrationInfo.securityQuestion = "What primary school did you attend?"
        registrationInfo.answer = "Rai School"
    
        
// creating on account for testing
       
        DatabaseManager.shared.createDatabase()
        DatabaseManager.shared.createDemographics1Table()
        DatabaseManager.shared.createDemographics2Table()
        DatabaseManager.shared.createSurguryTable()
        DatabaseManager.shared.createCameraImageTable()
           
        // getting all the data for checking the email and password 
           noOfReg = DatabaseManager.shared.NumberOfRegistrations()
           print("noOFRegistrations" , noOfReg)
        if noOfReg == 0 {
            let inserted = DatabaseManager.shared.insertRegistrationData(registrationInfo)
                       print("inserted" , inserted)
            registerButton.isHidden = false
        }
        else if  noOfReg == 1 {
            registerButton.isHidden = false
            
        }
       
        else   {
            registerButton.isHidden = true
        }
        
        
         registrationDataList = try! DatabaseManager.shared.loadRegistrationData()
         
        
        let statusRemenberMeDefaults =  UserDefaults.standard.integer(forKey: "statusRememberMe")
        
        print("remember me status " ,statusRemenberMeDefaults )
               
               if statusRemenberMeDefaults == 1 {
                   let emailRememberMeDefaults = UserDefaults.standard.string(forKey: "emailRememberMe")!
                  //  let passwordRememberMeDefaults = UserDefaults.standard.string(forKey: "passwordRememberMe")!
                   loginEmailTextField.text = emailRememberMeDefaults
                //   passwordTextField.text = passwordRememberMeDefaults
                   remenberMeSwitch.isOn = true
                   
                   
                   
               }else {
                   loginEmailTextField.text = ""
                 //  passwordTextField.text = ""
                   remenberMeSwitch.isOn = false
                  
               }
               
    }
       
            
        
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        loginButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
        loginPasswordTextField.isSecureTextEntry = true
        doneButtonForKeyboard()
        // default state of the switch (Remember me )
        remenberMeSwitch.isOn = false 
       
        
      //   registrationDataList = try! DatabaseManager.shared.loadRegistrationData()
        
        //-------------------------------------------------------
       
       
         
       
    }
    // done button for keyboard 
    func doneButtonForKeyboard(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        loginEmailTextField.inputAccessoryView = toolbar
        loginPasswordTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    
    // To Validate All the Fields on Login page
   func ValidateAllfields() -> Void {
    
  
     guard let emailid = loginEmailTextField.text else { return}
    
     guard let password = loginPasswordTextField.text else { return}
    
    
    if loginEmailTextField.text! == "" {
           
           displayAlertMessage(messageToDisplay: "Please enter the Email Id")
           return
       }
    // validation for Email Name
    let isValidateLoginEmail = self.validation.validateEmailId(emailID: emailid )
                   if (isValidateLoginEmail == false) {
                       print("Incorrect Email")  // this code is working fine can be implemented further
                       displayAlertMessage(messageToDisplay: "Incorrect Email ID")
                       return
                   }
    
    if loginPasswordTextField.text! == "" {
        
        displayAlertMessage(messageToDisplay: "Please enter the Password")
                             return
    }
    
        
    
    
    }
    
    
 
//    @IBAction func WhenRememberMeWasPressed(_ sender: UISwitch) {
//        
//        if sender.isOn {
//                   print("switch is on")
//                   rememberMeStatus = 1
//                   var emailRememberMe = loginEmailTextField.text
//                //   var passwordRememberMe = passwordTextField.text
//                   var statusRememberMe = 1
//                   
//                   UserDefaults.standard.set(emailRememberMe, forKey: "emailRememberMe" )
//                  // UserDefaults.standard.set(passwordRememberMe, forKey: "passwordRememberMe" )
//                   UserDefaults.standard.set(statusRememberMe, forKey: "statusRememberMe" )
//                   print("user name saveed")
//                   
//                   
//               }else {
//                    print("switch is off")
//                    rememberMeStatus = 0
//                   var emailRememberMe = ""
//                            //  var passwordRememberMe = ""
//                   var statusRememberMe = 0
//                              
//                   UserDefaults.standard.set(emailRememberMe, forKey: "emailRememberMe" )
//                           //   UserDefaults.standard.set(passwordRememberMe, forKey: "passwordRememberMe" )
//                   UserDefaults.standard.set(statusRememberMe, forKey: "statusRememberMe" )
//                    print("user name not  saveed")
//                   
//                   
//               }
//        
//        
//    }
//    
//    func rememberMeFunction() {
//        
//        if rememberMeStatus == 1 {
//                   var emailRememberMe = loginEmailTextField.text
//                  // var passwordRememberMe = passwordTextField.text
//                   var statusRememberMe = 1
//                   
//                   UserDefaults.standard.set(emailRememberMe, forKey: "emailRememberMe" )
//                //   UserDefaults.standard.set(passwordRememberMe, forKey: "passwordRememberMe" )
//                   UserDefaults.standard.set(statusRememberMe, forKey: "statusRememberMe" )
//                   
//                   
//                   
//               }else {
//                   
//                   
//                    var emailRememberMe = ""
//                             // var passwordRememberMe = ""
//                    var statusRememberMe = 0
//                              
//                    UserDefaults.standard.set(emailRememberMe, forKey: "emailRememberMe" )
//                           //   UserDefaults.standard.set(passwordRememberMe, forKey: "passwordRememberMe" )
//                    UserDefaults.standard.set(statusRememberMe, forKey: "statusRememberMe" )
//                
//               }
//    }
    
    
    func handleRememberMeInitial(){
        
        if remenberMeSwitch.isOn {
                          print("switch is on")
                          rememberMeStatus = 1
                          var emailRememberMe = loginEmailTextField.text
                       //   var passwordRememberMe = passwordTextField.text
                          var statusRememberMe = 1
                          
                          UserDefaults.standard.set(emailRememberMe, forKey: "emailRememberMe" )
                         // UserDefaults.standard.set(passwordRememberMe, forKey: "passwordRememberMe" )
                          UserDefaults.standard.set(statusRememberMe, forKey: "statusRememberMe" )
                          print("user name saveed")
                          
                          
                      }else {
                           print("switch is off")
                           rememberMeStatus = 0
                          var emailRememberMe = ""
                                   //  var passwordRememberMe = ""
                          var statusRememberMe = 0
                                     
                          UserDefaults.standard.set(emailRememberMe, forKey: "emailRememberMe" )
                                  //   UserDefaults.standard.set(passwordRememberMe, forKey: "passwordRememberMe" )
                          UserDefaults.standard.set(statusRememberMe, forKey: "statusRememberMe" )
                           print("user name not  saveed")
                          
                          
                      }
    }
    
    // What happens when Login button is Pressed
    @IBAction func WhenLoginButtonWasPressed(_ sender: UIButton) {
        var status = 0
           ValidateAllfields()
       
        
        if registrationDataList!.count > 0  {
         
          
          for registrationData in registrationDataList! {
              
              if registrationData.emailid == loginEmailTextField.text! && registrationData.password == loginPasswordTextField.text! {
                
                UserDefaults.standard.set(registrationData.firstName, forKey: "fName")
                UserDefaults.standard.set(registrationData.lastName, forKey: "lName")
                UserDefaults.standard.set(registrationData.employeeCode, forKey: "empCode") // emp code is Hospital or Asc Name 
                UserDefaults.standard.set(registrationData.emailid , forKey: "emailid")
                UserDefaults.standard.set(registrationData.password , forKey: "password")
              
                  status = 1
                
              
          }
//
        
          }
        
        if status == 1 {
            
        handleRememberMeInitial()
          performSegue(withIdentifier: "loginToDashboard", sender: self)
           
        }
        else
        {
             displayAlertMessage(messageToDisplay: "Please enter correct Email/Password")
         return
            
        }
        }
            
        else
        {
           displayAlertMessage(messageToDisplay: "Please Register To Sign In")
        }
        
    }
    
    func displayAlertMessage(messageToDisplay : String)
       {
           let alertController = UIAlertController(title: "Alert",
                                                   message: messageToDisplay, preferredStyle: .alert)
           
           let OKAction = UIAlertAction(title : "Ok", style : .default){
               (action :UIAlertAction) in
            
              
           }
          alertController.addAction(OKAction)
           self.present(alertController, animated: true,completion: nil)
           
           
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "loginToDashboard" {
        let vc = segue.destination as! HomeViewController
                  
//
    }
    
    
      
    
}

}

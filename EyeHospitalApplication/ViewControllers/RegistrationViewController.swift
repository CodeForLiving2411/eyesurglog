//
//  RegistrationViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
import DropDown



 @available(iOS 13.0, *)
class RegistrationViewController: UIViewController , UITextFieldDelegate {
   
    var dropDown = DropDown()
    let xPos : CGFloat = 0
    var yPos : CGFloat = 0
    var validation = Validation()
    var alertControllerForSubmitButton  = UIAlertController()
    var selectedQuestion = ""
    var questionsList = ["What primary school did you attend?" , "In what town or city was your first full time job?" ,"In what town or city did you meet your spouse/partner?",
        "What is the middle name of your oldest child?",
        "What is your spouse or partner's mother's maiden name?" , "What is your Nickname"]
    
    
    
    @IBOutlet weak var selectQuestionUIView: UIView!
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
  
    @IBOutlet weak var lastNameTextField: UITextField!
    
   
    @IBOutlet weak var emailIDTextField: UITextField!
    
    
    @IBOutlet weak var employeeCodeTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBOutlet weak var securityQuestionLabel: UILabel!
    
    @IBOutlet weak var securityAnswerTextField: UITextField!
    
    @IBOutlet weak var agreementAcceptButton: UISegmentedControl!
    
    @IBOutlet var avoidingView: UIView!
    override func viewWillAppear(_ animated: Bool) {
    
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light    
        doneButtonForKeyboard()
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        securityQuestionLabel.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        securityQuestionLabel.layer.borderWidth = 3.0
       
        
        let gestureSelectYourQuestion = UITapGestureRecognizer(target: self , action: #selector(self.WhenSelectYourQuestionLabelWasClicked))
                      self.selectQuestionUIView.addGestureRecognizer(gestureSelectYourQuestion)
        
        
    }
    
    
    @objc func WhenSelectYourQuestionLabelWasClicked() {
        
        print("security View Click clicked")
        
        dropDown.anchorView = securityQuestionLabel
                     dropDown.dataSource = questionsList
              dropDown.show()
                     
                     // Action triggered on selection
                     dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                      self.securityQuestionLabel.text = item
                      self.selectedQuestion = item
                      
                     }
        
    }
    
    @IBAction func WhenReadAgreementButtonWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AgreementViewController") as! AgreementViewController
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func AgreementconfirmSegmentControllWasPressed(_ sender: UISegmentedControl) {
    }
    
    
    @IBAction func registerDoctorButtonWasPressed(_ sender: UIButton) {
        
         //Validation of all the fields
       //  --------------------------------------------
         
         guard let fname = firstNameTextField.text else { return}
          
         guard let lname = lastNameTextField.text else { return}
        
         guard let emailid = emailIDTextField.text else { return}
         
         guard let empCode = employeeCodeTextField.text else { return}
         
         guard let password = passwordTextField.text else { return}
         
         guard let confirmPassword = confirmPasswordTextField.text else { return}
         guard let securityQues = securityQuestionLabel.text else { return }
         guard let securityAns = securityAnswerTextField.text else { return}
        
        
        
        
            
        
          
         // validation for First Name
        let isValidateFirstName =   self.validation.validateName(name: fname)
                       
                           if(isValidateFirstName == false)
                           {
                            print("Incorrect fName")
                             // this code is working fine can be implemented further
                            displayAlertMessage(messageToDisplay: "Incorrect First Name")
                            return
                        }
         
         // validation for Last Name
        
         let isValidateLastName = self.validation.validateName(name: lname)
                        if(isValidateLastName == false)
                        {
                            print("Incorrect Name")
                         // this code is working fine can be implemented further
                         displayAlertMessage(messageToDisplay: "Incorrect Last Name")
                 return
                        }
         // validation for Email Name
        let isValidateEmailName = self.validation.validateEmailId(emailID: emailid )
                               if (isValidateEmailName == false)
                               {
                                   print("Incorrect Email")
                                     //this code is working fine can be implemented further
                                   displayAlertMessage(messageToDisplay: "Incorrect Email ID")
                                 
                                  return
                               }
         
         // validation for Employee Code
//        let isValidateEmpCode = self.validation.validateName(name: empCode)
//                                      if (isValidateEmpCode == false) {
//                                          print("Incorrect Emp Code")
//                                      // this code is working fine can be implemented further
//                                          displayAlertMessage(messageToDisplay: "Incorrect Emp Code")
//                                     return
//                                      }
       // validation for affiliation (name in the database is given empcode)
        if empCode == "" {
            displayAlertMessage(messageToDisplay: "Please fill the Affiliation")
           return
        }
        
         
         // validation for Password TextField
        let isValidatePassword = self.validation.validatePassword(password: password)
                                             if (isValidatePassword == false) {
                                         print("Incorrect Password Format")
                                     //this code is working fine can be implemented further
                                                 displayAlertMessage(messageToDisplay: "Password should contain minimum 8 characters at least 1 Alphabet and 1 Number")
                                                 return
                                            
        }
         
         
         // To check whether the password field is empty
         if password == "" {
             displayAlertMessage(messageToDisplay: "Please Enter the Password")
             return
         }
         // To check whether the password and confirm password match
         if password != confirmPassword {
            
             displayAlertMessage(messageToDisplay: "Password Field and Confirm Field does not match")
             return
             
         }
         
        
       //  --------------------------------------------
        
    
           let registrationInfo = RegistrationModel(firstName: fname, lastName: lname, emailid: emailid, employeeCode: empCode, password: password ,securityQuestion: selectedQuestion , answer: securityAns)
      

        // DatabaseManager.shared.createDatabase()
        if agreementAcceptButton.selectedSegmentIndex == 0 {
           displayAlertMessage(messageToDisplay: "PLease accept the agreement")
           return
            
        }
        else{
        let inserted = DatabaseManager.shared.insertRegistrationData(registrationInfo)
        print("inserted" , inserted)
        
        if inserted == true {
       alertControllerForSubmitButton   = UIAlertController(title: "Alert",
                                                     message: "Registration done successfully", preferredStyle: .alert)
             
            
            let OKAction = UIAlertAction(title : "OK", style : .default){
                 (action :UIAlertAction) in
                 
//                self.performSegue(withIdentifier: "registrationToLoginVC", sender: self)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                vc.loginValue = 1
                 
                 
                 //Code in this block wiil trigger whern OK is pressed
                
                 print("OK button is tapped");
             }
             alertControllerForSubmitButton.addAction(OKAction)
             self.present(alertControllerForSubmitButton, animated: true,completion: nil)
        
        }
        }
        
   }
    
    
    func doneButtonForKeyboard(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        lastNameTextField.inputAccessoryView = toolbar
        firstNameTextField.inputAccessoryView = toolbar
        emailIDTextField.inputAccessoryView = toolbar
        employeeCodeTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        confirmPasswordTextField.inputAccessoryView = toolbar
        securityAnswerTextField.inputAccessoryView = toolbar
        
       }
    
    @objc func doneClicked(){
        view.endEditing(true)
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
    
    func ValidateAllfields() -> Void {
        
        
        
        
        guard let fname = firstNameTextField.text else { return}
         
        guard let lname = lastNameTextField.text else { return}
       
        guard let emailid = emailIDTextField.text else { return}
        
        guard let empCode = employeeCodeTextField.text else { return}
        
        guard let password = passwordTextField.text else { return}
        
        guard let confirmPassword = confirmPasswordTextField.text else { return}
         
        // validation for First Name
        let isValidateFirstName =   self.validation.validateName(name: fname)
                      
                          if(isValidateFirstName == false)
                          {
                           print("Incorrect fName")
                            // this code is working fine can be implemented further
                           displayAlertMessage(messageToDisplay: "Incorrect First Name")
                           return
                       }
        
        // validation for Last Name
       
        let isValidateLastName = self.validation.validateName(name: lname)
                       if(isValidateLastName == false)
                       {
                           print("Incorrect Name")
                        // this code is working fine can be implemented further
                        displayAlertMessage(messageToDisplay: "Incorrect Last Name")
                        return
                       }
        // validation for Email Name
        let isValidateEmailName = self.validation.validateEmailId(emailID: emailid )
                              if (isValidateEmailName == false)
                              {
                                  print("Incorrect Email")
                                    //this code is working fine can be implemented further
                                  displayAlertMessage(messageToDisplay: "Incorrect Email ID")
                                
                                 return
                              }
        
        // validation for Employee Code
        let isValidateEmpCode = self.validation.validateName(name: empCode)
                                     if (isValidateEmpCode == false) {
                                         print("Incorrect Emp Code")
                                     // this code is working fine can be implemented further
                                         displayAlertMessage(messageToDisplay: "Incorrect Emp Code")
                                    return
                                     }
        
        // validation for Password TextField
        let isValidatePassword = self.validation.validatePassword(password: password)
                                            if (isValidatePassword == false) {
                                        print("Incorrect Password Format")
                                    //this code is working fine can be implemented further
                                                displayAlertMessage(messageToDisplay: "Password should contain minimum 8 characters at least 1 Alphabet and 1 Number")
                                                return
                                            }
        
        
        // To check whether the password field is empty
        if password == "" {
            displayAlertMessage(messageToDisplay: "Please Enter the Password")
            return
        }
        // To check whether the password and confirm password match
        if password != confirmPassword {
           
            displayAlertMessage(messageToDisplay: "Password Field and Confirm Field does not match")
            return
            
        }
        
        
        
        
        
    }
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//          if segue.identifier == "registrationToLoginVC" {
//
//               let vc = segue.destination as! LoginViewController
//          }
//
//
//           }

    
    
}
  
    


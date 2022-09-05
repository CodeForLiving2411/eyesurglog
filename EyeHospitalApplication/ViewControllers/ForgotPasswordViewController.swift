//
//  ForgotPasswordViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/02/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit
import DropDown

@available(iOS 13.0, *)
class ForgotPasswordViewController: UIViewController {
    
    var validation = Validation()
    
    var registrationDataList : [RegistrationModel]?

    @IBOutlet weak var emailIdTextField: UITextField!
    
    @IBOutlet weak var securityQuestionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var securityQuestionUIView: UIView!
    
//    var questionsList = ["What primary school did you attend?" , "In what town or city was your first full time job?" ,"In what town or city did you meet your spouse/partner?",
//       "What is the middle name of your oldest child?",
//         "What is your spouse or partner's mother's maiden name?" , "What is your Nickname"]
//
    var questionsList = ["What high school did you attend?" , "In what town or city was your first full time job?" ,"In what town did you meet your spouse/partner?",
        "What is the middle name of your oldest child?",
        "What is your mother's maiden name?" , "What is your Nickname?"]
    var dropDown = DropDown()
    
   
    
    //@IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButtonForKeyboard()
        
        let gestureSelectYourQuestion = UITapGestureRecognizer(target: self , action: #selector(self.WhenSelectYourQuestionLabelWasClicked))
                             self.securityQuestionUIView.addGestureRecognizer(gestureSelectYourQuestion)

        // Do any additional setup after loading the view.
    }
    
  @objc func WhenSelectYourQuestionLabelWasClicked() {
         
         print("security View Click clicked")
         
         dropDown.anchorView = securityQuestionTextField
                      dropDown.dataSource = questionsList
               dropDown.show()
                      
                      // Action triggered on selection
                      dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                       self.securityQuestionTextField.text = item
                   //    self.selectedQuestion = item
                       
                      }
         
     }
    
    
    @IBAction func WhenSubmitButtonWasPresed(_ sender: UIButton) {
        guard let emailId = emailIdTextField.text else {return}
        guard let securityQuestion = securityQuestionTextField.text else {return}
        guard let answer = answerTextField.text else {return}
       // To check Whether the emil field is empty or not
        if emailIdTextField.text! == "" {
            
            displayAlertMessage(messageToDisplay: "Please enter the Email Id")
            return
        }
       // validation for Email Name
          let isValidateLoginEmail = self.validation.validateEmailId(emailID: emailId )
                         if (isValidateLoginEmail == false) {
                             print("Incorrect Email")  // this code is working fine can be implemented further
                             displayAlertMessage(messageToDisplay: "Incorrect Email ID")
                             return
                         }
        
        // security QuestionField Validation
        if securityQuestionTextField.text == "" {
                   
                   displayAlertMessage(messageToDisplay: "Please select security question")
                   return
               }
        
        // security Answer Validation
        if answerTextField.text == "" {
            
            displayAlertMessage(messageToDisplay: "Please enter your answer")
                              return
                          }
        
        
        
        
        
        registrationDataList = DatabaseManager.shared.loadRegistrationData()
        var count = 0
        
        for registrationData in registrationDataList! {
            
           
            
            if registrationData.emailid!.lowercased() == emailId.lowercased() {
                print("emailid"  , registrationData.emailid!)
                print("security"  , securityQuestion)
                print("security"  , registrationData.securityQuestion!)
                print("answer"  , registrationData.answer!)
                
                
                if (registrationData.securityQuestion!.lowercased() == securityQuestion.lowercased() && registrationData.answer! == answer) {
                     count = 1
                    print("password is " , registrationData.password)
                
                    
                    let messageToDisplay = "Your password is \(registrationData.password!)"
                    
                    let alertController = UIAlertController(title: "Alert",
                                                                        message: messageToDisplay , preferredStyle: .alert)
                                
                                let OKAction = UIAlertAction(title : "Ok", style : .default){
                                    (action :UIAlertAction) in
                                    self.dismiss(animated: true, completion: nil)
                                 
                                   
                                }
                               alertController.addAction(OKAction)
                                self.present(alertController, animated: true,completion: nil)
                                
                    }
                              
                    }
           
                
        }
        
        
        if count == 0 {
            
            
            
                                print("Wrong Credentials")
                              //  resultLabel.text = "Sorry!!! Wrong Credentials. Please try Again!!"
            
                                let alertController = UIAlertController(title: "Alert",
                                                                                                       message: "Sorry!!! Wrong Credentials. Please try Again!!" , preferredStyle: .alert)
            
                                                               let OKAction = UIAlertAction(title : "Ok", style : .default){
                                                                   (action :UIAlertAction) in
                                                                self.emailIdTextField.text! = ""
                                                                self.answerTextField.text! = ""
                                                                self.securityQuestionTextField.text! = "Select the security Question"
            
            
            
                                                               }
                                                              alertController.addAction(OKAction)
                                                               self.present(alertController, animated: true,completion: nil)
            
            
            
            
                                
            
        }
    }
            
        
        
    // done buton for KeyBoard
    func doneButtonForKeyboard(){
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
           
           
           toolbar.setItems([flexibleSpace,doneButton], animated: false)
           
        emailIdTextField.inputAccessoryView = toolbar
        answerTextField.inputAccessoryView = toolbar
           
          }
       // for keyBorard Done Clicked
       @objc func doneClicked(){
           view.endEditing(true)
       }
      
    
    
    

    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
           
          dismiss(animated: true, completion: nil)
    }
    
    func displayAlertMessage(messageToDisplay : String)
          {
              let alertController = UIAlertController(title: "",
                                                      message: messageToDisplay, preferredStyle: .alert)
              
              let OKAction = UIAlertAction(title : "Ok", style : .default){
                  (action :UIAlertAction) in
               
                 
              }
             alertController.addAction(OKAction)
              self.present(alertController, animated: true,completion: nil)
              
              
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

//
//  ChangeHospitalNameViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/03/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ChangeHospitalNameViewController: UIViewController {
    
    @IBOutlet weak var hospitalNameTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    

    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                     vc.modalPresentationStyle = .fullScreen
                     present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func WhenSubmitButtonWasPressed(_ sender: UIButton) {
        
        guard  let hospitalName = hospitalNameTextField.text else {
            return
        }
        
        if hospitalName == "" {
            print("Enter Hospital Name")
            displayAlertMessage(messageToDisplay: "Pleae enter the Hospital /ASC Name")
            return
        }
        else {
            
              let email =  UserDefaults.standard.string(forKey: "emailid")
            var inserted = DatabaseManager.shared.updateHospital(emailId: email! , hospitalName: hospitalName)
            
            if inserted {
                 UserDefaults.standard.set(hospitalName , forKey: "empCode")
                
                displayAlertMessage(messageToDisplay: "Updated Successfully")
                
            }
            else {
                
                print("Not Updated the Hospital Name")
                
            }
        }
        
        
        
        
        
        
        
    }
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                     vc.modalPresentationStyle = .fullScreen
                     present(vc, animated: true, completion: nil)
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
      
    
   

}
            
             
              
    


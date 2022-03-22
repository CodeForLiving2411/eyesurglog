//
//  EyeProcedureViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/11/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class EyeProcedureViewController: UIViewController {
    
     var personUID = 0

    @IBOutlet weak var submitACaseLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var fellowEyeProceedureButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var goToMainMenuButton: UIButton!
    var alertController = UIAlertController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            
            
        }
        
        fellowEyeProceedureButton.isHidden = true
        goToMainMenuButton.isHidden = true
        
        submitButton.layer.cornerRadius = 5
        fellowEyeProceedureButton.layer.cornerRadius = 5
        goToMainMenuButton.layer.cornerRadius = 5
        
}
    
    
    
   
    // Currently does the action for Submit button
    @IBAction func WhenEyeProccedureNoButtonWasPressed(_ sender: UIButton) {
        
        backButton.isHidden = true
        fellowEyeProceedureButton.isHidden = false
        goToMainMenuButton.isHidden = false
        
        print("personID at Eye proccedure is" , personUID)
        
        // Demographics table status updated to "1"
        let updatedDemo1Status = DatabaseManager.shared.UpdateDemographics1StatusColumn(personUID)
        print(updatedDemo1Status)
        
        // Demographics1 table status updated to "1"
               let updatedDemo2Status = DatabaseManager.shared.UpdateDemographics2StatusColumn(personUID)
               print(updatedDemo2Status)
        
        // Surgery table status updated to "1"
                      let updatedSurgeryStatus = DatabaseManager.shared.UpdateSurgeryStatusColumn(personUID)
                      print(updatedSurgeryStatus)
        
        // CameraImage table status updated to "1"
                             let updatedCameraImageStatus = DatabaseManager.shared.UpdateCameraImageStatusColumn(personUID)
                             print(updatedCameraImageStatus)
        
        
      alertController   = UIAlertController(title: "Alert",
                                                message: "Case Successfully Logged", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title : "OK", style : .default){
            (action :UIAlertAction) in
            
//            self.performSegue(withIdentifier:             "caseLogToHomeVC", sender: self)
            self.submitButton.isHidden = true
            
            
            //Code in this block wiil trigger whern OK is pressed
           
            print("OK button is tapped");
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true,completion: nil)

    }
    
    
    @IBAction func WhenFellowEyeButtonWasPressed(_ sender: UIButton) {
        
         let tag = 1
         let vc = storyboard?.instantiateViewController(withIdentifier: "Demographics1_ViewController") as! Demographics1_ViewController
        vc.tempPersonID = self.personUID
        vc.tag = tag
        vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true, completion: nil)
               
        
    }
    
    
    @IBAction func WhenMainMenuButtonWasPreseed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               
               vc.modalPresentationStyle = .fullScreen
                      self.present(vc, animated: true, completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "caseLogToHomeVC" {
            
            if #available(iOS 13.0, *) {
                let vc = segue.destination as! HomeViewController
           
            }
        }
            
          
         }
    
    
  
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: Any) {
        
        let deleted = DatabaseManager.shared.deleteCameraImageTempDataWhenBactPressedAtFellowVC(withID: personUID)
                          
        print("deleted is" , deleted)
        dismiss(animated: true, completion: nil)
              
    }
    
        
    }
    


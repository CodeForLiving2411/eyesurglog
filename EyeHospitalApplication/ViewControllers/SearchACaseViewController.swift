//
//  SearchACaseViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 14/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

// extension for search a case details table View functions 
  


@available(iOS 13.0, *)
class SearchACaseViewController: UIViewController , UITextFieldDelegate  {
   
    var validation = Validation()
    @IBOutlet weak var surgeryDateTextField: UITextField!
    @IBOutlet weak var patientMrnTextField: UITextField!
    private var surgeryDatePicker: UIDatePicker?
     var patientSearchModelList: [PatientSearchModel]?   // list to fetch patient search details
    
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light    
        surgeryDateTextField.isHidden = true
        searchButton.layer.cornerRadius = 5 
        //searchDetailTableView.reloadData()
          doneButtonForKeyboard()
        

       
//        // Date picker for surgery Date
//                     // -----------------------------------------------
//                      surgeryDatePicker = UIDatePicker()
//                      surgeryDatePicker?.datePickerMode = .date
//                      surgeryDatePicker?.addTarget(self, action: #selector(surgeryDateChanged(surgeryDatePicker :)), for: .valueChanged )
//
//               surgeryDateTextField.inputView = surgeryDatePicker  // setting date picker in surgery date text field
//                      // -----------------------------------------------
        
      
    }
    // function to execute when surgery date is changed
    @objc func surgeryDateChanged(surgeryDatePicker : UIDatePicker){
             
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "MM/dd/yyyy"
              surgeryDateTextField.text = dateFormatter.string(from: surgeryDatePicker.date)
             
              doneButtonForKeyboard()
          }
    
    // Event handler for search button 
    @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
        
        var mrn = patientMrnTextField.text
                        let isValidateMrn = self.validation.validaPhoneNumber(phoneNumber: mrn!)
                                       if (isValidateMrn == false) {
                                           print("Incorrect MRN")
                                           displayAlertMessage(messageToDisplay: "Incorrect MRN")
                                           return
                               }

        
     //   let date: String = surgeryDateTextField.text!
        // mrn  = Int(patientMrnTextField.text!)
        do {
            
            patientSearchModelList =      try! DatabaseManager.shared.loadPatientSearchDetailsByMrn(withID: Int(mrn!)!)
        }
        catch{
                print(error.localizedDescription)
        }
   
        
        if patientSearchModelList == nil {
            print("No Data Found")
            
            displayAlertMessage(messageToDisplay: "No Data Found")
            
        }
        else{
             performSegue(withIdentifier: "searchtodetails", sender: self)
        }
            

      
           
      
    
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "searchtodetails" {
           let vc = segue.destination as! PatientSearchDetailsViewController
           vc.patientSearchModelList1 = patientSearchModelList
            vc.mrnId = patientMrnTextField.text!
            vc.viewControlerId = 1 
           vc.headingTittle = "Patient List(By MRN)"
        }
       }
    // done button for keyboard
    func doneButtonForKeyboard(){
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
           
           
           toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        
        surgeryDateTextField.inputAccessoryView = toolbar
        patientMrnTextField.inputAccessoryView = toolbar
         
           
          
       }
    
    func textFieldValidation() -> Void{
        // Validation for MRN (Medical Record Number)
              //
              let mrn = patientMrnTextField.text
        
        if mrn == "" {
            displayAlertMessage(messageToDisplay: "Please enter the MRN")
            
        }
        else{
              let isValidateMrn = self.validation.validaPhoneNumber(phoneNumber: mrn!)
                             if (isValidateMrn == false) {
                                 print("Incorrect MRN")
                                 displayAlertMessage(messageToDisplay: "Incorrect MRN")
                                 return
                     }
        }
    }
    
    
    
  // done for keyboard (Object C function )
     @objc func doneClicked(){
         view.endEditing(true)
     }
    func displayAlertMessage(messageToDisplay : String)
       {
           let alertController = UIAlertController(title: "Alert",
                                                   message: messageToDisplay, preferredStyle: .alert)
           
           let OKAction = UIAlertAction(title : "Ok", style : .default){
               (action :UIAlertAction) in
              //  self.dismiss(animated: true, completion: nil)
                
              
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
         dismiss(animated: true, completion: nil)
        
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

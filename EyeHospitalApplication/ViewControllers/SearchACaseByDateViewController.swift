//
//  SearchACaseByDateViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 24/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
import DateTextField

@available(iOS 13.0, *)
class SearchACaseByDateViewController: UIViewController , UITextFieldDelegate {
    

    @IBOutlet weak var selectDateTextField: DateTextField!
    
    @IBOutlet weak var selectEndDate: DateTextField!
    private var surgeryDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    
    @IBOutlet weak var searchButton: UIButton!
    var patientSearchModelList: [PatientSearchModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        selectDateTextField.dateFormat = .monthDayYear
        selectDateTextField.separator = "/"
        selectEndDate.dateFormat = .monthDayYear
        selectEndDate.separator = "/"
      
       
        selectDateTextField.dateFormat = .monthDayYear
        selectDateTextField.separator = "/"
        selectEndDate.dateFormat = .monthDayYear
        selectEndDate.separator = "/"
        getCurrentStartDate()
      //  Date Picker For selectDateTextField (Here the user enters the surgery date to get list the list of patient details)
        //-----------------------------------------------
        selectDateTextField.delegate = self
        surgeryDatePicker = UIDatePicker()
        surgeryDatePicker?.datePickerMode = .date
        surgeryDatePicker?.addTarget(self, action: #selector(surgeryDateChanged(surgeryDatePicker:)), for: .valueChanged )
               
               selectDateTextField.inputView = surgeryDatePicker
         //-----------------------------------------------
        
        selectEndDate.delegate = self
        endDatePicker = UIDatePicker()
        endDatePicker?.datePickerMode = .date
        endDatePicker?.addTarget(self, action: #selector(endDateChanged(endDatePicker:)), for: .valueChanged )
        selectEndDate.inputView = endDatePicker
        //-----------------------------------------------
               
       
        // Done button function for keyboard
        doneButtonForKeyboard()
      
        
    }
    
    // to get current date
    func getCurrentStartDate() {
           let currentDateFormatter = DateFormatter()
           currentDateFormatter.dateFormat = "MM/dd/yyyy"
           let strDate = currentDateFormatter.string(from: Date())
           selectDateTextField?.text = strDate
           selectEndDate?.text = strDate
       }
    
   
    @IBAction func WhenSearchByDateButtonWasPressed(_ sender: UIButton) {
        var startDate = selectDateTextField.text!
        var endDate   = selectEndDate.text!
        
         // validation for surgery start  date
         // -----------------------------------------------
         let selectDateString = startDate
         let selectDateFormatter = DateFormatter()
         selectDateFormatter.dateFormat = "MM/dd/yyyy"

         if selectDateFormatter.date(from: selectDateString) != nil {
             print("date is valid")
         } else {
             
             if selectDateString == "" {
                 displayAlertMessage(messageToDisplay: "Please enter the Start Date")
                                        
                 return
             }
             else{
               displayAlertMessage(messageToDisplay: "Please enter a valid End Date")
                          return
             }
            
            
         }
        
        // -----------------------------------------------
         
        // validation for surgery end date
               // -----------------------------------------------
               let endDateString = endDate
               let endDateFormatter = DateFormatter()
               endDateFormatter.dateFormat = "MM/dd/yyyy"

               if endDateFormatter.date(from: endDateString) != nil {
                   print("date is valid")
               } else {
                   
                   if endDateString == "" {
                       displayAlertMessage(messageToDisplay: "Please enter the End Date")
                                              
                       return
                   }
                   else{
                     displayAlertMessage(messageToDisplay: "Please enter a valid End Date")
                                return
                   }
                  
                  
               }
              
              // -----------------------------------------------
             
        // validation check -- if start date is less than end date
         //---------------------------------------------
         let eDate = endDateFormatter.date(from: endDateString)
         let sDate = selectDateFormatter.date(from: selectDateString)
         switch sDate?.compare(eDate!){
         case .orderedAscending     :   print("Date A is earlier than date B")
         case .orderedDescending    :  displayAlertMessage(messageToDisplay: "Start Date is greater than End Date")
               return
         case .orderedSame          :   print("The two dates are the same")
        
             
         case .none: "Do Nothing!!"
             
         }
          //---------------------------------------------
             
        patientSearchModelList =      DatabaseManager.shared.loadPatientSearchDetailsByDate(withID: startDate , endDate: endDate  )
          print("the values of patient search model lisr at search" , patientSearchModelList)
        if patientSearchModelList == nil {
                   print("No Data Found")
                   
                   displayAlertMessage(messageToDisplay: "No Data Found")
                   
               }
               else{
                   performSegue(withIdentifier: "searchByDateToViewCases", sender: self)
               }
             
      
              
        
        
    }
    
    @objc func surgeryDateChanged(surgeryDatePicker : UIDatePicker){
                
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "MM/dd/yyyy"
                 selectDateTextField.text = dateFormatter.string(from: surgeryDatePicker.date)
                
        
             }
    
    @objc func endDateChanged(endDatePicker : UIDatePicker){
            
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MM/dd/yyyy"
        selectEndDate.text = dateFormatter.string(from: endDatePicker.date)
            
    
         }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchByDateToViewCases" {
           
            let vc = segue.destination as! PatientSearchDetailsViewController
            vc.patientSearchModelList1 = patientSearchModelList
            vc.startDate = selectDateTextField.text!
            vc.endDate  = selectEndDate.text!
            vc.viewControlerId = 2
            vc.headingTittle = "Patient List(By Date)"
        }
    }
    
    // done button for keyboard
      func doneButtonForKeyboard(){
             let toolbar = UIToolbar()
             toolbar.sizeToFit()
             
             let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
             
             let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
             
             
             toolbar.setItems([flexibleSpace,doneButton], animated: false)
          
          
          selectDateTextField.inputAccessoryView = toolbar
          selectEndDate.inputAccessoryView = toolbar
          
             
            
         }
      
      
      
    // done for keyboard (Object C function )
       @objc func doneClicked(){
           view.endEditing(true)
       }
    // When back button this view Controller is Pressed
    @IBAction func WhenBackWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // for displaying the alert message
    func displayAlertMessage(messageToDisplay : String)
       {
       let alertController = UIAlertController(title: "Alert",
       message: messageToDisplay, preferredStyle: .alert)
       
       let OKAction = UIAlertAction(title : "OK", style : .default){
               (action :UIAlertAction) in
               
               //Code in this block wiil trigger whern OK is pressed
               print("OK button is tapped");
           }
       alertController.addAction(OKAction)
       self.present(alertController, animated: true,completion: nil)
       }
    
  
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true)
    }
    
}

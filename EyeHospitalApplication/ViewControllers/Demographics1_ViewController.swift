//
//  Demographics1_ViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
import Foundation
import KeyboardAvoidingView
import IHKeyboardAvoiding

@available(iOS 13.0, *)
class Demographics1_ViewController: UIViewController , UITextFieldDelegate   {
   
    private let dataSource1 = ["Fellow did whole case","Fellow did > 75%", "Fellow did 25-75%","Fellow did < 25%","Fellow observed"]
    
     var demographics1List : [Any] = []
   @IBOutlet weak var scrollView: UIScrollView!
    
 
    var validation = Validation()
    var selectedLevel: String?
    var personID: Int = 0
    var tempPersonID : Int = 0
    var tag = 0
    var lastNameString = String()
    var firstNameString = String()
    var dobString = String()
    var mrnInteger = Int()
    var hospitalNameString = String()
    var surgeryDateString = String()
    var activeField: UITextField?  // To check whether the text field is active or not
    var mrnValue : Int?
    
    @IBOutlet weak var fellowInvolmentPercentageSeg: UISegmentedControl!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var mrnTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var eyeTypeSegmentedControll: UISegmentedControl!
  //  @IBOutlet weak var fellowLevelSelected: UITextField!
    @IBOutlet weak var fellowLevelSegControl: UISegmentedControl!
    
    @IBOutlet weak var fellowInvolvementName: UITextField!
    
    @IBOutlet weak var surgerySettingSegControl: UISegmentedControl!
    @IBOutlet weak var hospitalAscNameTextField: UITextField!
    var pickerView = UIPickerView()
    private var dobDatePicker: UIDatePicker?
    private var surgeryDatePicker: UIDatePicker?
    
   // @IBOutlet weak var avoidingView: UIView!
    
   
    
    //-------------------------------------------
    // variables for the data coming from UnLoggedPatientViewController -- this is the view controller where Uncompleted Cases are shown
    
    var fNameUnloggedString  = ""
    var lNameUnloggedString = ""
    var dobUnloggedString = ""
    var mrnUnloggedString =  ""
    var hospitalNameUnloggedString = ""
    var surgeryDateUnloggedString = ""
    
    @IBOutlet weak var nextButton: UIButton!
    
    //-------------------------------------------
    
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        // For getting default hospital name and ASC Centr name
         getUserHospitalName()
       
        if tag == 1  {
            print("entered tag 1")
             demographics1List = DatabaseManager.shared.loadPatientDemographicsDetails(withID: tempPersonID )
                    
                    print("demolist at fellow" , demographics1List )
                    
            //       lastName.text! = demographics1List[0] as! String
            //        firstName.text! = demographics1List[0] as! String
            
            
            lastName?.text? =  demographics1List[2] as! String
            firstName?.text? = demographics1List[1] as! String
            dobTextField?.text? =  demographics1List[3] as! String
            mrnTextField?.text? =  demographics1List[4] as! String
            dateTextField?.text? = demographics1List[10] as! String
            
            
        }
        // For the UnCompleted Cases
        if tag == 2 {
            print("Print entered tag 2 // unlogged Cases")
            firstName.text = fNameUnloggedString
            lastName.text = lNameUnloggedString
            dobTextField?.text?  = dobUnloggedString
            mrnTextField?.text? = mrnUnloggedString
           // hospitalAscNameTextField.text = hospitalNameUnloggedString
            dateTextField?.text? = surgeryDateUnloggedString
        }
        
    
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light    
        nextButton.layer.cornerRadius = 5
        
        if(fellowLevelSegControl.selectedSegmentIndex == 0){
            fellowInvolmentPercentageSeg.isEnabled = false
        }else{
            fellowInvolmentPercentageSeg.isEnabled = true
        }
       
        
        
       // Commented May be for futire use
//        dobTextField?.delegate = self
        
        
        // Date picker for dateOfBirth
       // -----------------------------------------------
//        dobDatePicker = UIDatePicker()
//        dobDatePicker?.datePickerMode = .date
//        dobDatePicker?.addTarget(self, action: #selector(dobDateChanged(dobDatePicker:)), for: .valueChanged )
//
//        dobTextField!.inputView = dobDatePicker
        // -----------------------------------------------
        
        // Date picker for surgery Date
              // -----------------------------------------------
//               surgeryDatePicker = UIDatePicker()
//               surgeryDatePicker?.datePickerMode = .date
//               surgeryDatePicker?.addTarget(self, action: #selector(surgeryDateChanged(surgeryDatePicker :)), for: .valueChanged )
//
//        dateTextField!.inputView = surgeryDatePicker  // setting date picker in surgery date text field
               // -----------------------------------------------
        
        
//        pickerView.dataSource = self
//        pickerView.delegate = self
        getCurrentDate()
        doneButtonForKeyboard()
        doneButtonPickerView()
        
        //------------------
    
    }
    // To get the Current Date
    func getCurrentDate() {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = currentDateFormatter.string(from: Date())
        dateTextField?.text = strDate
    }
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dobDateChanged(dobDatePicker : UIDatePicker){
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dobTextField?.text = dateFormatter.string(from: dobDatePicker.date)
       
        
    }
    
    @objc func surgeryDateChanged(surgeryDatePicker : UIDatePicker){
          
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MM/dd/yyyy"
        dateTextField?.text = dateFormatter.string(from: surgeryDatePicker.date)
               
          
           
       }
    
    @IBAction func handleFellowInvolvementSelection(){
        
        print("Clicked!!")
        
        if(fellowLevelSegControl.selectedSegmentIndex == 0){
            fellowInvolmentPercentageSeg.isEnabled = false
        }else{
            fellowInvolmentPercentageSeg.isEnabled = true
        }
        
    }
   
    @objc func KeyBoardWasShown(notification: Notification){


           self.scrollView.isScrollEnabled = true
           var info = notification.userInfo!
           let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
           let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)

           self.scrollView.contentInset = contentInsets
           self.scrollView.scrollIndicatorInsets = contentInsets

           var aRect : CGRect = self.view.frame
           aRect.size.height -= keyboardSize!.height
           if let activeField = self.activeField {
               if (!aRect.contains(activeField.frame.origin)){
                   self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
               }
           }

    }

    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
      
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = true
        }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    

   
  
   
    
      // done button on keyboard appears by this code
      // done button for keyboard
    func doneButtonForKeyboard(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        lastName.inputAccessoryView = toolbar   // lastname
        firstName.inputAccessoryView = toolbar  // firstname
        dobTextField?.inputAccessoryView = toolbar  // date of birth
        mrnTextField?.inputAccessoryView = toolbar  // Medical Record Number (mrn)
        dateTextField?.inputAccessoryView = toolbar // Surgery date TextField
        hospitalAscNameTextField.inputAccessoryView = toolbar
        fellowInvolvementName.inputAccessoryView = toolbar // Fellow Invlovement
        
       
    }
         // done button for picker View
    func doneButtonPickerView(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePickerClicked))
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
//        fellowLevelSelected.inputAccessoryView = toolbar
//        fellowLevelSelected.inputView = pickerView
        
    }
   // done for keyboard (Object C function )
    @objc func doneClicked(){
        view.endEditing(true)
    }
    // done for pickerView  (Object C function )
    @objc func donePickerClicked(){
        view.endEditing(true)
    }
    
    func getUserHospitalName(){

           let hospitalName =  UserDefaults.standard.string(forKey: "hospitalnameDefault")
            let hospitalCentreType =  UserDefaults.standard.string(forKey: "hospitalCentreTypeDefault")
        
           hospitalAscNameTextField.text = hospitalName
        if hospitalCentreType == "Hospital" {
            surgerySettingSegControl.selectedSegmentIndex = 0
        }
        else {
           surgerySettingSegControl.selectedSegmentIndex = 1
        }
        
        
                  
    }
       
       // Next Button Pressed for demographics page
     @IBAction func demographicsNextButtonPressed(_ sender: UIButton) {
   
       // var levelString = String()
        //    --------------------------------------------------------------------------------------------
       
        guard let lname = lastName.text else { return}   // validation for last Name
        guard let fname = firstName.text else { return}
        guard let hospiName = hospitalAscNameTextField.text else { return}
        guard let mrn = mrnTextField.text else { return}
        
        
        // validation for last name
        
        if lname == "" {
             displayAlertMessage(messageToDisplay: "Please enter the Last Name")
                 return
        }
        
        
        // validation for the first name
        if fname == "" {
            displayAlertMessage(messageToDisplay: "Please enter the First Name")
                  return
               }
        
        // validation for date of birth
        //------------------------------------------------
        let dobDateString = dobTextField?.text
        let dobDateFormatter = DateFormatter()
        dobDateFormatter.dateFormat = "MM/dd/yyyy"
         
         if(dobDateString != "")
         {
        if dobDateFormatter.date(from: dobDateString!) != nil {
            print("date is valid")
        }
            else{
              displayAlertMessage(messageToDisplay: "Incorrect date")
                return
            }
         }
           
        
        //-----------------------------------------------
        
       
        
        if mrnTextField.text == ""{
             mrnValue = Int("0")
        } else {
             mrnValue = Int(mrn)
        }
        
       
        // validation for mrn Date (valid date check )
//        let isValidateMrn = self.validation.validaPhoneNumber(phoneNumber: mrn)
//                       if (isValidateMrn == false) {
//                           print("Incorrect MRN")
//                           displayAlertMessage(messageToDisplay: "Incorrect MRN")
//                           return
//               }
//
        
       
       
        // validation for surgery Date
        //-----------------------------------------------
        let surgeryDateString = dateTextField?.text
               let surgeryDateFormatter = DateFormatter()
               surgeryDateFormatter.dateFormat = "MM/dd/yyyy"

               if surgeryDateFormatter.date(from: surgeryDateString!) != nil {
                   print("date is valid")
               } else {
                
                 displayAlertMessage(messageToDisplay: "Incorrect date")
                return
             
                }
         
        //--------------------------------------------
        
        let eyeSeg =  eyeTypeSegmentedControll.titleForSegment(at: eyeTypeSegmentedControll.selectedSegmentIndex)
        let fellowInvolvementSeg = fellowLevelSegControl.titleForSegment(at: fellowLevelSegControl.selectedSegmentIndex)
       // var levelDropdown = fellowLevelSelected.text
        let surgerySeg = surgerySettingSegControl.titleForSegment(at: surgerySettingSegControl.selectedSegmentIndex)
        
        let fellowNameString = fellowInvolvementName.text!
        
         var fellowInvolvementPercentageString : String?
        
         if(fellowLevelSegControl.selectedSegmentIndex == 1){
             fellowInvolvementPercentageString = fellowInvolmentPercentageSeg.titleForSegment(at: fellowInvolmentPercentageSeg.selectedSegmentIndex)
         }else{
             fellowInvolvementPercentageString = ""
         }
        
        // setting of the all the data of Demographics1 in its Model Class
        let demographics1Info =  Demographics1Model( firstName: firstName.text!, lastName: lastName.text!, dob: dobTextField?.text!, mrn: mrnValue , eye: eyeSeg!,fellowInvolvement: fellowInvolvementSeg, levelSelect: fellowNameString , fellowInvolvementPercentage: fellowInvolvementPercentageString,  surjurySetting: surgerySeg! ,hospitalName: hospitalAscNameTextField.text , date: dateTextField?.text! ,status: 0)
        // Saving values into the database
       // DatabaseManager.shared.createDemographics1Table()
        let inserted = DatabaseManager.shared.insertDemographics1Data(demographics1Info)
         print(inserted)
        
        // getting the id from the database
        //---------------------------------------------------------------
        self.personID =   DatabaseManager.shared.loadData()
        
        print("person id at Demographics one is " , personID)
         
       // performSegue(withIdentifier: "demo1todemo2", sender: self)
      
    
        DispatchQueue.main.async {
            let vc = Demographics2_ViewController()
             vc.valueDemo = self.personID
            vc.mrnTemp = self.mrnValue ?? 0
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
//        func sav∫eData(){
//            
//            
//            let  dict =
//                ["demouniqueid":"",lastName":lastName.text,"firstName: firstName.text,"dob":dobTextField.text, "mrn":mrnTextField.text,"eye": eyeSegmentedControl.titleForSegment(at: eyeSegmentedControl.selectedSegmentIndex),"fellowInvolvement":fellowLevelSegControl
//                    .titleForSegment(at: fellowLevelSegControl.selectedSegmentIndex),
//                 "levelOfInvolvement":levelOfInvolvementTextField.text ,"surgerySetting":surgerySettingSegControl.titleForSegment(at: surgerySettingSegControl.selectedSegmentIndex),"date":dateTextField.text]
//            
//            DatabaseHelperRegistration.shareInstanceRegistration.save(object: dict as! [String : String] )
//            
//            
//        }
        
        
        
//        let  dict =
//            ["lastName":lastName.text,"firstName": firstName.text,"dob":dobTextField.text, "mrn":mrnTextField.text,"eye":eyeSegControl.titleForSegment(at: eyeSegControl.selectedSegmentIndex),"fellowInvolvement": fellowLevelSegControl.titleForSegment(at: fellowLevelSegControl.selectedSegmentIndex) , "levelOfInvolvement": selectLevelTextField.text , "":  ]
//        
//        Demographics1DatabaseHelper..save(object: dict as! [String : String] )
//    
    
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var vc = segue.destination as! Demographics2_ViewController
//        vc.valueDemo = self.personID
//        vc.mrnTemp = mrnValue!
//    }
    
    
    @IBAction func WhenDefaultButtonWasPressed(_ sender: Any) {
        
        var  hospitalName  = hospitalAscNameTextField.text
        var  hospitalCentreType = surgerySettingSegControl.titleForSegment(at: surgerySettingSegControl.selectedSegmentIndex)
        
        UserDefaults.standard.set(hospitalName, forKey: "hospitalnameDefault")
        UserDefaults.standard.set(hospitalCentreType, forKey: "hospitalCentreTypeDefault")
        
        // emp code is Hospital or Asc Name
    }
    
    

    
    @IBAction func WhenHomeWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: true)
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
}


// extension for Demographics1 View Controller
@available(iOS 13.0, *)
extension Demographics1_ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataSource1.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLevel = dataSource1[row]
     //   fellowLevelSelected.text = selectedLevel
        pickerView.isHidden = false
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return dataSource1[row]
        
    }
    

}



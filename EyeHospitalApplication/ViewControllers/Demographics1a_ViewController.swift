
//
//  Demographics1_ViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
import Foundation
import IHKeyboardAvoiding


// experiment code , commented for future use
//extension UIViewController{
//
//        func HideKeyboardForDemo1(){
//        let Tap = UITapGestureRecognizer(target : self , action : #selector(DismissKeyboardForDemo1))
//        view.addGestureRecognizer(Tap)
//
//    }
//
//    @objc func DismissKeyboardForDemo1(){
//        view.endEditing(true)
//    }
//}


@available(iOS 13.0, *)
class Demographics1a_ViewController: UIViewController , UITextFieldDelegate   {
   
    private let dataSource1 = ["Fellow did whole case","Fellow did > 75%", "Fellow did 25-75%","Fellow did < 25%","Fellow observed"]
    
    var demographics1List : [Any] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var headingImageView: UIImageView!
    @IBOutlet weak var avoidingView: UIView!
    var validation = Validation()
    var selectedLevel: String?
    var personID: Int = 0
    var tempPersonId : Int = 0
    var lastNameString = String()
    var firstNameString = String()
    var dobString = String()
    var mrnInteger = Int()
    var hospitalNameString = String()
    var surgeryDateString = String()
    var activeField: UITextField?  // To check whether the text field is active or not
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var mrnTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var eyeTypeSegmentedControll: UISegmentedControl!
    @IBOutlet weak var fellowLevelSelected: UITextField!
    @IBOutlet weak var fellowLevelSegControl: UISegmentedControl!
    @IBOutlet weak var surgerySettingSegControl: UISegmentedControl!
    @IBOutlet weak var hospitalAscNameTextField: UITextField!
    var pickerView = UIPickerView()
    private var dobDatePicker: UIDatePicker?
    private var surgeryDatePicker: UIDatePicker?
   
    
    override func viewWillAppear(_ animated: Bool) {
       
        print("demolist at fellow" , demographics1List )
        
//       lastName.text! = demographics1List[0] as! String
//        firstName.text! = demographics1List[0] as! String
        dobTextField.text? = demographics1List[3] as! String
        mrnTextField.text? = demographics1List[4] as! String
        dateTextField.text? = demographics1List[10] as! String
        
         
        
        KeyboardAvoiding.avoidingView = self.avoidingView
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
         
      
        headingImageView.frame = CGRect(x: (self.avoidingView.frame.width / 2) - (self.headingImageView.frame.width / 2) , y: 0, width: 60, height: 60)
        headingImageView.image = UIImage(named : "pdetail")
        
        
        self.avoidingView.addSubview(headingImageView)
        
        // for desabling fellow Level Involvement Textfield on segment controll selection
        fellowLevelSelected.isEnabled = false
        fellowLevelSelected.backgroundColor = UIColor.lightGray
        
        // for disabling user interaction in date textfield
        dobTextField.delegate = self
        
        
        // Date picker for dateOfBirth
       // -----------------------------------------------
        dobDatePicker = UIDatePicker()
        dobDatePicker?.datePickerMode = .date
        dobDatePicker?.addTarget(self, action: #selector(dobDateChanged(dobDatePicker:)), for: .valueChanged )
        
        dobTextField.inputView = dobDatePicker
        // -----------------------------------------------
        
        // Date picker for surgery Date
              // -----------------------------------------------
               surgeryDatePicker = UIDatePicker()
               surgeryDatePicker?.datePickerMode = .date
               surgeryDatePicker?.addTarget(self, action: #selector(surgeryDateChanged(surgeryDatePicker :)), for: .valueChanged )
               
        dateTextField.inputView = surgeryDatePicker  // setting date picker in surgery date text field
               // -----------------------------------------------
        
        
        pickerView.dataSource = self
        pickerView.delegate = self
        getCurrentDate()
        doneButtonForKeyboard()
        doneButtonPickerView()
        
        //------------------
    
        
        
        // Listens for keyboard events
        //----------------------------------------------------------------
//        NotificationCenter.default.addObserver(self, selector: #selector(self.KeyBoardWasShown(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.KeyBoardWillChange(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
         //----------------------------------------------------------------
       
    }
    
    func getCurrentDate() {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = currentDateFormatter.string(from: Date())
        dateTextField.text = strDate
    }
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dobDateChanged(dobDatePicker : UIDatePicker){
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dobTextField.text = dateFormatter.string(from: dobDatePicker.date)
       
        
    }
    
    @objc func surgeryDateChanged(surgeryDatePicker : UIDatePicker){
          
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MM/dd/yyyy"
           dateTextField.text = dateFormatter.string(from: surgeryDatePicker.date)
               
          
           
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
        self.scrollView.isScrollEnabled = false
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
        dobTextField.inputAccessoryView = toolbar  // date of birth
        mrnTextField.inputAccessoryView = toolbar  // Medical Record Number (mrn)
        dateTextField.inputAccessoryView = toolbar // Surgery date TextField
        hospitalAscNameTextField.inputAccessoryView = toolbar
        
       
    }
         // done button for picker View
    func doneButtonPickerView(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePickerClicked))
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        fellowLevelSelected.inputAccessoryView = toolbar
        fellowLevelSelected.inputView = pickerView
        
    }
   // done for keyboard (Object C function )
    @objc func doneClicked(){
        view.endEditing(true)
    }
    // done for pickerView  (Object C function )
    @objc func donePickerClicked(){
        view.endEditing(true)
    }
       
       // Next Button Pressed for demographics page
     @IBAction func demographicsNextButtonPressed(_ sender: UIButton) {
   
        var levelString = String()
        //    --------------------------------------------------------------------------------------------
       
        guard let lname = lastName.text else { return}   // validation for last Name
        guard let fname = firstName.text else { return}
        guard let hospiName = hospitalAscNameTextField.text else { return}
          // validation removed for now
//                let isValidateLastName = self.validation.validateName(name: lname)
//                if (isValidateLastName == false) {
//                    print("Incorrect fName")  // this code is working fine can be implemented further
//                    displayAlertMessage(messageToDisplay: "Incorrect last name")
//                    return
//                }
        // validation for First Name
//                let isValidateFirstName = self.validation.validateName(name: fname)
//                if (isValidateFirstName == false) {
//                    print("Incorrect fName")
//                    displayAlertMessage(messageToDisplay: "Incorrect first name")
//                    return
//        }
        
        // Validation for MRN (Medical Record Number)
        //
        let mrn = mrnTextField.text
//        let isValidateMrn = self.validation.validaPhoneNumber(phoneNumber: mrn!)
//                       if (isValidateMrn == false) {
//                           print("Incorrect MRN")
//                           displayAlertMessage(messageToDisplay: "Incorrect MRN")
//                           return
//               }
        
        
        // validation for Hospital/ Asc Name
        if hospiName == "" {
             displayAlertMessage(messageToDisplay: "Please enter Hospital/Asc Name")
            
        }
        
        // validation for date of birth
        //------------------------------------------------
        let dobDateString = dobTextField.text
        let dobDateFormatter = DateFormatter()
        dobDateFormatter.dateFormat = "MM/dd/yyyy"

//        if dobDateFormatter.date(from: dobDateString!) != nil {
//            print("date is valid")
//        } else {
//            
//            if dobDateString == "" {
//                displayAlertMessage(messageToDisplay: "Please enter the Date of Birth")
//                                       
//                return
//            }
//            else{
//              displayAlertMessage(messageToDisplay: "Incorrect date")
//                         return
//            }
//           
//           
//        }
        //-----------------------------------------------
        
        // validation for surgery Date
        //-----------------------------------------------
               let surgeryDateString = dateTextField.text
               let surgeryDateFormatter = DateFormatter()
               surgeryDateFormatter.dateFormat = "MM/dd/yyyy"

               if surgeryDateFormatter.date(from: surgeryDateString!) != nil {
                   print("date is valid")
               } else {
                if surgeryDateString == "" {
                    displayAlertMessage(messageToDisplay: "Please enter the surgery date")
                    return
                }
                else{
                    displayAlertMessage(messageToDisplay: "Incorrect date")
                    return
                }
                   
                  
               }
        //--------------------------------------------
        
        let eyeSeg =  eyeTypeSegmentedControll.titleForSegment(at: eyeTypeSegmentedControll.selectedSegmentIndex)
        let fellowInvolvementSeg = fellowLevelSegControl.titleForSegment(at: fellowLevelSegControl.selectedSegmentIndex)
        let levelDropdown = fellowLevelSelected.text
        let surgerySeg = surgerySettingSegControl.titleForSegment(at: surgerySettingSegControl.selectedSegmentIndex)
        let mrnValue : Int? = Int(mrnTextField.text!)
        
//        if levelDropdown == "Select the Level" {
//            levelString = ""
//        }
//        else {
//            levelString = levelDropdown!
//        }
        
        // setting of the all the data of Demographics1 in its Model Class
        let demographics1Info =  Demographics1Model( firstName: firstName.text!, lastName: lastName.text!, dob: dobTextField.text!, mrn: mrnValue , eye: eyeSeg!,fellowInvolvement: fellowInvolvementSeg, levelSelect: levelString , surjurySetting: surgerySeg! ,hospitalName: hospitalAscNameTextField.text , date: dateTextField.text!,status: 0)
        // Saving values into the database
       // DatabaseManager.shared.createDemographics1Table()
        let inserted = DatabaseManager.shared.insertDemographics1Data(demographics1Info)
         print(inserted)
        
        // getting the id from the database
        //---------------------------------------------------------------
        self.personID =   DatabaseManager.shared.loadData()
        
        print("person id at Demographics one is " , personID)
         
     //   performSegue(withIdentifier: "demo1Atodemo2", sender: self)
      
        
        
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! Demographics2_ViewController
        vc.valueDemo = self.personID
    }
    
    
    @IBAction func whenFellowInvolvementSegmentedControlIsPressed(_ sender: UISegmentedControl) {
   
        let fellowInvolvementSegValue = fellowLevelSegControl.titleForSegment(at: fellowLevelSegControl.selectedSegmentIndex)
        if fellowInvolvementSegValue == "Yes" {
            fellowLevelSelected.isEnabled = true
            fellowLevelSelected.backgroundColor = UIColor.white
            
        }
        else{
            fellowLevelSelected.isEnabled = false
            fellowLevelSelected.backgroundColor = UIColor.lightGray
        }
        
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
extension Demographics1a_ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataSource1.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLevel = dataSource1[row]
        fellowLevelSelected.text = selectedLevel
        pickerView.isHidden = false
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return dataSource1[row]
        
    }
    

}



    



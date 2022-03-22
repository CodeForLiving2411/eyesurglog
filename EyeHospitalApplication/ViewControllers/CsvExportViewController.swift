//
//  CsvExportViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 26/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
class CsvExportViewController: UIViewController {
    
   
    @IBOutlet weak var startDateText: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    @IBOutlet weak var endDateText: UITextField!
    var patientDataInCsvList : [CsvExportDataModel]?
     private var surgeryStartDatePicker: UIDatePicker?
     private var surgeryEndDatePicker: UIDatePicker?
    
    @IBOutlet weak var recordFoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentStartDate()
        exportButton.isHidden = true
        searchButton.layer.cornerRadius = 5
        exportButton.layer.cornerRadius = 5 
        
        // Date picker for surgery Start Date for startDateText TextField
              // -----------------------------------------------
               surgeryStartDatePicker = UIDatePicker()
               surgeryStartDatePicker?.datePickerMode = .date
               surgeryStartDatePicker?.addTarget(self, action: #selector(surgeryStartDateChanged(surgeryDatePicker :)), for: .valueChanged )
               
        startDateText.inputView = surgeryStartDatePicker  // setting date picker in surgery date text field
               // -----------------------------------------------
        
        // Date picker for surgery Start Date for startDateText TextField
                     // -----------------------------------------------
                      surgeryEndDatePicker = UIDatePicker()
                      surgeryEndDatePicker?.datePickerMode = .date
                      surgeryEndDatePicker?.addTarget(self, action: #selector(surgeryEndDateChanged(surgeryDatePicker :)), for: .valueChanged )
                      
               endDateText.inputView = surgeryEndDatePicker  // setting date picker in surgery date text field
                      // -----------------------------------------------
              
        
        // shows done button on top right side of the keyboard or Date PickerView when they appear
         doneButtonForKeyboard()

       
    }
    
    
    // to get current date
       func getCurrentStartDate() {
              let currentDateFormatter = DateFormatter()
              currentDateFormatter.dateFormat = "MM/dd/yyyy"
              let strDate = currentDateFormatter.string(from: Date())
              startDateText?.text = strDate
              endDateText?.text = strDate
          }
    
    @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
        
        // validation for Start Date for searching details of patient to export
        //------------------------------------------------
        let startDateString = startDateText.text
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "MM/dd/yyyy"

        if startDateFormatter.date(from: startDateString!) != nil {
            print("date is valid")
        } else {
            
            if startDateString == "" {
                displayAlertMessage(messageToDisplay: "Please choose the Start Date")
                                       
                return
            }
            else{
              displayAlertMessage(messageToDisplay: "Incorrect Start Date")
                         return
            }
           
           
        }
        //-----------------------------------------------
       
        
        // validation for End Date for searching details of patient to export
               //------------------------------------------------
               let endDateString = endDateText.text
               let endDateFormatter = DateFormatter()
               endDateFormatter.dateFormat = "MM/dd/yyyy"

               if endDateFormatter.date(from: endDateString!) != nil {
                   print("date is valid")
               } else {
                   
                   if endDateString == "" {
                       displayAlertMessage(messageToDisplay: "Please choose the End Date")
                                              
                       return
                   }
                   else{
                     displayAlertMessage(messageToDisplay: "Incorrect End Date")
                                return
                   }
                  
                  
               }
        
       
               //-----------------------------------------------
        
        
        // validation check -- if start date is less than end date
        //---------------------------------------------
        let eDate = endDateFormatter.date(from: endDateString!)
        let sDate = startDateFormatter.date(from: startDateString!)
        switch sDate?.compare(eDate!){
        case .orderedAscending     :   print("Date A is earlier than date B")
        case .orderedDescending    :  displayAlertMessage(messageToDisplay: "Start Date is greater than End Date")
              return
        case .orderedSame          :   print("The two dates are the same")
       
            
        case .none: "Do Nothing!!"
            
        }
         //---------------------------------------------
               
              
        
        
        
        let startDate = startDateText.text!
         let endDate = endDateText.text!
        
        patientDataInCsvList = DatabaseManager.shared.loadPatientDetailsForExportByDate(withID: startDate , endDate: endDate )
        print("patient details in csv list" , patientDataInCsvList)
        if patientDataInCsvList == nil {
            recordFoundLabel.text = "No Records Found !!!"
             exportButton.isHidden = true
        }
        else{
            let count = (patientDataInCsvList?.count)!
            recordFoundLabel.text = " \(count) Records Found !!!"
            exportButton.isHidden = false
        }
        
        
    }
    
    
    @IBAction func WhenExportButtonWasPressed(_ sender: UIButton) {
       
        
        ExportDataToCsv()   // this function exports the data to CSV
        
    }
    
    @objc func surgeryStartDateChanged(surgeryDatePicker : UIDatePicker){
             
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "MM/dd/yyyy"
              startDateText.text = dateFormatter.string(from: surgeryDatePicker.date)
                  
             
              
          }
    
    @objc func surgeryEndDateChanged(surgeryDatePicker : UIDatePicker){
                
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "MM/dd/yyyy"
                 endDateText.text = dateFormatter.string(from: surgeryDatePicker.date)
                     
                
                 
             }
    
    func doneButtonForKeyboard(){
          let toolbar = UIToolbar()
          toolbar.sizeToFit()
          
          let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
          
          let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
          
          
          toolbar.setItems([flexibleSpace,doneButton], animated: false)
        startDateText.inputAccessoryView = toolbar
        endDateText.inputAccessoryView = toolbar
          
         
          
         
      }
    
    // done for keyboard (Object C function )
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    
    func ExportDataToCsv() -> Void {
        let fileName = "PatientDetailsByDate.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
       
        var csvText = "Last Name,First Name,Date Of Bith,MRN(Medical Record Number),Eye Type,Fellow Involvement,Fellow Name, Surgery Setting,Hospital/ASC Name,Surgery Date,Aphakia,Cataract , Choroidal Effusion,Choroidal Hemorrhage,Diabetic TRD, Dislocated Intraocular Lens,Endophthalmitis,Epiretinal Membrane,FEVR,Floaters,Full Thickness Macular Hole, Intraocular Foreign Body,Lamellar Macular Hole,Lattice Degeneration, PDR,Primary RD with PVR,RecurrentRD with PVr,Recurrent RD without PVR,Retained Lens Fragments,Retinal Tear,Retinal Vein Occlusion, Rhegmatogenous RD (Macula Off),Rhegmatogenous RD (Macula On),ROP, Sickle Cell,s/p RD Repair with Silicone Oil,Subluxed Crystalline Lens,Vitreous Hemorrhage,Other Field 1, Other Field 2, Other Field 3,Other Field 4,Gauge,band,sleeve, SRF Drain,AC Tap, Radial Element,Membrane Peel,ILM Peel,Retinectomy, Fluid Air Exchange,PFO,Focal Endolaser, PRP Laser, Indirect Laser Tear,IOL Exchange,ACIOL,Sulcus IOL,Sutured,Sutureless, PPL with Frag,PPL without Frag,Tamponade 1, Percentage Tamponade,OtherField Tamponade,  Other Field 2 Surgery , Virectomy , Scleral Buckle , IOL Insertion ,Silicone Oil Removal , Silicone Oil Exchange , Choroidal Drainage  , IOL Name , IOL Power , Positioning ,Comments ,Redetached before POM3?, Macular Hole Closed? ,POM1 Visual Acuity,POM 3 Visual Acuity ,Other Outcomes Data ,CPT Code,IOL Reposition ,CPT Field ,Cryotherapy , ILM Peel Code , Fellow Involvement Percentage , Retinal Defect NOS \n"
        
        let count = (patientDataInCsvList?.count)!
        
        if count > 0 {
        
        for patientDataInCsv  in patientDataInCsvList! {
            
            let newLine = "\(patientDataInCsv.lastName!), \(patientDataInCsv.firstname!),\(patientDataInCsv.dob!), \(patientDataInCsv.mrn!), \(patientDataInCsv.eye!), \(patientDataInCsv.fellowInvolvement!),\(patientDataInCsv.level!), \(patientDataInCsv.surgerySetting!), \(patientDataInCsv.hospitalName!), \(patientDataInCsv.date!), \(patientDataInCsv.aphakia!), \(patientDataInCsv.cataract!) , \(patientDataInCsv.choroidalEffusion!), \(patientDataInCsv.choroidalHemorrhage!), \(patientDataInCsv.diabeticTrd!), \(patientDataInCsv.dislocatedIntraocularLens!), \(patientDataInCsv.endophthalmitis!), \(patientDataInCsv.epiretinalMembrane!), \(patientDataInCsv.fevr!), \(patientDataInCsv.floaters!), \(patientDataInCsv.fullThicknessMacularHole!), \(patientDataInCsv.intraocularForeignBody!), \(patientDataInCsv.lamellarMacularHole!), \(patientDataInCsv.latticeDegeneration!), \(patientDataInCsv.pdr!), \(patientDataInCsv.primaryRdWithPvr!), \(patientDataInCsv.recurrentRdWithPvr!), \(patientDataInCsv.recurrentRdWithOutPvr!) , \(patientDataInCsv.retainedLensFragments!), \(patientDataInCsv.retinalTear!), \(patientDataInCsv.retinalVeinOcclusion!), \(patientDataInCsv.rhegmatogenousRdMaculaOff!) , \(patientDataInCsv.rhegmatogenousRdMaculaOn!), \(patientDataInCsv.rop!) , \(patientDataInCsv.sickleCell!) , \(patientDataInCsv.spRdRepairWithSiliconeOil!) , \(patientDataInCsv.subluxedCrystallineLens!), \(patientDataInCsv.vitreousHemorrhage!),\(patientDataInCsv.otherField!) ,\(patientDataInCsv.otherField2!), \(patientDataInCsv.otherField3!) , \(patientDataInCsv.otherField4!), \("\(patientDataInCsv.gauge!)"), \(patientDataInCsv.band!), \(patientDataInCsv.sleeve!),  \(patientDataInCsv.srfDrain!), \(patientDataInCsv.acTap!),\(patientDataInCsv.radialElement!) , \(patientDataInCsv.membranePeel!) , \(patientDataInCsv.ilmPeel!), \(patientDataInCsv.retinectomy!), \(patientDataInCsv.fluidAirExchange!), \(patientDataInCsv.pfo!), \(patientDataInCsv.focalEndolaser!), \(patientDataInCsv.prpLaser!), \(patientDataInCsv.indirectLaserTear!), \(patientDataInCsv.iolExchange!), \(patientDataInCsv.aciol!), \(patientDataInCsv.sulcusIol),\(patientDataInCsv.sutured!), \(patientDataInCsv.sutureless!), \(patientDataInCsv.pplWithFrag!), \(patientDataInCsv.pplWithoutFrag!), \(patientDataInCsv.tamponade2!), \(patientDataInCsv.percentageTamponade!) ,\(patientDataInCsv.otherFieldTamponade!) , \(patientDataInCsv.otherField2Surgery!) ,\(patientDataInCsv.virectomy!) ,\(patientDataInCsv.scleralBuckle!) , \(patientDataInCsv.iolInsertion!) , \(patientDataInCsv.siliconeOilRemoval!), \(patientDataInCsv.siliconeOilExchange!),\(patientDataInCsv.corodialDrainage!) , \(patientDataInCsv.iolName!) , \(patientDataInCsv.iolPower!) , \(patientDataInCsv.positioning!) , \(patientDataInCsv.comments!),\(patientDataInCsv.retinalDetachment!) ,\(patientDataInCsv.macularHoleClosed!) , \(patientDataInCsv.pomVisualAcuity!) , \(patientDataInCsv.pom3VisualAcuity!) , \(patientDataInCsv.otherOutcomeData!) , '\(patientDataInCsv.cptCodeDropdown!)' , '\(patientDataInCsv.iolReposition!)' , '\(patientDataInCsv.cptFreeTextBox!)' , '\(patientDataInCsv.cryotherapy!)', '\(patientDataInCsv.ilmCodeDropdown!)' , '\(patientDataInCsv.fellowInvolvementPercentage!)','\(patientDataInCsv.retinalDefect)'  \n"
          
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            print("Csv File created !!!")
            
            
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            vc.excludedActivityTypes = [
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToTwitter,
                UIActivity.ActivityType.postToFacebook,
                UIActivity.ActivityType.openInIBooks ]
               
               present(vc, animated: true, completion: nil)
            
            
        } catch {
            print("Failed to create file!!!")
            print("\(error)")
        }
        }
        else{
            print("there is no data to export")
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
    
    
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
      
    }
    
   // For the back button on top left side
     @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
     }
    


}

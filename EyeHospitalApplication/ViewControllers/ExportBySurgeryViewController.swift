//
//  ExportByDateViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 06/03/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit
import DropDown

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class ExportBySurgeryViewController: UIViewController {
    
    var patientDataInCsvList : [CsvExportDataModel]?
    var patientSearchModelList: [PatientSearchModel]?
    @IBOutlet weak var surgeryTypeLabelView: UIView!
    
    @IBOutlet weak var surgeryTypeLabelView2: UIView!
    
    @IBOutlet weak var surgeryTypeLabelView3: UIView!
    
    @IBOutlet weak var numberOfRecodsDisplayLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    // let uiPicvkerView = UIPickerView()
    var dataList = ["Select Surgery","Virectomy","Scleral buckle", "Membrane peel", "ILM peel", "Retinectomy" , "Fluid-Air-Exchange" , "PFO" ,"Focal Endolaser", "PRP Laser" , "Indirect Laser Tear/Lattice" , "IOL Exchange","IOL Insertion" , "ACIOL" ,"Sulcus IOL" , "Scleral Fixated IOL Sutured" , "Scleral Fixated IOL Sutueless" , "PPL with Frag" , "PPL without Frag" , "Silicone Oil Removal" , "Silicone Oil Exchange" ,"Choroidal Drainage" , "IOL Reposition" , "Cryotherapy"]
    var selectedItem = ""
    var queryStatus = 0
    
    
    let dropDown = DropDown()
    
    @IBOutlet weak var surgeryTypeLabel: UILabel!
    
    @IBOutlet weak var surgeryTypeLabel2: UILabel!
    
    
    @IBOutlet weak var surgeryTypeLabel3: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
      //  surgeryTypeLabel.text = "Membrane peel"
        exportButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        ///------ For Surgery Type 1
       let gestureSurgeryType = UITapGestureRecognizer(target: self , action: #selector(self.WhenSurgeryTypeViewWasPressed))
          self.surgeryTypeLabelView.addGestureRecognizer(gestureSurgeryType)

        surgeryTypeLabelView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        surgeryTypeLabelView.layer.borderWidth = 3.0
        searchButton.layer.cornerRadius = 5
        exportButton.layer.cornerRadius = 5 
        
        ///------ For Surgery Type 2
              let gestureSurgeryType2 = UITapGestureRecognizer(target: self , action: #selector(self.WhenSurgeryType2ViewWasPressed))
                 self.surgeryTypeLabelView2.addGestureRecognizer(gestureSurgeryType2)

               surgeryTypeLabelView2.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
               surgeryTypeLabelView2.layer.borderWidth = 3.0
        
        ///------ For Surgery Type 3
        let gestureSurgeryType3 = UITapGestureRecognizer(target: self , action: #selector(self.WhenSurgeryType3ViewWasPressed))
           self.surgeryTypeLabelView3.addGestureRecognizer(gestureSurgeryType3)

         surgeryTypeLabelView3.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
         surgeryTypeLabelView3.layer.borderWidth = 3.0
        
        
        
    }
    // When Surgery type one was preseed
    
    @objc func WhenSurgeryTypeViewWasPressed() {
        
        print("view clicked")
        dropDown.anchorView = surgeryTypeLabelView
               dropDown.dataSource = dataList
       queryStatus = 1
        dropDown.show()
               
               // Action triggered on selection
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.surgeryTypeLabel.text = item
               // self.selectedItem = item
                
               }
    }
    
    // When Surgery type 2 was preseed
       @objc func WhenSurgeryType2ViewWasPressed() {
        
        if surgeryTypeLabel.text == "Select Surgery" {
            print("Select the Surgery 1 ")
            displayAlertMessage(messageToDisplay: "Select the Surgery 1 ")
        }
        else {
           queryStatus = 2
           print("view clicked")
           dropDown.anchorView = surgeryTypeLabelView2
                  dropDown.dataSource = dataList
          
           dropDown.show()
                  
                  // Action triggered on selection
                  dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   self.surgeryTypeLabel2.text = item
                  // self.selectedItem = item
                   
                  }
        }
       }
    
    // When Surgery type 3 was preseed
       @objc func WhenSurgeryType3ViewWasPressed() {
        
        if surgeryTypeLabel2.text == "Select Surgery" {
                   print("Select the Surgery 2")
            displayAlertMessage(messageToDisplay: "Select the Surgery 2" )
               }
        else {
           
            queryStatus = 3
           print("view clicked")
           dropDown.anchorView = surgeryTypeLabelView3
                  dropDown.dataSource = dataList
          
           dropDown.show()
                  
                  // Action triggered on selection
                  dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                   self.surgeryTypeLabel3.text = item
                  // self.selectedItem = item
                   
                  }
        }
       }
    
    
    
    
    
    @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
        
       
        //For Surgery Type 1
        var value = ""
        switch (self.surgeryTypeLabel.text) {
        case "Virectomy" : value = "virectomy"
            break
        case "Scleral buckle"    : value = "scleralBuckle"
            break
        case "IOL Insertion"   : value = "iolInsertion"
            break
        case "Membrane peel":  value = "membranePeel"
            break
        case "ILM peel" :   value = "ilmPeel"
            break
        case "Retinectomy" : value = "retinectomy"
            break
        case "Fluid-Air-Exchange" :  value = "fluidAirExchange"
            break
        case "PFO" :   value = "pfo"
            break
        case "Focal Endolaser" : value = "focalEndolaser"
            break
        case "PRP Laser" :  value = "prpLaser"
            break
        case "Indirect Laser Tear/Lattice" : value = "indirectLaserTear"
            break
        case "IOL Exchange" :   value = "iolExchange"
            break
        case "ACIOL" :  value = "aciol"
            break
        case "Sulcus IOL" : value = "sulcusIol"
            break
        case "Scleral Fixated IOL Sutured" :  value = "sutured"
            break
        case "Scleral Fixated IOL Sutueless" : value = "sutureless"
            break
        case "PPL with Frag" : value = "pplWithFrag"
            break
        case "PPL without Frag" : value = "pplWithoutFrag"
            break
        case "Silicone Oil Removal" : value = "siliconeOilRemoval"
            break
        case "Silicone Oil Exchange" : value = "siliconeOilExchange"
            break
        case "Choroidal Drainage" : value = "corodialDrainage"
            break
        case "IOL Reposition" : value = "iolReposition"
                 break
        case "Cryotherapy" : value = "cryotherapy"
                 break
        default:
              print("Not a Valid Option")
        }
        
        //For Surgery Type 2
               var value2 = ""
               switch (self.surgeryTypeLabel2.text) {
               case "Virectomy" : value2 = "virectomy"
                   break
               case "Scleral buckle"    : value2 = "scleralBuckle"
                   break
               case "IOL Insertion"   : value2 = "iolInsertion"
                   break
               case "Membrane peel":  value2 = "membranePeel"
                   break
               case "ILM peel" :   value2 = "ilmPeel"
                   break
               case "Retinectomy" : value2 = "retinectomy"
                   break
               case "Fluid-Air-Exchange" :  value2 = "fluidAirExchange"
                   break
               case "PFO" :   value2 = "pfo"
                   break
               case "Focal Endolaser" : value2 = "focalEndolaser"
                   break
               case "PRP Laser" :  value2 = "prpLaser"
                   break
               case "Indirect Laser Tear/Lattice" : value2 = "indirectLaserTear"
                   break
               case "IOL Exchange" :   value2 = "iolExchange"
                   break
               case "ACIOL" :  value2 = "aciol"
                   break
               case "Sulcus IOL" : value2 = "sulcusIol"
                   break
               case "Scleral Fixated IOL Sutured" :  value2 = "sutured"
                   break
               case "Scleral Fixated IOL Sutueless" : value2 = "sutureless"
                   break
               case "PPL with Frag" : value2 = "pplWithFrag"
                   break
               case "PPL without Frag" : value2 = "pplWithoutFrag"
                   break
                case "Silicone Oil Removal" : value2 = "siliconeOilRemoval"
                    break
                case "Silicone Oil Exchange" : value2 = "siliconeOilExchange"
                    break
                case "Choroidal Drainage" : value2 = "corodialDrainage"
                           break
                case "IOL Reposition" : value2 = "iolReposition"
                     break
                case "Cryotherapy" : value2 = "cryotherapy"
                     break
               default:
                     print("Not a Valid Option")
               }
        
        //For Surgery Type 3
                      var value3 = ""
                      switch (self.surgeryTypeLabel3.text) {
                      case "Virectomy" : value3 = "virectomy"
                          break
                      case "Scleral buckle"    : value3 = "scleralBuckle"
                          break
                      case "IOL Insertion"   : value3 = "iolInsertion"
                          break
                      case "Membrane peel":  value3 = "membranePeel"
                          break
                      case "ILM peel" :   value3 = "ilmPeel"
                          break
                      case "Retinectomy" : value3 = "retinectomy"
                          break
                      case "Fluid-Air-Exchange" :  value3 = "fluidAirExchange"
                          break
                      case "PFO" :   value3 = "pfo"
                          break
                      case "Focal Endolaser" : value3 = "focalEndolaser"
                          break
                      case "PRP Laser" :  value3 = "prpLaser"
                          break
                      case "Indirect Laser Tear/Lattice" : value2 = "indirectLaserTear"
                          break
                      case "IOL Exchange" :   value3 = "iolExchange"
                          break
                      case "ACIOL" :  value3 = "aciol"
                          break
                      case "Sulcus IOL" : value3 = "sulcusIol"
                          break
                      case "Scleral Fixated IOL Sutured" :  value3 = "sutured"
                          break
                      case "Scleral Fixated IOL Sutueless" : value3 = "sutureless"
                          break
                      case "PPL with Frag" : value3 = "pplWithFrag"
                          break
                      case "PPL without Frag" : value3 = "pplWithoutFrag"
                          break
                        case "Silicone Oil Removal" : value3 = "siliconeOilRemoval"
                            break
                        case "Silicone Oil Exchange" : value3 = "siliconeOilExchange"
                            break
                        case "Choroidal Drainage" : value3 = "corodialDrainage"
                            break
                        
                        case "IOL Reposition" : value3 = "iolReposition"
                             break
                        case "Cryotherapy" : value3 = "cryotherapy"
                             break
                      default:
                            print("Not a Valid Option")
                      }
               
        if surgeryTypeLabel.text == "Select Surgery" {
            print("Please select the Surgery 1 ")
            displayAlertMessage(messageToDisplay: "Please select the Surgery 1")
            return
        }
        
        if surgeryTypeLabel2.text == "Select Surgery" && surgeryTypeLabel3.text == "Select Surgery" {
            queryStatus = 1
        }
        else if surgeryTypeLabel2.text != "Select Surgery" && surgeryTypeLabel3.text == "Select Surgery" {
             queryStatus = 2
        }
        else if  surgeryTypeLabel.text != "Select Surgery" &&  surgeryTypeLabel2.text != "Select Surgery" && surgeryTypeLabel3.text != "Select Surgery" {
             queryStatus = 3
        }
        else {
            print("Not an option")
        }
        
        
//        if surgeryTypeLabel3.text == "Select Surgery" {
//                   queryStatus = 2
//               }
        
        
          
        
      
        do {
            patientDataInCsvList = try! DatabaseManager.shared.loadPatientDetailsForExportBySurgery(withID: value, surgeryType2 : value2, surgeryType3: value3, surgeryStatus: "Yes" , queryStatus : self.queryStatus)
            
      
        print("the values of patientDataInCsvList at search" , patientDataInCsvList )
            
        }
        catch {
             print(error.localizedDescription)
        }
                   if patientDataInCsvList == nil {
                    print("No Records Found")
                              numberOfRecodsDisplayLabel.text = "No Records Found !!!"
                               exportButton.isHidden = true
                          }
                          else{
                              let count = (patientDataInCsvList?.count)!
                              print("\(count) Records Found !!!")
                              numberOfRecodsDisplayLabel.text = "\(count) Records Found !!!"
                              exportButton.isHidden = false
                          }
        
    }
    
    
    
    @IBAction func WhenExportButtonWasPressed(_ sender: UIButton) {
        ExportDataToCsv()
    }
    
    func ExportDataToCsv() -> Void {
        let fileName = "PatientDetailsBySurgeryType.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
       
        var csvText = "Last Name,First Name,Date Of Birth,MRN(Medical Record Number),Eye Type,Fellow Involvement,Fellow Name, Surgery Setting,Hospital/ASC Name,Surgery Date,Aphakia,Cataract , Choroidal Effusion,Choroidal Hemorrhage,Diabetic TRD, Dislocated Intraocular Lens,Endophthalmitis,Epiretinal Membrane,FEVR,Vitreous Opacities,Full Thickness Macular Hole, Intraocular Foreign Body,Lamellar Macular Hole,Lattice Degeneration, PDR,Primary RD with PVR,RecurrentRD with PVr,Recurrent RD without PVR,Retained Lens Fragments,Retinal Tear,Retinal Vein Occlusion, Rhegmatogenous RD (Macula Off), Rhegmatogenous RD (Macula On),ROP, Sickle Cell,s/p RD Repair with Silicone Oil,Subluxed Crystalline Lens,Vitreous Hemorrhage,Other Field 1, Other Field 2, Other Field 3,Other Field 4,Gauge,band,sleeve, SRF Drain,AC Tap, Radial Element,Membrane Peel,ILM Peel,Retinectomy, Fluid Air Exchange,PFO,Focal Endolaser, PRP Laser, Indirect Laser Tear,IOL Exchange,ACIOL,Sulcus IOL,Sutured,Sutureless, PPL with Frag,PPL without Frag,Tamponade 1,Percentage Tamponade,OtherField Tamponade, Other Field 2 Surgery , Virectomy , Scleral Buckle , IOL Insertion ,Silicone Oil Removal , Silicone Oil Exchange, Choroidal Drainage , IOL Name , IOL Power , Positioning , Comments,Redetached before POM3?, Macular Hole Closed? ,POM1 Visual Acuity,POM 3 Visual Acuity,Other Outcomes Data, CPT Code, IOL Reposition  ,CPT Field ,Cryotherapy , ILM Peel Code , Fellow Involvement Percentage \n"
        
      
        let count = (patientDataInCsvList?.count)!
        
        if count > 0 {
        
        for patientDataInCsv  in patientDataInCsvList! {
            
            let newLine = "\(patientDataInCsv.lastName!), \(patientDataInCsv.firstname!),\(patientDataInCsv.dob!), \(patientDataInCsv.mrn!), \(patientDataInCsv.eye!), \(patientDataInCsv.fellowInvolvement!),\(patientDataInCsv.level!), \(patientDataInCsv.surgerySetting!), \(patientDataInCsv.hospitalName!), \(patientDataInCsv.date!), \(patientDataInCsv.aphakia!), \(patientDataInCsv.cataract!) , \(patientDataInCsv.choroidalEffusion!), \(patientDataInCsv.choroidalHemorrhage!), \(patientDataInCsv.diabeticTrd!), \(patientDataInCsv.dislocatedIntraocularLens!), \(patientDataInCsv.endophthalmitis!), \(patientDataInCsv.epiretinalMembrane!), \(patientDataInCsv.fevr!), \(patientDataInCsv.floaters!), \(patientDataInCsv.fullThicknessMacularHole!), \(patientDataInCsv.intraocularForeignBody!), \(patientDataInCsv.lamellarMacularHole!), \(patientDataInCsv.latticeDegeneration!), \(patientDataInCsv.pdr!), \(patientDataInCsv.primaryRdWithPvr!), \(patientDataInCsv.recurrentRdWithPvr!), \(patientDataInCsv.recurrentRdWithOutPvr!) , \(patientDataInCsv.retainedLensFragments!), \(patientDataInCsv.retinalTear!), \(patientDataInCsv.retinalVeinOcclusion!), \(patientDataInCsv.rhegmatogenousRdMaculaOff!) , \(patientDataInCsv.rhegmatogenousRdMaculaOn!), \(patientDataInCsv.rop!) , \(patientDataInCsv.sickleCell!) , \(patientDataInCsv.spRdRepairWithSiliconeOil!) , \(patientDataInCsv.subluxedCrystallineLens!), \(patientDataInCsv.vitreousHemorrhage!),\(patientDataInCsv.otherField!) ,\(patientDataInCsv.otherField2!), \(patientDataInCsv.otherField3!) , \(patientDataInCsv.otherField4!), \(patientDataInCsv.gauge!), \(patientDataInCsv.band!), \(patientDataInCsv.sleeve!), \(patientDataInCsv.srfDrain!), \(patientDataInCsv.acTap!), \(patientDataInCsv.radialElement!) , \(patientDataInCsv.membranePeel!) , \(patientDataInCsv.ilmPeel!), \(patientDataInCsv.retinectomy!), \(patientDataInCsv.fluidAirExchange!), \(patientDataInCsv.pfo!), \(patientDataInCsv.focalEndolaser!), \(patientDataInCsv.prpLaser!), \(patientDataInCsv.indirectLaserTear!), \(patientDataInCsv.iolExchange!), \(patientDataInCsv.aciol!), \(patientDataInCsv.sulcusIol!),\(patientDataInCsv.sutured!), \(patientDataInCsv.sutureless!), \(patientDataInCsv.pplWithFrag!), \(patientDataInCsv.pplWithoutFrag!), \(patientDataInCsv.tamponade2!), \(patientDataInCsv.percentageTamponade!) ,\(patientDataInCsv.otherFieldTamponade!) , \(patientDataInCsv.otherField2Surgery!) ,\(patientDataInCsv.virectomy!) ,\(patientDataInCsv.scleralBuckle!) , \(patientDataInCsv.iolInsertion!) , \(patientDataInCsv.siliconeOilRemoval!), \(patientDataInCsv.siliconeOilExchange!), \(patientDataInCsv.corodialDrainage!) , \(patientDataInCsv.iolName!) , \(patientDataInCsv.iolPower!) , \(patientDataInCsv.positioning!) , \(patientDataInCsv.comments!),\(patientDataInCsv.retinalDetachment!) ,\(patientDataInCsv.macularHoleClosed!) , \(patientDataInCsv.pomVisualAcuity!) , \(patientDataInCsv.pom3VisualAcuity!) , \(patientDataInCsv.otherOutcomeData!) , \(patientDataInCsv.cptCodeDropdown!) , \(patientDataInCsv.iolReposition!) , \(patientDataInCsv.cptFreeTextBox!) , \(patientDataInCsv.cryotherapy!) , \(patientDataInCsv.ilmCodeDropdown!) ,\(patientDataInCsv.fellowInvolvementPercentage!) , \(patientDataInCsv.retinalDefect!) \n"
          
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
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if segue.identifier == "seachByTypeToCases" {
//
//               let vc = segue.destination as! PatientSearchDetailsViewController
//               vc.patientSearchModelList1 = patientSearchModelList
//
//           }
//       }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                       vc.modalPresentationStyle = .fullScreen
                       self.present(vc, animated: true)
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

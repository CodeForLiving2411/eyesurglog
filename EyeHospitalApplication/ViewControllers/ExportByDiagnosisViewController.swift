//
//  ExportByDiagnosisViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/05/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit
import DropDown


@available(iOS 13.0, *)
class ExportByDiagnosisViewController: UIViewController {

      var patientDataInCsvList : [CsvExportDataModel]?
      var patientSearchModelList: [PatientSearchModel]?
      @IBOutlet weak var diagnosisTypeLabelView: UIView!
      
      @IBOutlet weak var diagnosisTypeLabelView2: UIView!
      
      @IBOutlet weak var diagnosisTypeLabelView3: UIView!
      
      @IBOutlet weak var numberOfRecodsDisplayLabel: UILabel!
      
    @IBOutlet weak var seachButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
      // let uiPicvkerView = UIPickerView()
      var dataList = ["Select Diagnosis","Aphakia","Cataract", "Choroidal Effusion","Choroidal Hemorrhage","Diabetic TRD", "Dislocated Intraocular Lens","Endophthalmitis","Epiretinal Membrane","FEVR","Vitreous Opacities","Full Thickness Macular Hole", "Intraocular Foreign Body","Lamellar Macular Hole","Lattice Degeneration", "PDR,Primary RD with PVR","RecurrentRD with PVr","Recurrent RD without PVR","Retained Lens Fragments","Retinal Tear","Retinal Vein Occlusion", "Rhegmatogenous RD (Macula Off)","Rhegmatogenous RD (Macula On)","ROP", "Sickle Cell","s/p RD Repair with Silicone Oil","Subluxed Crystalline Lens","Vitreous Hemorrhage", "Retinal Defect NOS", ]
      var selectedItem = ""
      var queryStatus = 0
      
      let dropDown = DropDown()
      
      @IBOutlet weak var diagnosisTypeLabel: UILabel!
      
      @IBOutlet weak var diagnosisTypeLabel2: UILabel!
      
      
      @IBOutlet weak var diagnosisTypeLabel3: UILabel!
      
      override func viewWillAppear(_ animated: Bool) {
        //  surgeryTypeLabel.text = "Membrane peel"
          exportButton.isHidden = true
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
         
          
          ///------ For Surgery Type 1
         let gestureDiagnosisType = UITapGestureRecognizer(target: self , action: #selector(self.WhenDiagnosisTypeViewWasPressed))
            self.diagnosisTypeLabelView.addGestureRecognizer(gestureDiagnosisType)

          diagnosisTypeLabelView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
          diagnosisTypeLabelView.layer.borderWidth = 3.0
          
        exportButton.layer.cornerRadius = 5
        seachButton.layer.cornerRadius = 5
       
          ///------ For Surgery Type 2
                let gestureDiagnosisType2 = UITapGestureRecognizer(target: self , action: #selector(self.WhenDiagnosisType2ViewWasPressed))
                   self.diagnosisTypeLabelView2.addGestureRecognizer(gestureDiagnosisType2)

                 diagnosisTypeLabelView2.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                 diagnosisTypeLabelView2.layer.borderWidth = 3.0
          
          ///------ For Surgery Type 3
          let gestureDiagnosisType3 = UITapGestureRecognizer(target: self , action: #selector(self.WhenDiagnosisType3ViewWasPressed))
             self.diagnosisTypeLabelView3.addGestureRecognizer(gestureDiagnosisType3)

           diagnosisTypeLabelView3.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
           diagnosisTypeLabelView3.layer.borderWidth = 3.0
          
          
          
      }
      // When Surgery type one was preseed
      @objc func WhenDiagnosisTypeViewWasPressed() {
          queryStatus = 1
          print("view clicked")
          dropDown.anchorView = diagnosisTypeLabelView
                 dropDown.dataSource = dataList
         
          dropDown.show()
                 
                 // Action triggered on selection
                 dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                  self.diagnosisTypeLabel.text = item
                 // self.selectedItem = item
                  
                 }
      }
      
      // When Surgery type 2 was preseed
         @objc func WhenDiagnosisType2ViewWasPressed() {
            
            if diagnosisTypeLabel.text == "Select Diagnosis" {
                print("Please Select Diagnosis 1")
                displayAlertMessage(messageToDisplay: "Please Select Diagnosis 1")
            }
            else{
                
            queryStatus = 2
             
             print("view clicked")
             dropDown.anchorView = diagnosisTypeLabelView2
                    dropDown.dataSource = dataList
            
             dropDown.show()
                    
                    // Action triggered on selection
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        self.diagnosisTypeLabel2.text = item
                    // self.selectedItem = item
                     
                    }
            }
         }
      
      // When Surgery type 3 was preseed
         @objc func WhenDiagnosisType3ViewWasPressed() {
             
            if diagnosisTypeLabel2.text == "Select Diagnosis" {
                           print("Please Select Diagnosis 2")
                
                 displayAlertMessage(messageToDisplay: "Please Select Diagnosis 2")
                       }
                       else{
                queryStatus = 3
             print("view clicked")
             dropDown.anchorView = diagnosisTypeLabelView3
                    dropDown.dataSource = dataList
            
             dropDown.show()
                    
                    // Action triggered on selection
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                     self.diagnosisTypeLabel3.text = item
                    // self.selectedItem = item
                     
                    }
            }
         }
      
      
      
      // floater is equals to “vitreous opacities
    //------------------------------------------------
      
      @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
          
         
        //For Diagnosis Type 1
        
        var value = ""
        
        switch diagnosisTypeLabel.text {
        case "Aphakia" : value = "aphakia"
            break
        case "Cataract" :  value = "cataract"
            break
        case "Choroidal Effusion" : value = "choroidalEffusion"
            break
        case "Choroidal Hemorrhage" : value = "choroidalHemorrhage"
            break
        case "Diabetic TRD" : value = "diabeticTrd"
            break
        case "Dislocated Intraocular Lens" : value = "dislocatedIntraocularLens"
            break
        case "Endophthalmitis" : value = "endophthalmitis"
            break
        case "Epiretinal Membrane" : value = "epiretinalMembrane"
            break
        case "FEVR" : value = "fevr"
            break
        case "Floaters" : value = "floaters"
            break
        case "Full Thickness Macular Hole" : value = "fullThicknessMacularHole"
            break
        case "Intraocular Foreign Body" : value = "intraocularForeignBody"
            break
        case "Lamellar Macular Hole" : value = "lamellarMacularHole"
            break
        case "Lattice Degeneration" : value = "latticeDegeneration"
            break
        case "PDR" : value = "pdr"
            break
        case "Primary RD with PVR"  : value = "primaryRdWithPvr"
            break
        case "RecurrentRD with PVR" : value = "recurrentRdWithPvr"
            break
        case "Recurrent RD without PVR" : value = "recurrentRdWithOutPvr"
            break
        case "Retained Lens Fragments" : value = "retainedLensFragments"
            break
        case "Retinal Tear" : value = "retinalTear"
            break
        case "Retinal Vein Occlusion" : value = "retinalVeinOcclusion"
            break
        case "Rhegmatogenous RD (Macula Off)" : value = "rhegmatogenousRdMaculaOff"
            break
        case "Rhegmatogenous RD (Macula On" : value = "rhegmatogenousRdMaculaOn"
            break
        case "ROP" : value = "rop"
            break
        case "Sickle Cell" : value = "sickleCell"
            break
        case "s/p RD Repair with Silicone Oil" : value = "spRdRepairWithSiliconeOil"
            break
        case "Subluxed Crystalline Lens" : value = "subluxedCrystallineLens"
            break
        case "Vitreous Hemorrhage" : value = "vitreousHemorrhage"
            break
        case "Retinal Defect,NOS" : value = "retinalDefect"
            break
            
            
            
        default:
                print("Not in the option ")
        }
        
        //For Diagnosis Type 2
               
               var value2 = ""
               
               switch diagnosisTypeLabel2.text {
               case "Aphakia" : value2 = "aphakia"
                   break
               case "Cataract" :  value2 = "cataract"
                   break
               case "Choroidal Effusion" : value2 = "choroidalEffusion"
                   break
               case "Choroidal Hemorrhage" : value2 = "choroidalHemorrhage"
                   break
               case "Diabetic TRD" : value2 = "diabeticTrd"
                   break
               case "Dislocated Intraocular Lens" : value2 = "dislocatedIntraocularLens"
                   break
               case "Endophthalmitis" : value2 = "endophthalmitis"
                   break
               case "Epiretinal Membrane" : value2 = "epiretinalMembrane"
                   break
               case "FEVR" : value2 = "fevr"
                   break
               case "Floaters" : value2 = "floaters"
                   break
               case "Full Thickness Macular Hole" : value2 = "fullThicknessMacularHole"
                   break
               case "Intraocular Foreign Body" : value2 = "intraocularForeignBody"
                   break
               case "Lamellar Macular Hole" : value2 = "lamellarMacularHole"
                   break
               case "Lattice Degeneration" : value2 = "latticeDegeneration"
                   break
               case "PDR" : value2 = "pdr"
                   break
               case "Primary RD with PVR"  : value2 = "primaryRdWithPvr"
                   break
               case "RecurrentRD with PVR" : value2 = "recurrentRdWithPvr"
                   break
               case "Recurrent RD without PVR" : value2 = "recurrentRdWithOutPvr"
                   break
               case "Retained Lens Fragments" : value2 = "retainedLensFragments"
                   break
               case "Retinal Tear" : value2 = "retinalTear"
                   break
               case "Retinal Vein Occlusion" : value2 = "retinalVeinOcclusion"
                   break
               case "Rhegmatogenous RD (Macula Off)" : value2 = "rhegmatogenousRdMaculaOff"
                   break
               case "Rhegmatogenous RD (Macula On" : value2 = "rhegmatogenousRdMaculaOn"
                   break
               case "ROP" : value2 = "rop"
                   break
               case "Sickle Cell" : value2 = "sickleCell"
                   break
               case "s/p RD Repair with Silicone Oil" : value2 = "spRdRepairWithSiliconeOil"
                   break
               case "Subluxed Crystalline Lens" : value2 = "subluxedCrystallineLens"
                   break
               case "Vitreous Hemorrhage" : value2 = "vitreousHemorrhage"
                   break
               case "Retinal Defect,NOS" : value2 = "retinalDefect"
                   break
                   
                   
                   
               default:
                       print("Not in the option ")
               }
        
        //For Diagnosis Type 3
                      
                      var value3 = ""
                      
                      switch diagnosisTypeLabel3.text {
                      case "Aphakia" : value3 = "aphakia"
                          break
                      case "Cataract" :  value3 = "cataract"
                          break
                      case "Choroidal Effusion" : value3 = "choroidalEffusion"
                          break
                      case "Choroidal Hemorrhage" : value3 = "choroidalHemorrhage"
                          break
                      case "Diabetic TRD" : value3 = "diabeticTrd"
                          break
                      case "Dislocated Intraocular Lens" : value3 = "dislocatedIntraocularLens"
                          break
                      case "Endophthalmitis" : value3 = "endophthalmitis"
                          break
                      case "Epiretinal Membrane" : value3 = "epiretinalMembrane"
                          break
                      case "FEVR" : value3 = "fevr"
                          break
                      case "Floaters" : value3 = "floaters"
                          break
                      case "Full Thickness Macular Hole" : value3 = "fullThicknessMacularHole"
                          break
                      case "Intraocular Foreign Body" : value3 = "intraocularForeignBody"
                          break
                      case "Lamellar Macular Hole" : value3 = "lamellarMacularHole"
                          break
                      case "Lattice Degeneration" : value3 = "latticeDegeneration"
                          break
                      case "PDR" : value3 = "pdr"
                          break
                      case "Primary RD with PVR"  : value3 = "primaryRdWithPvr"
                          break
                      case "RecurrentRD with PVR" : value3 = "recurrentRdWithPvr"
                          break
                      case "Recurrent RD without PVR" : value3 = "recurrentRdWithOutPvr"
                          break
                      case "Retained Lens Fragments" : value3 = "retainedLensFragments"
                          break
                      case "Retinal Tear" : value3 = "retinalTear"
                          break
                      case "Retinal Vein Occlusion" : value3 = "retinalVeinOcclusion"
                          break
                      case "Rhegmatogenous RD (Macula Off)" : value3 = "rhegmatogenousRdMaculaOff"
                          break
                      case "Rhegmatogenous RD (Macula On" : value3 = "rhegmatogenousRdMaculaOn"
                          break
                      case "ROP" : value3 = "rop"
                          break
                      case "Sickle Cell" : value3 = "sickleCell"
                          break
                      case "s/p RD Repair with Silicone Oil" : value3 = "spRdRepairWithSiliconeOil"
                          break
                      case "Subluxed Crystalline Lens" : value3 = "subluxedCrystallineLens"
                          break
                      case "Vitreous Hemorrhage" : value3 = "vitreousHemorrhage"
                          break
                      case "Retinal Defect,NOS" : value3 = "retinalDefect"
                          break
                          
                          
                          
                      default:
                              print("Not in the option ")
                      }
          
          
        
          
                    if diagnosisTypeLabel.text == "Select Diagnosis" {
                             print("Please select the Diagnosis 1 ")
                     displayAlertMessage(messageToDisplay: "Please Select Diagnosis 1")
                             return
                         }
                         // Conditions
                       if diagnosisTypeLabel2.text == "Select Diagnosis" && diagnosisTypeLabel3.text == "Select Diagnosis" {
                                  queryStatus = 1
                              }
                              else if diagnosisTypeLabel2.text != "Select Diagnosis" && diagnosisTypeLabel3.text == "Select Diagnosis" {
                                   queryStatus = 2
                              }
                              else if  diagnosisTypeLabel.text != "Select Diagnosis" &&  diagnosisTypeLabel2.text != "Select Diagnosis" && diagnosisTypeLabel3.text != "Select Diagnosis" {
                                   queryStatus = 3
                              }
                              else {
                                  print("Not an option")
                              }
          
          
          
          
          
          
          
          
          
          
        
          do {
            patientDataInCsvList = try! DatabaseManager.shared.loadPatientDetailsForExportByDiagnosis(withID: value, diagnosisType2: value2, diagnosisType3: value3, diagnosisStatus: "Yes", queryStatus: queryStatus)
              
        
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
          let fileName = "PatientDetailsByDiagnosisType.csv"
          let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
         
          var csvText = "Last Name,First Name,Date Of Birth,MRN(Medical Record Number),Eye Type,Fellow Involvement,Fellow Name, Surgery Setting,Hospital/ASC Name,Surgery Date,Aphakia,Cataract , Choroidal Effusion,Choroidal Hemorrhage,Diabetic TRD, Dislocated Intraocular Lens,Endophthalmitis,Epiretinal Membrane,FEVR,Vitreous Opacities,Full Thickness Macular Hole, Intraocular Foreign Body,Lamellar Macular Hole,Lattice Degeneration, PDR,Primary RD with PVR,RecurrentRD with PVr,Recurrent RD without PVR,Retained Lens Fragments,Retinal Tear,Retinal Vein Occlusion, Rhegmatogenous RD (Macula Off),Rhegmatogenous RD (Macula On),ROP, Sickle Cell,s/p RD Repair with Silicone Oil,Subluxed Crystalline Lens,Vitreous Hemorrhage,Other Field 1, Other Field 2, Other Field 3,Other Field 4,Gauge,band,sleeve,SRF Drain,AC Tap,Membrane Peel,ILM Peel,Retinectomy, Fluid Air Exchange,PFO,Focal Endolaser, PRP Laser, Indirect Laser Tear,IOL Exchange,ACIOL,Sulcus IOL,Sutured,Sutureless, PPL with Frag,PPL without Frag,Tamponade 1,Percentage Tamponade,OtherField Tamponade, Other Field 2 Surgery , Virectomy , Scleral Buckle , IOL Insertion ,Silicone Oil Removal , Silicone Oil Exchange, Choroidal Drainage , IOL Name , IOL Power , Positioning , Comments,Redetached before POM3?, Macular Hole Closed? ,POM1 Visual Acuity,POM 3 Visual Acuity,Other Outcomes Data ,CPT Code , IOL Reposition  ,CPT Field ,Cryotherapy , ILM Peel Code , Fellow Involvement Percentage , Retinal Defect NOS \n"
          
        
          let count = (patientDataInCsvList?.count)!
          
          if count > 0 {
          
          for patientDataInCsv  in patientDataInCsvList! {
              
              let newLine = "\(patientDataInCsv.lastName!), \(patientDataInCsv.firstname!),\(patientDataInCsv.dob!), \(patientDataInCsv.mrn!), \(patientDataInCsv.eye!), \(patientDataInCsv.fellowInvolvement!),\(patientDataInCsv.level!), \(patientDataInCsv.surgerySetting!), \(patientDataInCsv.hospitalName!), \(patientDataInCsv.date!), \(patientDataInCsv.aphakia!), \(patientDataInCsv.cataract!) , \(patientDataInCsv.choroidalEffusion!), \(patientDataInCsv.choroidalHemorrhage!), \(patientDataInCsv.diabeticTrd!), \(patientDataInCsv.dislocatedIntraocularLens!), \(patientDataInCsv.endophthalmitis!), \(patientDataInCsv.epiretinalMembrane!), \(patientDataInCsv.fevr!), \(patientDataInCsv.floaters!), \(patientDataInCsv.fullThicknessMacularHole!), \(patientDataInCsv.intraocularForeignBody!), \(patientDataInCsv.lamellarMacularHole!), \(patientDataInCsv.latticeDegeneration!), \(patientDataInCsv.pdr!), \(patientDataInCsv.primaryRdWithPvr!), \(patientDataInCsv.recurrentRdWithPvr!), \(patientDataInCsv.recurrentRdWithOutPvr!) , \(patientDataInCsv.retainedLensFragments!), \(patientDataInCsv.retinalTear!), \(patientDataInCsv.retinalVeinOcclusion!), \(patientDataInCsv.rhegmatogenousRdMaculaOff!) , \(patientDataInCsv.rhegmatogenousRdMaculaOn!), \(patientDataInCsv.rop!) , \(patientDataInCsv.sickleCell!) , \(patientDataInCsv.spRdRepairWithSiliconeOil!) , \(patientDataInCsv.subluxedCrystallineLens!), \(patientDataInCsv.vitreousHemorrhage!),\(patientDataInCsv.otherField!) ,\(patientDataInCsv.otherField2!), \(patientDataInCsv.otherField3!) , \(patientDataInCsv.otherField4!), \(patientDataInCsv.gauge!), \(patientDataInCsv.band!), \(patientDataInCsv.sleeve!), \(patientDataInCsv.srfDrain!), \(patientDataInCsv.acTap!), \(patientDataInCsv.radialElement!), \(patientDataInCsv.membranePeel!) , \(patientDataInCsv.ilmPeel!), \(patientDataInCsv.retinectomy!), \(patientDataInCsv.fluidAirExchange!), \(patientDataInCsv.pfo!), \(patientDataInCsv.focalEndolaser!), \(patientDataInCsv.prpLaser!), \(patientDataInCsv.indirectLaserTear!), \(patientDataInCsv.iolExchange!), \(patientDataInCsv.aciol!), \(patientDataInCsv.sulcusIol!),\(patientDataInCsv.sutured!), \(patientDataInCsv.sutureless!), \(patientDataInCsv.pplWithFrag!), \(patientDataInCsv.pplWithoutFrag!), \(patientDataInCsv.tamponade2!), \(patientDataInCsv.percentageTamponade!) ,\(patientDataInCsv.otherFieldTamponade!) , \(patientDataInCsv.otherField2Surgery!) ,\(patientDataInCsv.virectomy!) ,\(patientDataInCsv.scleralBuckle!) , \(patientDataInCsv.iolInsertion!) , \(patientDataInCsv.siliconeOilRemoval!), \(patientDataInCsv.siliconeOilExchange!), \(patientDataInCsv.corodialDrainage!) , \(patientDataInCsv.iolName!) , \(patientDataInCsv.iolPower!) , \(patientDataInCsv.positioning!) , \(patientDataInCsv.comments!),\(patientDataInCsv.retinalDetachment!) ,\(patientDataInCsv.macularHoleClosed!) , \(patientDataInCsv.pomVisualAcuity!) , \(patientDataInCsv.pom3VisualAcuity!) , \(patientDataInCsv.otherOutcomeData!) , \(patientDataInCsv.cptCodeDropdown!) , \(patientDataInCsv.iolReposition!) , \(patientDataInCsv.cptFreeTextBox!) , \(patientDataInCsv.cryotherapy!) , \(patientDataInCsv.ilmCodeDropdown!) ,\(patientDataInCsv.fellowInvolvementPercentage!) , \(patientDataInCsv.retinalDefect!) \n"
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



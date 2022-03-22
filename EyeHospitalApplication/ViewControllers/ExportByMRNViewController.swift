//
//  ExportByMRNViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/05/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ExportByMRNViewController: UIViewController {

    @IBOutlet weak var mrnTextField: UITextField!
    var patientDataInCsvList : [CsvExportDataModel]?
    var patientSearchModelList: [PatientSearchModel]?
    
    
    @IBOutlet weak var numberOfRecodsDisplayLabel: UILabel!
    @IBOutlet weak var exportButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exportButton.isHidden = true

        exportButton.layer.cornerRadius = 5
        searchButton.layer.cornerRadius = 5 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
             
        var mrnString = mrnTextField.text
        
        if mrnString == "" {
            print("Please eenter the MRN")
            return
        }
        
        
          
             
             
           
             do {
                patientDataInCsvList = try! DatabaseManager.shared.loadPatientDetailsForExportByMRN(withID: mrnString!)
                 
           
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
             let fileName = "PatientDetailsByMRN.csv"
             let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            
             var csvText = "Last Name,First Name,Date Of Bith,MRN(Medical Record Number),Eye Type,Fellow Involvement,Fellow Name, Surgery Setting,Hospital/ASC Name,Surgery Date,Aphakia,Cataract , Choroidal Effusion,Choroidal Hemorrhage,Diabetic TRD, Dislocated Intraocular Lens,Endophthalmitis,Epiretinal Membrane,FEVR,Floaters,Full Thickness Macular Hole, Intraocular Foreign Body,Lamellar Macular Hole,Lattice Degeneration, PDR,Primary RD with PVR,RecurrentRD with PVr,Recurrent RD without PVR,Retained Lens Fragments,Retinal Tear,Retinal Vein Occlusion, Rhegmatogenous RD (Macula Off),Rhegmatogenous RD (Macula On),ROP, Sickle Cell,s/p RD Repair with Silicone Oil,Subluxed Crystalline Lens,Vitreous Hemorrhage,Other Field 1, Other Field 2, Other Field 3,Other Field 4,Gauge,band,sleeve, SRF Drain,AC Tap, Radial Element,Membrane Peel,ILM Peel,Retinectomy, Fluid Air Exchange,PFO,Focal Endolaser, PRP Laser, Indirect Laser Tear,IOL Exchange,ACIOL,Sulcus IOL,Sutured,Sutureless, PPL with Frag,PPL without Frag,Tamponade 1,Percentage Tamponade,OtherField Tamponade, Other Field 2 Surgery , Virectomy , Scleral Buckle , IOL Insertion ,Silicone Oil Removal , Silicone Oil Exchange, Choroidal Drainage, IOL Name , IOL Power , Positioning , Comments,Redetached before POM3?, Macular Hole Closed? ,POM1 Visual Acuity,POM 3 Visual Acuity,Other Outcomes Data ,CPT Code , IOL Reposition  ,CPT Field ,Cryotherapy , ILM Code , Fellow Involvement Percentage , Retinal Defect NOS   \n"
             
           
             let count = (patientDataInCsvList?.count)!
             
             if count > 0 {
             
             for patientDataInCsv  in patientDataInCsvList! {
                 
                 let newLine = "\(patientDataInCsv.lastName!), \(patientDataInCsv.firstname!),\(patientDataInCsv.dob!), \(patientDataInCsv.mrn!), \(patientDataInCsv.eye!), \(patientDataInCsv.fellowInvolvement!),\(patientDataInCsv.level!), \(patientDataInCsv.surgerySetting!), \(patientDataInCsv.hospitalName!), \(patientDataInCsv.date!), \(patientDataInCsv.aphakia!), \(patientDataInCsv.cataract!) , \(patientDataInCsv.choroidalEffusion!), \(patientDataInCsv.choroidalHemorrhage!), \(patientDataInCsv.diabeticTrd!), \(patientDataInCsv.dislocatedIntraocularLens!), \(patientDataInCsv.endophthalmitis!), \(patientDataInCsv.epiretinalMembrane!), \(patientDataInCsv.fevr!), \(patientDataInCsv.floaters!), \(patientDataInCsv.fullThicknessMacularHole!), \(patientDataInCsv.intraocularForeignBody!), \(patientDataInCsv.lamellarMacularHole!), \(patientDataInCsv.latticeDegeneration!), \(patientDataInCsv.pdr!), \(patientDataInCsv.primaryRdWithPvr!), \(patientDataInCsv.recurrentRdWithPvr!), \(patientDataInCsv.recurrentRdWithOutPvr!) , \(patientDataInCsv.retainedLensFragments!), \(patientDataInCsv.retinalTear!), \(patientDataInCsv.retinalVeinOcclusion!), \(patientDataInCsv.rhegmatogenousRdMaculaOff!) , \(patientDataInCsv.rhegmatogenousRdMaculaOn!), \(patientDataInCsv.rop!) , \(patientDataInCsv.sickleCell!) , \(patientDataInCsv.spRdRepairWithSiliconeOil!) , \(patientDataInCsv.subluxedCrystallineLens!), \(patientDataInCsv.vitreousHemorrhage!),\(patientDataInCsv.otherField!) ,\(patientDataInCsv.otherField2!), \(patientDataInCsv.otherField3!) , \(patientDataInCsv.otherField4!), \(patientDataInCsv.gauge!), \(patientDataInCsv.band!), \(patientDataInCsv.sleeve!),  \(patientDataInCsv.srfDrain!), \(patientDataInCsv.acTap!),\(patientDataInCsv.radialElement!) ,  \(patientDataInCsv.membranePeel!) , \(patientDataInCsv.ilmPeel!), \(patientDataInCsv.retinectomy!), \(patientDataInCsv.fluidAirExchange!), \(patientDataInCsv.pfo!), \(patientDataInCsv.focalEndolaser!), \(patientDataInCsv.prpLaser!), \(patientDataInCsv.indirectLaserTear!), \(patientDataInCsv.iolExchange!), \(patientDataInCsv.aciol!), \(patientDataInCsv.sulcusIol),\(patientDataInCsv.sutured!), \(patientDataInCsv.sutureless!), \(patientDataInCsv.pplWithFrag!), \(patientDataInCsv.pplWithoutFrag!), \(patientDataInCsv.tamponade2!), \(patientDataInCsv.percentageTamponade!) ,\(patientDataInCsv.otherFieldTamponade!) , \(patientDataInCsv.otherField2Surgery!) ,\(patientDataInCsv.virectomy!) ,\(patientDataInCsv.scleralBuckle!) , \(patientDataInCsv.iolInsertion!) , \(patientDataInCsv.siliconeOilRemoval!), \(patientDataInCsv.siliconeOilExchange!),\(patientDataInCsv.corodialDrainage!) , \(patientDataInCsv.iolName!) , \(patientDataInCsv.iolPower!) , \(patientDataInCsv.positioning!) , \(patientDataInCsv.comments!),\(patientDataInCsv.retinalDetachment!) ,\(patientDataInCsv.macularHoleClosed!)  \(patientDataInCsv.pomVisualAcuity!) , \(patientDataInCsv.pom3VisualAcuity!) , \(patientDataInCsv.otherOutcomeData!)  ,'\(patientDataInCsv.cptCodeDropdown!)' , '\(patientDataInCsv.iolReposition!)' , '\(patientDataInCsv.cptFreeTextBox!)' , '\(patientDataInCsv.cryotherapy!)' , '\(patientDataInCsv.ilmCodeDropdown!)' ,'\(patientDataInCsv.fellowInvolvementPercentage!)' ,'\(patientDataInCsv.retinalDefect)' \n"
               
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
         
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

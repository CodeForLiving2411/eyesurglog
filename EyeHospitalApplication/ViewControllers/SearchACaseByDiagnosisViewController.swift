//
//  SearchACaseByDiagnosisViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 15/05/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit
import DropDown

@available(iOS 13.0, *)
class SearchACaseByDiagnosisViewController: UIViewController {

  var patientSearchModelList: [PatientSearchModel]?
     @IBOutlet weak var diagnosisTypeLabelView: UIView!
     let uiPicvkerView = UIPickerView()
     var dataList = ["Select Diagnosis","Aphakia","Cataract", "Choroidal Effusion","Choroidal Hemorrhage","Diabetic TRD", "Dislocated Intraocular Lens","Endophthalmitis","Epiretinal Membrane","FEVR","Full Thickness Macular Hole", "Intraocular Foreign Body","Lamellar Macular Hole","Lattice Degeneration", "PDR","Primary RD with PVR","Recurrent RD with PVR","Recurrent RD without PVR","Retained Lens Fragments","Retinal Tear", "Retinal Vein Occlusion", "Rhegmatogenous RD (Macula Off)","Rhegmatogenous RD (Macula On)","ROP", "Retinal Defect NOS" ,"Sickle Cell","s/p RD Repair with Silicone Oil","Subluxed Crystalline Lens" ,"Vitreous Hemorrhage" ,"Vitreous Opacities" ]
     
     
    @IBOutlet weak var searchButton: UIButton!
    var selectedItem = ""
     
     let dropDown = DropDown()
     
     @IBOutlet weak var diagnosisTypeLabel: UILabel!
     
    
     
     override func viewWillAppear(_ animated: Bool) {
         //surgeryTypeLabel.text = "Membrane peel"
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
        
        
         searchButton.layer.cornerRadius = 5 
        let gestureDiagnosisType = UITapGestureRecognizer(target: self , action: #selector(self.WhenSurgeryTypeViewWasPressed))
           self.diagnosisTypeLabelView.addGestureRecognizer(gestureDiagnosisType)

         diagnosisTypeLabelView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
         diagnosisTypeLabelView.layer.borderWidth = 3.0
     }
     
     @objc func WhenSurgeryTypeViewWasPressed() {

         print("view clicked")
         dropDown.anchorView = diagnosisTypeLabelView
                dropDown.dataSource = dataList

         dropDown.show()

                // Action triggered on selection
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                 self.diagnosisTypeLabel.text = item
                 self.selectedItem = item

                }
     }
     
     
     
     
     @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
         
        var value = self.selectedItem
              
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
              case "Vitreous Opacities" : value = "floaters"
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
                  
              case "Retinal Defect NOS" : value = "retinalDefect"
                  break
                  
                  
                  
              default:
                      value = "Select Diagnosis"
              }
              
             
        if value == "Select Diagnosis" {
            
            print("Please select the Diagnosis")
            displayAlertMessage(messageToDisplay: "Please select the Diagnosis")
        }
        else {
        
         do {
            patientSearchModelList = try! DatabaseManager.shared.loadPatientSearchDetailsByDiagnosisType(withID: value , diagnosisStatus: "Yes")
             
       
         print("the values of patient search model lisr at search" , patientSearchModelList)
             
         }
         catch {
              print(error.localizedDescription)
         }
                     if patientSearchModelList == nil {
                                print("No Data Found")
                                displayAlertMessage(messageToDisplay: "No Data Found")
                            }
                            else{
               performSegue(withIdentifier: "seachByDiagnosisTypeToCases", sender: self)
         }
        }
         
     }
     
     @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "seachByDiagnosisTypeToCases" {
               
            let vc = segue.destination as!
                
                PatientSearchDetailsViewController
                vc.patientSearchModelList1 = patientSearchModelList
                vc.selectedDiagnosis = self.selectedItem
                vc.surgeryStatus = "Yes"
                vc.viewControlerId = 4
            
                vc.headingTittle = "Patient List(Diagnosis)"
             
                
            }
        }
    // Message To Display (Alert Controller )
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

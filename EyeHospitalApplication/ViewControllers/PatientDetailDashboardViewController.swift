//
//  PatientDetailDashboardViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 17/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PatientDetailDashboardViewController: UIViewController {
    var uniqueIdDashboard = 0
    var demographicsDetailsList : [Any] = []
    var diagnosisDetailsList : [Any] = []
    var surgeryDetailsList : [Any] = []
    var imageDetailsList : [Any] = []
   
   
    @IBOutlet weak var demographicButton: UIButton!
    
    @IBOutlet weak var diagnosisButton: UIButton!
    
    @IBOutlet weak var surgeryButton: UIButton!
    
    @IBOutlet weak var imageDataButton: UIButton!
    
    // title List  for Demographics Data
    var demographicsTitleList = ["First Name","Last Name", "Date of Birth", "MRN","Eye Type", "Fellow Involvement","Fellow Level","Surgery Setting","Hospital/Asc Name", "Surgery Date"]
    // title List  for Diagnosis Data
    var diagnosisTitleList = [ "Aphakia", "Cataract", "Choroidal Effusion", "Choroidal Hemorrhage", "Diabetic TRD", "Dislocated Intraocular Lens", "Endophthalmitis", "Epiretinal Membrane", "FEVR", "Floaters", "Full Thickness Macular Hole", "Intraocular Foreign Body", "Lamellar Macular Hole", "Lattice Degeneration", "PDR", "Primary RD with PVR", "Recurrent RD with PVR", "Recurrent RD without PVR", "Retained Lens Fragments", "Retinal Tear", "Retinal Vein Occlusion", "Rhegmatogenous RD (Macula Off)", "Rhegmatogenous RD (Macula On)", "ROP", "Sickle Cell", "s/p RD Repair with Silicone Oil", "Subluxed Crystalline Lens", "Vitreous Hemorrhage","Other Field 1" , "Other Field 2" , "Other Field 3" , "Other Field 4" ]
    
    // title List  for Surgery Data
    var surgeryTittleList = ["Gauge", "Band", "Sleeve", "Tamponade", "Srf Drain", "AC Tap", "Membrane Peel", "Ilm Peel", "Retinectomy", "Fluid Air Exchange", "PFO", "Focal Endolaser", "Prp Laser", "Indirect Laser Tear", "IOL Exchange", "ACIOL", "Sulcus IOL", "Sutured", "Sutureless",  "Ppl with Frag", "Ppl without Frag", "Tamponade", "Comments" ,"Redetached before POM3?","Macular Hole Closed?","POM1 Visual Acuity","POM 3 Visual Acuity","Other Outcomes Data"]


    
    override func viewDidAppear(_ animated: Bool) {
//    id = self.uniqueIdDashboard
//        print("id at PatientDetailDashboardViewController ", self.uniqueIdDashboard  )
//         print("id at PatientDetailDashboardViewController id ", id )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light    
        print("unique id at Patient DashBoard is " , uniqueIdDashboard)
        
        demographicButton.layer.cornerRadius = 5
        diagnosisButton.layer.cornerRadius = 5
        surgeryButton.layer.cornerRadius = 5
        imageDataButton.layer.cornerRadius = 5
       
        
      

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WhenDemoButtonWasPressed(_ sender: UIButton) {
       
        print("demographics button clicked")
              // here id is hard coded please change it to variable
//           demographicsDetailsList = DatabaseManager.shared.loadPatientDemographicsDetails(withID: uniqueIdDashboard)
               
     //  demographicsDetailsList.remove(at: 0) // remove the first element except all
        print("list after removing" , demographicsDetailsList)
      
        
         performSegue(withIdentifier: "dashBoardTodemoData", sender: self)
        
    }
    
   
    
   
    
    @IBAction func WhenDiagnosisButtonWasPressed(_ sender: UIButton) {
        // here id is hard coded please change it to variable
//        diagnosisDetailsList = DatabaseManager.shared.loadPatientDiagnosisDetails(withID: uniqueIdDashboard )
//        diagnosisDetailsList.remove(at: 0)
//         print("list after removing" , diagnosisDetailsList)
        
         performSegue(withIdentifier: "dashboardToDiagnosis", sender: self)
         
        
    }
  
       
    
    
    @IBAction func WhenSurgeryButtonWasPressed(_ sender: UIButton) {
         // here id is hard coded please change it to variable
//        surgeryDetailsList = DatabaseManager.shared.loadPatientSurgeryDetails(withID: uniqueIdDashboard)
//        surgeryDetailsList.remove(at: 0)
//        print("list after removing" , diagnosisDetailsList)
        
        performSegue(withIdentifier: "dashboardToSurgery", sender: self)
        
    }
    
    @IBAction func WhenImageDataButtonWasPressed(_ sender: UIButton) {
//        imageDetailsList = DatabaseManager.shared.loadCameraImageDetails(withID: uniqueIdDashboard)
//        print(" imageDetailsList", imageDetailsList)
//        imageDetailsList.remove(at: 0)
//        print("list after removing" , imageDetailsList)
        
         performSegue(withIdentifier: "dashboardToCameraImage", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // segue for PatientDetailsDashboard to Demographic Data ViewController
        if segue.identifier == "dashBoardTodemoData" {
        let vc = segue.destination as! DemographicDataListViewController
            vc.uniqueId = uniqueIdDashboard
//           vc.titleList = demographicsTitleList
//           vc.dataList = demographicsDetailsList
            
            
             }
        
        if segue.identifier == "dashboardToDiagnosis" {
               let vc = segue.destination as! DiagnosisDataListViewController
//                  vc.titleList = diagnosisTitleList
//                  vc.dataList = diagnosisDetailsList
            vc.uniqueIdFromDashBoard = uniqueIdDashboard
                   
                    }
        
        if segue.identifier == "dashboardToSurgery" {
               let vc = segue.destination as! SurgeryDataListViewViewController
//                  vc.titleList = surgeryTittleList
//                  vc.dataList  = surgeryDetailsList
            vc.uniqueIdFromDashboard = uniqueIdDashboard
                   
                    }
        if segue.identifier == "dashboardToCameraImage" {
            let vc = segue.destination as! CameraImageDataViewController
           // let imagePath = imageDetailsList[0]
           
            vc.uniqueId = uniqueIdDashboard
           // vc.imagePath1 = imagePath as! String
        }
        
        
        
    }
    
    
    
    
    
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
   
    @IBAction func WhenHomeButtonWasPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true)
    }
    
}

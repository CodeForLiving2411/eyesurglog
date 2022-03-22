//
//  PatientSearchDetailsViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 16/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

// extension for search a case details table View functions
@available(iOS 13.0, *)
extension PatientSearchDetailsViewController: UITableViewDelegate , UITableViewDataSource  {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = Int()
        if patientSearchModelList1?.count != nil {
           
             count = patientSearchModelList1!.count
        }
        else {
           count = -1
            
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"SearchCaseTableViewCell" , for: indexPath) as? SearchCaseTableViewCell  else {
            return UITableViewCell() }
        
        
        cell.firstNameLabel.text = patientSearchModelList1![indexPath.row].firstName
        cell.lastNameLAbel.text = patientSearchModelList1![indexPath.row].lastName
        cell.dateLabel.text = patientSearchModelList1![indexPath.row].surgeryDate
        cell.mrnNumber.text = patientSearchModelList1![indexPath.row].patientMrn
        cell.eyeType!.text = patientSearchModelList1![indexPath.row].eye
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "searchDetaiToDashboard", sender: self)
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
           var searchIdForDelete = patientSearchModelList1![indexPath.row].personId!
           if editingStyle == .delete {
               // Used A Delete For with another name but it will work to delete Unfinished Logged Cases
               let deleted = DatabaseManager.shared.deleteDemographicsTempDataWhenBactPressedAtDiagnosis(withID: searchIdForDelete)
               
               print("delete status" , deleted)
            
            ReloadPatientData()
          
           }
    
    }
}
   
    
    
   
        
//
      
        
      
    
    
    



@available(iOS 13.0, *)
class PatientSearchDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var patientSearchListTableView: UITableView!
    var viewControlerId = 0
    var searchid  = 0
    var headingTittle = ""
   //------------------------------
    // mrnIs This data com from SearchACaseViewController  -- Later Converted to int
    var mrnId = ""
    
     //------------------------------
     // This data is coming from SearchACaseByDateViewController
    var startDate = ""
    var endDate = ""
    
    //------------------------------
     // This data is coming from SearchACaseBySurgeryViewController
    var selectedSurgery = ""
    var surgeryStatus = ""
    
     //------------------------------
      // This data is coming from SearchACaseByDiagnosisViewController
    var selectedDiagnosis = ""
    var diagnosisStatus = ""
    
    
    @IBOutlet weak var headingTitleLabel: UILabel!
    var patientSearchModelList1: [PatientSearchModel]?   // list to fetch patient
    
    override func viewWillAppear(_ animated: Bool) {
        headingTitleLabel.text = headingTittle
        print("viewController Id" , viewControlerId)
        print("mrn" , mrnId)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light
        
       
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func WhenBackButtonPressed(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = patientSearchListTableView.indexPathForSelectedRow  {
              guard let destinationVC = segue.destination as? PatientDetailDashboardViewController else {return}
             
            let selectedRow = indexPath.row
            destinationVC.uniqueIdDashboard =
                patientSearchModelList1![selectedRow].personId!
            
          }
    }
    
    func ReloadPatientData() {
        switch viewControlerId {
        case 1:
            do {
                       
                patientSearchModelList1 =      try! DatabaseManager.shared.loadPatientSearchDetailsByMrn(withID: Int(mrnId)!)
                   }
                   catch{
                           print(error.localizedDescription)
                   }
           
            break
        case 2:
            do {
                   
            patientSearchModelList1 =      try! DatabaseManager.shared.loadPatientSearchDetailsByDate(withID: startDate , endDate: endDate  )
               }
               catch{
                       print(error.localizedDescription)
               }
            
            break
        case 3 :
            
            do {
                  patientSearchModelList1 = try! DatabaseManager.shared.loadPatientSearchDetailsByType(withID: selectedSurgery  , surgeryStatus: surgeryStatus )
                  
            
//                  print("patientcount" , patientSearchModelList?.count)
                  
              }
              catch {
                   print(error.localizedDescription)
              }
            break
        case 4 :
            do {
                      patientSearchModelList1 = try! DatabaseManager.shared.loadPatientSearchDetailsByDiagnosisType(withID: selectedDiagnosis , diagnosisStatus: diagnosisStatus)
                       
                 
                 //  print("the values of patient search model lisr at search" , patientSearchModelList)
                       
                   }
                   catch {
                        print(error.localizedDescription)
                   }
            break
        default:  print("Not an option ")
            
        }
       
        patientSearchListTableView.reloadData()
        
    }
        
        
    
        
    
    @IBAction func WhenButtonWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true)
    }
    
    
}

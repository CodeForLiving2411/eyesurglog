//
//  UnLoggedPatientSearchDetailsViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 21/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

   @available(iOS 13.0, *)
extension UnLoggedPatientSearchDetailsViewController: UITableViewDelegate , UITableViewDataSource  {
 

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var count : Int?
    count =  UnLoggedPatientSearchModelList?.count
    if count == nil {
        count = 0
    }
    else {
        count = UnLoggedPatientSearchModelList!.count
    }
    
     return count!
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     guard let cell = tableView.dequeueReusableCell(withIdentifier:"unLoggedCaseTableViewCell" , for: indexPath) as? UnloggedCaseTableViewCell  else {
         return UITableViewCell() }
     
     cell.fNameLabel.text = UnLoggedPatientSearchModelList![indexPath.row].firstName
     cell.lNameLabel.text = UnLoggedPatientSearchModelList![indexPath.row].lastName
     cell.surgDateLabel.text = UnLoggedPatientSearchModelList![indexPath.row].surgeryDate
    cell.mrnNumberLabel.text = UnLoggedPatientSearchModelList![indexPath.row].patientMrn
     
     
     
     
       return cell
     }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     
    
         searchid = UnLoggedPatientSearchModelList![indexPath.row].personId!
                
         //   vc.uniqueIdDashboard = searchid
    lastName = UnLoggedPatientSearchModelList![indexPath.row].lastName!
    firstName = UnLoggedPatientSearchModelList![indexPath.row].firstName!
    mrn =  Int(UnLoggedPatientSearchModelList![indexPath.row].patientMrn!)!
   
    surgeryDate = UnLoggedPatientSearchModelList![indexPath.row].surgeryDate!
        
        
        self.performSegue(withIdentifier: "searchToDemo1", sender: self)
       
        
   
   
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var searchIdForDelete = UnLoggedPatientSearchModelList![indexPath.row].personId!
        if editingStyle == .delete {
            // Used A Delete For with another name but it will work to delete Unfinished Logged Cases
            let deleted = DatabaseManager.shared.deleteDemographicsTempDataWhenBactPressedAtDiagnosis(withID: searchIdForDelete)
            
            print("delete status" , deleted)
            dataload()
            unLoggedCasesTableView.reloadData()
            
            
            
            
        }
    }
 
 
 }



   @available(iOS 13.0, *)
class UnLoggedPatientSearchDetailsViewController: UIViewController {
    var lastName = ""
    var firstName = ""
    var mrn = 0
    var dob = ""
    var surgeryDate = ""
    
    var tag = 2
    
    
    @IBOutlet weak var unLoggedCasesTableView: UITableView!
    var searchid : Int = 0
      
       var UnLoggedPatientSearchModelList: [PatientSearchModelUnlogged]?   // list to fetch patient
    
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

//        performSegue(withIdentifier: "searchToDemo1", sender: <#T##Any?#>)// Do any additional setup after loading the view.
    }
    
    func dataload() {
        UnLoggedPatientSearchModelList = DatabaseManager.shared.PatientUnLoggedCasesListForEditing()
        print("count" , UnLoggedPatientSearchModelList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = unLoggedCasesTableView.indexPathForSelectedRow  {
                     guard let destinationVC = segue.destination as? Demographics1_ViewController else {return}
                    
                   let selectedRow = indexPath.row
                   destinationVC.tag = 2
                   destinationVC.tempPersonID =
                       UnLoggedPatientSearchModelList![selectedRow].personId!
            destinationVC.fNameUnloggedString = UnLoggedPatientSearchModelList![indexPath.row].firstName!
            destinationVC.lNameUnloggedString = UnLoggedPatientSearchModelList![indexPath.row].lastName!
            destinationVC.dobUnloggedString = String(UnLoggedPatientSearchModelList![indexPath.row].dob!)
            destinationVC.mrnUnloggedString = String(UnLoggedPatientSearchModelList![indexPath.row].patientMrn!)
            destinationVC.surgeryDateUnloggedString = UnLoggedPatientSearchModelList![indexPath.row].surgeryDate!
            
            
                   
            
                 }
        // this code is commented -- no need to ue it in future
//        if segue.identifier == "searchToDemo1" {
//        let vc = segue.destination as! Demographics1_ViewController
//            vc.tempPersonID = self.searchid
//            vc.tag = 2
//            vc.fNameUnloggedString = self.firstName
//            vc.lNameUnloggedString = self.lastName
//            vc.mrnUnloggedString = String(self.mrn)
//
//            vc.surgeryDateUnloggedString = self.surgeryDate
        
        
     //   present(vc, animated: true, completion: nil)  --- when we use seque for goibg to other view controller no need to use present vc 
      
   //     }
      
       
    }
    
    
    
    @IBAction func WhenBackWasPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
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

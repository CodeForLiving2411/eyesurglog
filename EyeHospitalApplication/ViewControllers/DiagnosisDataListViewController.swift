//
//  DiagnosisDataListViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 18/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
 @available(iOS 13.0, *)
extension DiagnosisDataListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diagnosisDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier:"DiagnosisDataTableViewCell" , for: indexPath) as? DiagnosisDataTableViewCell  else {
                          return UITableViewCell() }
        cell.titleLabel.text = diagnosisTitleList[indexPath.row]
        cell.dataLabel.text = diagnosisDetailsList[indexPath.row] as? String
              
               return cell
           
        
    }
    
    
    
}
 @available(iOS 13.0, *)
class DiagnosisDataListViewController: UIViewController {
    

    @IBOutlet weak var diagnosisTableView: UITableView!
//    var titleList: [String]?
//    var dataList: [Any]?
    var uniqueIdFromDashBoard = 0
    var diagnosisDetailsList : [Any] = []
    var diagnosisTitleList = [ "Aphakia", "Cataract", "Choroidal Effusion", "Choroidal Hemorrhage", "Diabetic TRD", "Dislocated Intraocular Lens", "Endophthalmitis", "Epiretinal Membrane", "FEVR", "Vitreous Opacities", "Full Thickness Macular Hole", "Intraocular Foreign Body", "Lamellar Macular Hole", "Lattice Degeneration", "PDR", "Primary RD with PVR", "Recurrent RD with PVR", "Recurrent RD without PVR", "Retained Lens Fragments", "Retinal Tear", "Retinal Vein Occlusion", "Rhegmatogenous RD (Macula Off)", "Rhegmatogenous RD (Macula On)", "ROP", "Sickle Cell", "s/p RD Repair with Silicone Oil", "Subluxed Crystalline Lens", "Vitreous Hemorrhage", "Retinal Defect","Other Field 1" , "Other Field 2" , "Other Field 3" , "Other Field 4" ]
    
    override func viewWillAppear(_ animated: Bool) {
       
        diagnosisDetailsList = DatabaseManager.shared.loadPatientDiagnosisDetails(withID: uniqueIdFromDashBoard )
              diagnosisDetailsList.remove(at: 0)
        
               print("list after removing" , diagnosisDetailsList)
        diagnosisTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light    

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WhenEditButtonWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditDemographics2ViewController") as! EditDemographics2ViewController
        vc.modalPresentationStyle = .fullScreen
                      self.present(vc, animated: true, completion: nil)
        vc.uniqueId = uniqueIdFromDashBoard
        
    }
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
          dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
    }
    

}

//
//  SurgeryDataListViewViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 18/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
extension SurgeryDataListViewViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surgeryDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"SurgeryDataTableViewCell" , for: indexPath) as? SurgeryDataTableViewCell  else {
                               return UITableViewCell() }
             cell.titleLabel.text = surgeryTittleList[indexPath.row]
             cell.dataLabel.text = surgeryDetailsList[indexPath.row] as? String
             return cell
    }
    
}

@available(iOS 13.0, *)
class SurgeryDataListViewViewController: UIViewController {

    var uniqueIdFromDashboard = 0
    @IBOutlet weak var surgeryDataTableView: UITableView!
//    var titleList: [String]?
//    var dataList: [Any]?
     var surgeryDetailsList : [Any] = []
     var surgeryTittleList = ["Gauge", "Band", "Sleeve", "Tamponade", "SRF Drain", "AC Tap", "Radial Element" , "Membrane Peel", "ILM Peel", "Retinectomy", "Fluid Air Exchange", "PFO", "Focal Endolaser", "PRP Laser", "Indirect Laser Tear", "IOL Exchange", "ACIOL", "Sulcus IOL", "Sutured", "Sutureless",  "PPL with Frag", "PPL without Frag", "Tamponade","Tamponade %", "Other Field 1","Other Field 2" ,"IOL Name" , "IOL Power" ,  "Positioning" , "Silicone Oil Removal" , "Silicone Oil Exchange", "Choroidal Drainage" , "Comments" ,"Redetached before POM3?","Macular Hole Closed?","POM1 Visual Acuity","POM 3 Visual Acuity","Other Outcomes Data" , "IOL Reposition" , "CPT Code" , "CPT Field" , "Cryotherapy" ,"ILM Peel Code"]
   
    override func viewWillAppear(_ animated: Bool) {
       
        surgeryDetailsList = DatabaseManager.shared.loadPatientSurgeryDetails(withID: uniqueIdFromDashboard)
               surgeryDetailsList.remove(at: 0)
               print("list after removing" , surgeryDetailsList)
         surgeryDataTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // surgeryDataTableView.reloadData()
        
        print("value of person uniques id is " , uniqueIdFromDashboard)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func WhenOutComeButtonWasPressed(_ sender: UIButton) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OutcomesViewController") as! OutcomesViewController
        self.present(vc, animated: true, completion: nil)
        vc.personid = uniqueIdFromDashboard
        
    }
    
    
    @IBAction func WhenEditBittonWasPressed(_ sender: UIButton) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSurgeryViewController") as! EditSurgeryViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        vc.valuesurg = uniqueIdFromDashboard
      
        
        
    }
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
         
        dismiss(animated: true, completion: nil)
           
    }
    
    
    @IBAction func WhenHomeButtonWasPressed(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  "HomeViewController") as! HomeViewController
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true)
    }
    
}

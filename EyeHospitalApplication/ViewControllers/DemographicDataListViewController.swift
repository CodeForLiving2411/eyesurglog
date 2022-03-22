//
//  DemographicDataListViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 17/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
extension DemographicDataListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demographicsDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"DemographicDataTableViewCell" , for: indexPath) as? DemographicDataTableViewCell  else {
                   return UITableViewCell() }
        cell.titleLabel.text = demographicsTitleList[indexPath.row]
        cell.dataLabel.text = demographicsDetailsList[indexPath.row] as? String
        
       
        return cell
    }
    
    
    
}
@available(iOS 13.0, *)
class DemographicDataListViewController: UIViewController {

    @IBOutlet weak var DemographicsDataTableView: UITableView!
      var demographicsDetailsList : [Any] = []
    // title List  for Demographics Data
    var demographicsTitleList = ["First Name","Last Name", "Date of Birth", "MRN","Eye Type", "Fellow Involvement", "Fellow Involvement %", "Fellow Name","Surgery Setting","Hospital/Asc Name", "Surgery Date"]
    
//    var titleList: [String]?
//    var dataList: [Any]?
    
    var uniqueId = 0
    
   
    
    override func viewWillAppear(_ animated: Bool) {
       demographicsDetailsList = DatabaseManager.shared.loadPatientDemographicsDetails(withID: uniqueId)
                    
            demographicsDetailsList.remove(at: 0) // remove the first element except all
             print("list after removing" , demographicsDetailsList)
        DemographicsDataTableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light    

        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        
         dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true)
    }
    
    
    @IBAction func WhenEditButtonIsPressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditDemographicsViewController") as! EditDemographicsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        vc.tempPersonID  = uniqueId
        vc.tag = 1 
        
    }
    
}

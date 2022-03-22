//
//  ExportDashBoardViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/03/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ExportDashBoardViewController: UIViewController {
    
    
    @IBOutlet weak var exportByDOS: UIButton!
    
    @IBOutlet weak var exportByMRN: UIButton!
    
    @IBOutlet weak var exportBySurgery: UIButton!
    
    @IBOutlet weak var exportByDiagnosis: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        exportByDOS.layer.cornerRadius = 5
        exportByMRN.layer.cornerRadius = 5
        exportBySurgery.layer.cornerRadius = 5

        exportByDiagnosis.layer.cornerRadius = 5

        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
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

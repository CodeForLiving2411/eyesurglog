//
//  SearchDasnBoardViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 24/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SearchDasnBoardViewController: UIViewController {
    
    @IBOutlet weak var searchByDOS: UIButton!
    
    @IBOutlet weak var searchByMRN: UIButton!
    
    @IBOutlet weak var searchBySurgery: UIButton!
    
    @IBOutlet weak var searchByDiagnosis: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchByDOS.layer.cornerRadius = 5
        searchByMRN.layer.cornerRadius = 5
        searchBySurgery.layer.cornerRadius = 5
        searchByDiagnosis.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WhenSearchBySurgeryWasPressed(_ sender: UIButton) {
        print("Button Was Pressed!!!")
        let vc = storyboard?.instantiateViewController(identifier: "SearchACaseBySurgeryViewController")
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func WhenBackWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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

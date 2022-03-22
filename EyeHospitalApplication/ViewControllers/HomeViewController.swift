//
//  HomeViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 21/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HomeViewController: UIViewController {
    
     var patientSearchModelUnloggedList: [PatientSearchModelUnlogged]?
 //    var registrationDataList : [RegistrationModel]?  //not used
   //   let transition = SlideInTransition()

    //for now
    //var regData = RegistrationModel()
    
  
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var logACaseButton: UIButton!
    
    @IBOutlet weak var searchEditCase: UIButton!
    
    @IBOutlet weak var uncompletedCaseButton: UIButton!
    
    
    @IBOutlet weak var viewAndExportCases: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
         getUserName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light
        logACaseButton.layer.cornerRadius = 5
        searchEditCase.layer.cornerRadius = 5
        uncompletedCaseButton.layer.cornerRadius = 5
        viewAndExportCases.layer.cornerRadius = 5
        logOutButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func WhenMenuButtonWasPressed(_ sender: UIButton) {
        let vc  = storyboard?.instantiateViewController(identifier: "PopUpBarViewController") as! PopUpBarViewController
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func WhenLogACaseButtonWasPressed(_ sender: UIButton) {
         performSegue(withIdentifier: "logACaseToDemographics1", sender: self)
    }
    
    @IBAction func WhenASearchCaseButtonWasPressed(_ sender: UIButton) {
         performSegue(withIdentifier: "homeToSearchCase", sender: self)
        
    }
    
    @IBAction func WhrnUnloggedCasesButtonWasPressed(_ sender: UIButton) {
        
        patientSearchModelUnloggedList = DatabaseManager.shared.PatientUnLoggedCasesListForEditing()
         print("count" , patientSearchModelUnloggedList)
         performSegue(withIdentifier: "homeVieControllerToUnLoggedSearchCases", sender: self)
         
        
    }
    
    
    @IBAction func whenLogoutButtonWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "loginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func WhenExportDataButtonWasPressed(_ sender: Any) {
        

        let vc = storyboard?.instantiateViewController(identifier: "ExportDashBoardViewController") as! ExportDashBoardViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeVieControllerToUnLoggedSearchCases" {
             let vc = segue.destination as!
                UnLoggedPatientSearchDetailsViewController
            vc.UnLoggedPatientSearchModelList = patientSearchModelUnloggedList
        }
        
        if segue.identifier == "homeToSearchCase" {
                    let vc = segue.destination as! SearchDasnBoardViewController
                  
               }
        
        if segue.identifier == "logACaseToDemographics1" {
                   let vc = segue.destination as! Demographics1_ViewController
                         
                      }
        

                         
                      
        
      
        
        
        
         }
    
    func getUserName(){

        let fname =  UserDefaults.standard.string(forKey: "fName")
        let lname =  UserDefaults.standard.string(forKey: "lName")
        userNameLabel.text = "Hello, \(fname!) \(lname!)"
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

//@available(iOS 13.0, *)
//extension HomeViewController : UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = false
//        return transition
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = false
//        return transition
//    }
//}

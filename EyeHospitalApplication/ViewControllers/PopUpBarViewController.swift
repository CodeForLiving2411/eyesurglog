//
//  PopUpBarViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 11/02/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PopUpBarViewController: UIViewController {

    var firstNameString :String?
    var lastNameString:String?
    var affiliationString:String?
   
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var affiliationLabel: UILabel!
    
    @IBOutlet weak var changeAffiliation: UILabel!
     @IBOutlet weak var changePassword: UILabel!
    
    @IBOutlet weak var changeAffiliationUIView: UIView!
    
    @IBOutlet weak var changePasswordUIView: UIView!
    
    @IBOutlet weak var appInfoUIView: UIView!
    
//    @IBOutlet weak var userNameButton: UIButton!
//
//    @IBOutlet weak var emailIButton: UIButton!
//
//    @IBOutlet weak var affilation: UIButton!
//
    
    @IBOutlet weak var numberOfCasesCompletedLabel: UILabel!
    var noOfCompleted = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Number of Completed Cases
        noOfCompleted = DatabaseManager.shared.NumberOfCompletedCases()
        print( "noOfCompleted" ,noOfCompleted)
        
        let fname =  UserDefaults.standard.string(forKey: "fName")
        let lname =  UserDefaults.standard.string(forKey: "lName")
        let email = UserDefaults.standard.string(forKey: "emailid")
        let affiliationString = UserDefaults.standard.string(forKey: "empCode")
        NameLabel = buttomBoarder(label: NameLabel)
        NameLabel.text = "Name : \(fname!) \(lname!)"
        emailLabel = buttomBoarder(label: emailLabel)
        emailLabel.text = "Email : \(email!)"
        
        affiliationLabel = buttomBoarder(label: affiliationLabel)
        affiliationLabel.text = "Affiliation : \(affiliationString!)"
        numberOfCasesCompletedLabel = buttomBoarder(label: numberOfCasesCompletedLabel)
        numberOfCasesCompletedLabel.text = "Number of cases completed : \(noOfCompleted)"
        changeAffiliation = buttomBoarder(label: changeAffiliation)
        changePassword = buttomBoarder(label: changePassword)
        
        
        
//        userNameButton.setTitle("\(fname!) \(lname!)", for: .normal)
//        emailIButton.setTitle("\(emailid!)", for: .normal)
//        affilation.setTitle("Affliation :\(affiliationString!)", for: .normal)
//        numberOfCasesDoneButton.setTitle("Completed Cases: \(noOfCompleted)", for: .normal)
//
//
        
    }
    
    @IBOutlet weak var changePasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tap gesture recogniser for Change Affiliation Label
        let tapGestureChangeAffiliation = UITapGestureRecognizer(target: self, action: #selector(WhenChangeAffiliationWasPressed))
        changeAffiliationUIView.addGestureRecognizer(tapGestureChangeAffiliation)
        
         // tap gesture recogniser for Change Password Label
        let tapGestureChangePassword = UITapGestureRecognizer(target: self, action: #selector(WhenChangePasswordButtonWasPressed(_:)))
        changePasswordUIView.addGestureRecognizer(tapGestureChangePassword)
        
        // App Info
        
        let tapGesturAppInfo = UITapGestureRecognizer(target: self, action: #selector(WhenAppInfoButtonWasPressed))
               appInfoUIView.addGestureRecognizer(tapGesturAppInfo)
        
        
      

        // Do any additional setup after loading the view.
    }
    
    
    @objc func WhenChangeAffiliationWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "ChangeHospitalNameViewController") as! ChangeHospitalNameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
   
    @objc func WhenChangePasswordButtonWasPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as! ChangePasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
      
    }
    
    @objc func WhenAppInfoButtonWasPressed() {
        let vc = storyboard?.instantiateViewController(identifier: "FaqViewController") as! FaqViewController
               vc.modalPresentationStyle = .automatic
               present(vc, animated: true, completion: nil)
             
        
    }
    
    func buttomBoarder(label: UILabel) -> UILabel {
        let frame = label.frame

        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 2)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        label.layer.addSublayer(bottomLayer)

        return label

    }
    
    
    @IBAction func WhenDownButtonWasPressed(_ sender: UIButton) {
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

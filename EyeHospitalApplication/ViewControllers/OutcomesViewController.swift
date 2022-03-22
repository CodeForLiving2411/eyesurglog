//
//  OutcomesViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 30/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

class OutcomesViewController: UIViewController {
    

    var personid = 0
    @IBOutlet weak var retinalDetachmentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var macularHoleClosedSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var pom1TextField: UITextField!
    
    @IBOutlet weak var pom3TextField: UITextField!
    
    @IBOutlet weak var otherOutcomes: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        
         print("person id at pop over vc  is " , personid)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButtonForKeyboard()
        
       

        // Do any additional setup after loading the view.
    }
    

    @IBAction func WhenSubmitButtonWasPressed(_ sender: Any) {
        
        
        
        let retinalDetachmentSeg = retinalDetachmentSegmentedControl.titleForSegment(at: retinalDetachmentSegmentedControl.selectedSegmentIndex)
       
        let macularHoleClosedSeg = macularHoleClosedSegmentedControl.titleForSegment(at: macularHoleClosedSegmentedControl.selectedSegmentIndex)
        
        let pomVisualAcuityText = pom1TextField.text!
        let pom3VisualAcuityText = pom3TextField.text!
        let otherOutcomeDataText = otherOutcomes.text!
        
        
        
       let inserted =  DatabaseManager.shared.UpdateOutcomesDataInSurgeryTable(personid: personid, retinalDetachment: retinalDetachmentSeg! , macularHoleClosed: macularHoleClosedSeg! , pomVisualAcuity: pomVisualAcuityText, pom3VisualAcuity: pom3VisualAcuityText, otherOutcomeData: otherOutcomeDataText)
        
        print("inserted outcomes data ", inserted)
        
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    func doneButtonForKeyboard(){
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
           
           
           toolbar.setItems([flexibleSpace,doneButton], animated: false)
           
         pom1TextField.inputAccessoryView = toolbar
         pom3TextField.inputAccessoryView = toolbar
         otherOutcomes.inputAccessoryView = toolbar
           
          }
       
       @objc func doneClicked(){
           view.endEditing(true)
       }
    
       
    @IBAction func WhenCrossButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

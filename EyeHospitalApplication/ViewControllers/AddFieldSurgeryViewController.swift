//
//  AddFieldSurgeryViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 21/03/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

protocol AddFieldDelegateSurgery  {
    func addFieldSelectionDelegate(otherSpace : String , otherSpace1 : String )
  
}

class AddFieldSurgeryViewController: UIViewController {
    var addFieldDelegateSurgery : AddFieldDelegateSurgery?
    @IBOutlet weak var OtherFieldTextField: UITextField!
    @IBOutlet weak var OtherFieldTextField2 : UITextField!
    var txtField1 = ""
    var txtField2 = ""
    
    override func viewWillAppear(_ animated: Bool) {
        OtherFieldTextField.text = txtField1
        OtherFieldTextField2.text = txtField2
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func WhenCloseButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func WhenDoneButtonWaspressed(_ sender: UIButton) {
        addFieldDelegateSurgery?.addFieldSelectionDelegate(otherSpace: OtherFieldTextField.text! , otherSpace1: OtherFieldTextField2.text! )
        
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

//
//  DiagnosisAddFieldViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 16/03/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

protocol DiagnosisAddField {
    func addFieldValue(textField1 : String , textField2 : String , textField3 : String , textField4 : String)
}

class DiagnosisAddFieldViewController: UIViewController {
    
    var diagnosisAddField : DiagnosisAddField!
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var textField3: UITextField!
    
    @IBOutlet weak var textField4: UITextField!
    var txtField1 = ""
    var txtField2 = ""
    var txtField3 = ""
    var txtField4 = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        textField1.text = txtField1
        textField2.text = txtField2
        textField3.text = txtField3
        textField4.text = txtField4
        
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButtonForKeyboard()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func WhenCloseButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func WhenDonButtonWasPressed(_ sender: UIButton) {
        diagnosisAddField.addFieldValue(textField1: textField1.text ?? "", textField2: textField2.text ?? "", textField3: textField3.text ?? "" , textField4: textField4.text ?? "")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func doneButtonForKeyboard(){
             let toolbar = UIToolbar()
             toolbar.sizeToFit()
             
             let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
             
             let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
             
             
             toolbar.setItems([flexibleSpace,doneButton], animated: false)
             
           textField1.inputAccessoryView = toolbar
           textField2.inputAccessoryView = toolbar
           textField3.inputAccessoryView = toolbar
           textField4.inputAccessoryView = toolbar
             
            }
         
         @objc func doneClicked(){
             view.endEditing(true)
         }
    
    
}

//
//  SearchACaseBySurgeryViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 05/02/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit
import DropDown

@available(iOS 13.0, *)
class SearchACaseBySurgeryViewController: UIViewController {
    
    
   
    var patientSearchModelList: [PatientSearchModel]?
    @IBOutlet weak var surgeryTypeLabelView: UIView!
    let uiPicvkerView = UIPickerView()
    var dataList = [ "Virectomy" , "Scleral Buckle" ,"Membrane peel", "ILM peel", "Retinectomy" , "Fluid-Air-Exchange" , "PFO" ,"Focal Endolaser", "PRP Laser" , "Indirect Laser Tear/Lattice" , "IOL Exchange" , "IOL Insertion" , "ACIOL" ,"Sulcus IOL" , "Scleral Fixated IOL Sutured" , "Scleral Fixated IOL Sutueless" , "PPL with Frag" , "PPL without Frag" , "Silicone Oil Removal" , "Silicone Oil Exchange" , "Choroidal Drainage" , "IOL Reposition" , "Cryotherapy"]
    
    
    var selectedItem = ""
    
    let dropDown = DropDown()
    
    @IBOutlet weak var surgeryTypeLabel: UILabel!
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        //surgeryTypeLabel.text = "Membrane peel"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        
       let gestureSurgeryType = UITapGestureRecognizer(target: self , action: #selector(self.WhenSurgeryTypeViewWasPressed))
          self.surgeryTypeLabelView.addGestureRecognizer(gestureSurgeryType)

        surgeryTypeLabelView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        surgeryTypeLabelView.layer.borderWidth = 3.0
    }
    
    @objc func WhenSurgeryTypeViewWasPressed() {

        print("view clicked")
        dropDown.anchorView = surgeryTypeLabelView
               dropDown.dataSource = dataList

        dropDown.show()

               // Action triggered on selection
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.surgeryTypeLabel.text = item
                self.selectedItem = item

               }
    }
    
    
    
    
    @IBAction func WhenSearchButtonWasPressed(_ sender: UIButton) {
        
        var value = selectedItem
        switch (value) {
       
        case "Virectomy" : value = "virectomy"
            break
        case "Scleral Buckle" : value = "scleralBuckle"
            break
        case "Membrane peel":  value = "membranePeel"
            break
        case "ILM peel" :   value = "ilmPeel"
            break
        case "Retinectomy" : value = "retinectomy"
            break
        case "Fluid-Air-Exchange" :  value = "fluidAirExchange"
            break
        case "PFO" :   value = "pfo"
            break
        case "Focal Endolaser" : value = "focalEndolaser"
            break
        case "PRP Laser" :  value = "prpLaser"
            break
        case "Indirect Laser Tear/Lattice" : value = "indirectLaserTear"
            break
        case "IOL Exchange" :   value = "iolExchange"
            break
        case "IOL Insertion" : value = "iolInsertion"
            break 
        case "ACIOL" :  value = "aciol"
            break
        case "Sulcus IOL" : value = "sulcusIol"
            break
        case "Scleral Fixated IOL Sutured" :  value = "sutured"
            break
        case "Scleral Fixated IOL Sutueless" : value = "sutureless"
            break
        case "PPL with Frag" : value = "pplWithFrag"
            break
        case "PPL without Frag" : value = "pplWithoutFrag"
            break
        case "Silicone Oil Removal" : value = "siliconeOilRemoval"
            break
        case "Silicone Oil Exchange" : value = "siliconeOilExchange"
            break
       case "Choroidal Drainage" : value = "corodialDrainage"
            break
            
       case "IOL Reposition" : value = "iolReposition"
            break
       case "Cryotherapy" : value = "cryotherapy"
            break
       
        default:
                value = "Select Surgery"
            
        }
        
        if  value == "Select Surgery" {
            print("Please Select the surgery")
            displayAlertMessage(messageToDisplay: "Please Select the surgery")
            return
        }
        else
        {
      
        do {
            patientSearchModelList = try! DatabaseManager.shared.loadPatientSearchDetailsByType(withID: value , surgeryStatus: "Yes")
            
      
            print("patientcount" , patientSearchModelList?.count)
            
        }
        catch {
             print(error.localizedDescription)
        }
                    if patientSearchModelList == nil {
                               print("No Data Found")
                        displayAlertMessage(messageToDisplay: "No Data Found")
                        
                        
                               
                           }
                           else{
              performSegue(withIdentifier: "seachByTypeToCases", sender: self)
        }
            
        }
        
    }
    
    @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "seachByTypeToCases" {
              
               let vc = segue.destination as! PatientSearchDetailsViewController
               vc.patientSearchModelList1 = patientSearchModelList
            vc.selectedSurgery = selectedItem
            vc.surgeryStatus = "Yes"
            vc.viewControlerId = 3
            vc.headingTittle = "Patient List(Surgery)"
            
               
           }
       }
    
    func displayAlertMessage(messageToDisplay : String)
          {
              let alertController = UIAlertController(title: "Alert",
                                                      message: messageToDisplay, preferredStyle: .alert)
              
              let OKAction = UIAlertAction(title : "Ok", style : .default){
                  (action :UIAlertAction) in
               
                 
              }
             alertController.addAction(OKAction)
              self.present(alertController, animated: true,completion: nil)
              
              
          }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                       vc.modalPresentationStyle = .fullScreen
                       self.present(vc, animated: true)
            }
    
    
    
}

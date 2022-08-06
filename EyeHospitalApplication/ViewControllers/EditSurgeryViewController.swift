//
//  Surgery_ViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
//import DropDown
 @available(iOS 13.0, *)
class EditSurgeryViewController: UIViewController , UITextFieldDelegate {
    
    // MARK:- Properties
     
      var valuesurg = 0 // unique id for the fetched in the database
      var activeField: UITextField?
      var getSurgeryList : [String] = []
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1520)
      
       //--------------------------
       // Accesiblity Identifier   AccesiblityIdentifier
       var vitrectomyAccesiblityIdentifier = "vitrectomy"
       var gaugeAccesiblityIdentifier = "gauge"
       var scleralBuckleAccesiblityIdentifier  = "scleralBuckle"
       var bandAccesiblityIdentifier = "band"
       var sleeveAccesiblityIdentifier = "sleeve"
       var tamponade1AccesiblityIdentifier = "tamponade1"
       var srfDrainAccesiblityIdentifier = "srfDrain"
       var acTapAccesiblityIdentifier = "acTap"
      var radialElementAccesiblityIdentifier = "radialElement"
       var membranePeelAccesiblityIdentifier = "membranePeel"
       var ilmPeelAccesiblityIdentifier = "ilmPeel"
       var retinectomyAccesiblityIdentifier = "retinectomy"
       var fluidAidrExchangeAccesiblityIdentifier =  "fluidAidrExchange"
       var siliconeOilRemovalAccesiblityIdentifier  =  "siliconeOilRemoval"
       var siliconeOilExchangeAccesiblityIdentifier = "siliconeOilExchange"
       var choroidalDrainageAccesiblityIdentifier  = "choroidalDrainage"
       var pfoAccesiblityIdentifier = "pfo"
       var focalEndolaserAccesiblityIdentifier = "focalEndolaser"
       var prpLaserAccesiblityIdentifier = "prpLaser"
       var indirectLaserTearAccesiblityIdentifier = "indirectLaserTear"
       var iolExchangeAccesiblityIdentifier = "iOLExchange"
       var iolInsertionAccesiblityIdentifier = "iolInsertion"
       var aciolAccesiblityIdentifier = "aciol"
       var sulcusIolAccesiblityIdentifier = "sulcusIol"
       var suturedAccesiblityIdentifier = "sutured"
       var suturelessAccesiblityIdentifier = "sutureless"
       var pplWithFragAccesiblityIdentifier = "pplWithFrag"
       var pplWithoutFragAccesiblityIdentifier = "pplWithoutFrag"
       var tamponade2AccesiblityIdentifier = "Tamponade2"
       var iolRepositionAccesiblityIdentifier = "iolReposition"
       var cryotherapyAccesiblityIdentifier = "cryotherapy"
    var ilmCodeAccesiblityIdentifier = "ilmCode"
    var pplAccesiblityIdentifier = "ppl"
        
        
       // CPT Codes
         var dataList = [ "Select CPT Code" , "67036 - PPV" , "67039 - PPV with focal laser" , "67040 - PPV with PRP laser" , "67041 - PPV for ERM" , "67042 - PPV with ILM peel (MH)"  , "67043 - PPV with subretinal membrane removal" , "67107 - Scleral buckle for RRD" , "67108 - PPV with or without SB for RRD" , "67110 - Pneumatic retinopexy" , "67113 - Complex RD repair" , "67121 - Removal of implanted material" ,"67141 - Cryo tear" , "67145 - Laser tear or lattice" , "66825 - IOL reposition" , "66850 - Removal of lens material" , "66985 - Insert secondary IOL" , "66986 - IOL exchange" , "65236 - Remove IOFB from AC" , "65260 - Remove IOFB from vitreous with magnet" , "65265 - Remove IOFB from vitreous without magnet"]
    
    // dropdown for CPT Code
      //  let dropDown = DropDown()
       
       
       func inputSurgeryContainerView(labelName: String , segmentedControl : UISegmentedControl , items : [String]) -> UIView {
           let view = UIView()
                var width:CGFloat? = nil
                
                let label = UILabel()
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 16)
               // label.backgroundColor = .red
                
                label.numberOfLines = 2
                label.text = labelName
                view.addSubview(label)
                
                var segControl = UISegmentedControl(items: items)
                segControl = segmentedControl
//                segControl.tintColor = .link
                segControl.selectedSegmentTintColor = .link
                segControl.selectedSegmentIndex = 0
               // segControl.backgroundColor = .link
                segControl.addTarget(self, action: #selector(handleSegmentedControl(sender:) ), for: .valueChanged)
              //  label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 160 , height: 30)
                view.addSubview(segControl)
               
               segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
                       segControl.centerY(inView: view)
             if items.count == 2  {
                 width = 81
                label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 230 , height: 30)
                segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
                segControl.centerY(inView: view)
             }
             else if items.count == 3 {
               width = 145
               label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 100 , height: 30)
               segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
               segControl.centerY(inView: view)
             }
           else if items.count == 4 {
                          width = 180
                  label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 100 , height: 30)
                  segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
                  segControl.centerY(inView: view)
                             }
                          else if items.count == 5 {
                           width = 160
                         
                      }
                          else if items.count == 6{
                          width = 260
               label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 90 , height: 30)
               segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
               segControl.centerY(inView: view)
                     }
                      
       
             return view
        }
      
         
         // scroll Vies
         lazy var scrollView : UIScrollView = {
             let view = UIScrollView(frame: .zero)
             view.backgroundColor = .white
             view.frame = self.view.bounds
             view.contentSize = contentViewSize
             view.autoresizingMask = .flexibleHeight
             view.showsVerticalScrollIndicator = true
             view.bounces = true
             return view
            
         }()
         // container View -- Scroll View contains Container View
         lazy var containerView : UIView = {
             let view = UIView()
             view.backgroundColor = UIColor(white: 1, alpha: 1)
             view.frame.size = contentViewSize
             return view
         }()
         
         
         // Back Button
         lazy var backButton: UIButton = {
                   let button = UIButton(type: .system)
                   button.setImage(#imageLiteral(resourceName: "Capture").withRenderingMode(.alwaysOriginal), for: .normal)
                  // button.addTarget(self, action: #selector(handleBackTapped()), for: .touchUpInside)
                   return button
               }()
         
         // Title Label
         let titleLabel : UILabel = {
             let label = UILabel()
             label.text = "Surgery"
             label.textColor = UIColor.rgb(red: 0, green: 100, blue: 0)
             label.font = UIFont.boldSystemFont(ofSize: 18.0)
             
             return label
         }()
         
         
         // Home Button
            let homeButton: UIButton = {
                      let button = UIButton(type: .system)
                      button.setImage(#imageLiteral(resourceName: "home3").withRenderingMode(.alwaysOriginal), for: .normal)
               //       button.addTarget(self, action: #selector(handleHomeTapped), for: .touchUpInside)
                      return button
                  }()
    
       // Done Button
       private let doneButton : UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Done", for: .normal)
           button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
           button.backgroundColor = .link
           button.layer.cornerRadius = 5
           button.heightAnchor.constraint(equalToConstant: 40).isActive = true // height
        
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true // height
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) // font
          // button.addTarget(self, action: #selector(), for: .touchUpInside)
           return button
          
       }()
       
       // Next Button
          private let nextButton : UIButton = {
                 let button = UIButton(type: .system)
                 button.setTitle("Next", for: .normal)
                 button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
                 button.backgroundColor = .link
                 button.layer.cornerRadius = 5
                 button.heightAnchor.constraint(equalToConstant: 40).isActive = true // height
              
                 button.widthAnchor.constraint(equalToConstant: 100).isActive = true // width
              
                 button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) // font
                // button.addTarget(self, action: #selector(), for: .touchUpInside)
                 return button
                
             }()
       
       // Add Field Button
       let addFieldButton: UIButton = {
                 let button = UIButton(type: .system)
                 button.setTitle("Add(+)", for: .normal)
                 
          //       button.addTarget(self, action: #selector(handleHomeTapped), for: .touchUpInside)
                 return button
             }()
       
       
       
       // Textfeld gauge, band , Sleeve
       //--------------------------------------------
       
     //  @IBOutlet weak var scrollView: UIScrollView!
       
       
       var textFieldGauge: UITextField = {
           let tf = UITextField()
           tf.borderStyle = .roundedRect
           tf.font = UIFont.systemFont(ofSize: 16.0)
           tf.keyboardType = .numberPad
           return tf
       }()
       
        var textFieldBand: UITextField = {
            let tf = UITextField()
            tf.borderStyle = .roundedRect
            tf.font = UIFont.systemFont(ofSize: 16.0)
            tf.keyboardType = .numberPad
            return tf
       }()

        var textFieldSleeve: UITextField = {
        let tf = UITextField()
            tf.borderStyle = .roundedRect
            tf.font = UIFont.systemFont(ofSize: 16.0)
            tf.keyboardType = .numberPad
            return tf
      }()
       //--------------------------------------------
       
       var percentageValueTextField: UITextField = {
       let tf = UITextField()
       tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
       return tf
       }()
       
       var percentageValueLabel: UILabel = {
                  let label = UILabel()
                  label.text = "%"
                  label.textColor = .black
                  label.font = UIFont.systemFont(ofSize: 16.0)
                  
                  return label
       }()
       
        var otherFieldLabel: UILabel = {
                let label = UILabel()
                label.text = ""
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 16.0)
                
                return label
       }()
       
        var otherField2: UILabel = { // label
               let label = UILabel()
               label.text = ""
               label.textColor = .black
               label.font = UIFont.systemFont(ofSize: 16.0)
               
               return label
         }()
       
       var scleralFixatedIOLLabel: UILabel = { // label
             let label = UILabel()
             label.text = "Scleral Fixated IOL"
             label.textColor = .black
             label.font = UIFont.systemFont(ofSize: 16.0)
             
             return label
       }()
       
//       var pplLabel: UILabel = { // label
//                let label = UILabel()
//                label.text = "PPL"
//                label.textColor = .black
//                label.font = UIFont.systemFont(ofSize: 16.0)
//                
//                return label
//          }()
//       
       var iolName: UILabel = { // label
                let label = UILabel()
                label.text = "IOL Name"
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 16.0)
                
                return label
          }()
       
       var iolPowers: UILabel = { // label
                   let label = UILabel()
                   label.text = "IOL Power"
                   label.textColor = .black
                   label.font = UIFont.systemFont(ofSize: 16.0)
                   
                   return label
             }()
       
       var positioning: UILabel = { // label
                     let label = UILabel()
                     label.text = "Positioning"
                     label.textColor = .black
                     label.font = UIFont.systemFont(ofSize: 16.0)
                     
                     return label
               }()
    
    var cptCodeLabel: UILabel = { // label
          let label = UILabel()
          label.text = "CPT Code"
          label.textColor = .black
          label.font = UIFont.systemFont(ofSize: 16.0)
          
          return label
    }()
    
   var cptCodeTextField: UITextView = {
          let tv = UITextView()
         
          tv.text = "Select CPT Code"
          tv.backgroundColor = .lightGray
          tv.font = UIFont.systemFont(ofSize: 16.0)
          //tv.isScrollEnabled = true
          
          return tv
      }()
    
    var cptCodeOtherTextField: UITextField = {
    let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "CPT Free Field"
    return tf
    }()
    
    // ilm Code
//    var ilmCodeTextField: UITextField = {
//         let tf = UITextField()
//             tf.borderStyle = .roundedRect
//             tf.placeholder = "ILM Stain"
//             tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
//         return tf
//         }()
    
    // ilmCodeSegmentedControl
    lazy var ilmCodeSegmentedControl: UISegmentedControl = {
     
     let sc = UISegmentedControl(items: ["ICG" , "BBG" ,"Triamcinolone" ,"None"])
     sc.selectedSegmentIndex = 0
     sc.selectedSegmentTintColor = .link
     sc.accessibilityIdentifier = ilmCodeAccesiblityIdentifier
     sc.apportionsSegmentWidthsByContent = true
     return sc
    
     }()
       //-------------------------------------------
       
      // virectomy
      lazy var virectomySegmentedControl: UISegmentedControl = {
       
       let sc = UISegmentedControl(items: ["No" , "Yes"])
       sc.selectedSegmentIndex = 0
       sc.accessibilityIdentifier = vitrectomyAccesiblityIdentifier
       
       return sc
      
       }()
       
       lazy var virectomySegmentedView : UIView = {
              
              let view = inputSurgeryContainerView(labelName: "Vitrectomy", segmentedControl: virectomySegmentedControl, items: ["No" , "Yes"])
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
              return view
              
          }()
       
       
       // scleralBuckle
       lazy var scleralBuckleSegmentedControl: UISegmentedControl  = {
          
          let sc = UISegmentedControl(items: ["No" , "Yes"])
          sc.selectedSegmentIndex = 0
          sc.accessibilityIdentifier  = scleralBuckleAccesiblityIdentifier
          return sc
         
          }()
       
       lazy var scleralBuckleSegmentedView : UIView = {
                 
                  let view = inputSurgeryContainerView(labelName: "Scleral Buckle", segmentedControl: scleralBuckleSegmentedControl, items: ["No" , "Yes"])
                  view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                 return view
                 
             }()
       
       // iol Insertion
        lazy var iosInsertionSegmentedControl: UISegmentedControl  = {
              
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
              sc.accessibilityIdentifier = iolInsertionAccesiblityIdentifier
              return sc
             
              }()
       
       lazy var iosInsertionSegmentedView : UIView = {
                    
                   let view = inputSurgeryContainerView(labelName: "IOL Insertion", segmentedControl: iosInsertionSegmentedControl, items: ["No" , "Yes"])
                     view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    return view
                    
                }()
       
          var iolNameTextField: UITextField = {
          let tf = UITextField()
          tf.borderStyle = .roundedRect
          return tf
          }()
       
          var iolPowersTextField: UITextField  = {
          let tf = UITextField()
           tf.borderStyle = .roundedRect
             return tf
             }()
          
       
          var positioningTextField: UITextField = {
          let tf = UITextField()
               tf.borderStyle = .roundedRect
          return tf
          }()
       
     
     
//
       
       // indirect Laser Tear
        lazy var indirectLaserTearSegmentedControl: UISegmentedControl  = {
              
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
              sc.accessibilityIdentifier = indirectLaserTearAccesiblityIdentifier
              return sc
             
              }()
       
       lazy var indirectLaserTearSegmentedView : UIView = {
                    
               let view = inputSurgeryContainerView(labelName: "Indirect laser Tear/Lattice", segmentedControl: indirectLaserTearSegmentedControl, items: ["No" , "Yes"])
                     view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    return view
                    
                }()
       
       
      
       // prp Laser
        lazy var prpLaserSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = prpLaserAccesiblityIdentifier
             return sc
            
             }()
       lazy var prpLaserSegmentedView : UIView = {
                       
               let view = inputSurgeryContainerView(labelName: "PRP Laser", segmentedControl: prpLaserSegmentedControl, items: ["No" , "Yes"])
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
               return view
                       
                   }()
          
       
       // focal Endolaser
        lazy var focalEndolasorSegmentedControl: UISegmentedControl  = {
              
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
               sc.accessibilityIdentifier = focalEndolaserAccesiblityIdentifier
              return sc
             
              }()
       
       lazy var focalEndolasorSegmentedView : UIView = {
                          
                          let view = inputSurgeryContainerView(labelName: "Focal Endolaser", segmentedControl: focalEndolasorSegmentedControl, items: ["No" , "Yes"])
                           view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                          return view
                          
                      }()
       
       // PFO
       lazy var pfoSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = pfoAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var pfoSegmentedView : UIView = {
           
           let view = inputSurgeryContainerView(labelName: "PFO", segmentedControl: pfoSegmentedControl, items: ["No" , "Yes"])
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
           
       }()
       
       // Fluid Air Exchange
        lazy var fluidAirExchangeSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = fluidAidrExchangeAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var fluidAirExchangeSegmentedView : UIView = {
              
              let view = inputSurgeryContainerView(labelName: "Fluid Air Exchange", segmentedControl: fluidAirExchangeSegmentedControl, items: ["No" , "Yes"])
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
              return view
              
          }()
       
       // Retinectomy
        lazy var retinectomySegmentControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = retinectomyAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var retinectomySegmentedView : UIView = {
                
                let view = inputSurgeryContainerView(labelName: "Retinectomy", segmentedControl: retinectomySegmentControl, items: ["No" , "Yes"])
                 view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                return view
                
            }()
       
       
       // ilmPeel
       lazy var ilmPeelSegmentControl: UISegmentedControl  = {
              
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier =  ilmPeelAccesiblityIdentifier
              return sc
             
              }()
       
       lazy var ilmPeelSegmentedView : UIView = {
                   
                   let view = inputSurgeryContainerView(labelName: "ILM Peel", segmentedControl: ilmPeelSegmentControl, items: ["No" , "Yes"])
                    view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                   return view
                   
               }()
       
       // membrane Peel
        lazy var membranePeelSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = membranePeelAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var membranePeelSegmentedView : UIView = {
           
           let view = inputSurgeryContainerView(labelName: "Membrane Peel", segmentedControl: membranePeelSegmentedControl, items: ["No" , "Yes"])
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
           
       }()
       
       
     //  var activeField: UITextField?
       // To check whether the text field is active or not
       var commentTexfield: UITextView = {
           let commentTf = UITextView()
           commentTf.text = ""
          
           return commentTf
           
        }()
       // Tamponade (second one)
       lazy var tamponadeSegmentControl: UISegmentedControl  = {
                
           let sc = UISegmentedControl(items: ["None" , "Air" , "SF6" , "C3F8" , "PFO" , "SO1000" , "SO5000"])
           sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = tamponade2AccesiblityIdentifier
           sc.selectedSegmentTintColor = .link
        
        let font = UIFont.systemFont(ofSize: 10)
               sc.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
               
                return sc
               
                }()
       
//       lazy var tamponadeSegmentedView : UIView = {
//
//           let view = inputSurgeryContainerView(labelName: "Tamponade", segmentedControl: tamponadeSegmentControl, items: ["None" , "Air" , "SF6" , "C3F8" , "PFO" , "SO"])
//            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//           return view
//
//       }()
       
       //  PPL with Frag
        lazy var withFragSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = pplWithFragAccesiblityIdentifier
           
             return sc
            
             }()
       // PPL without Frag
       lazy var withFragSegmentedView : UIView = {
           
           let view = inputSurgeryContainerView(labelName: "With Frag", segmentedControl: withFragSegmentedControl, items: ["No" , "Yes"])
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
           
       }()
       
       // Sutureless
        lazy var suturelessSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = suturelessAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var suturelessSegmentedView : UIView = {
              
              let view = inputSurgeryContainerView(labelName: "Sutureless Scleral Fixated IOL", segmentedControl: suturelessSegmentedControl, items: ["No" , "Yes"])
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
              return view
              
          }()
       
       // Sutured
       lazy var suturedSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = suturedAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var suturedSegmentedView : UIView = {
                 
                 let view = inputSurgeryContainerView(labelName: "Sutured Scleral Fixated IOL", segmentedControl: suturedSegmentedControl, items: ["No" , "Yes"])
                  view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                 return view
                 
             }()
    
       
       // selcus IOL
         lazy var selcusIOLSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier =  sulcusIolAccesiblityIdentifier
             return sc
            
             }()
       
       
       lazy var selcusIOLSegmentedView : UIView = {
                    
                    let view = inputSurgeryContainerView(labelName: "Sulcus IOL", segmentedControl: selcusIOLSegmentedControl, items: ["No" , "Yes"])
                     view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    return view
                    
                }()
       
        // Aciol
        lazy var aciolSegmentedControl: UISegmentedControl  = {
               
               let sc = UISegmentedControl(items: ["No" , "Yes"])
               sc.selectedSegmentIndex = 0
               sc.accessibilityIdentifier = aciolAccesiblityIdentifier
               return sc
              
               }()
       
       lazy var aciolSegmentedView : UIView = {
                       
                       let view = inputSurgeryContainerView(labelName: "ACIOL", segmentedControl: aciolSegmentedControl, items: ["No" , "Yes"])
                        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                       return view
                       
                   }()
         
       // without Frag
        lazy var withOutFragSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = pplWithoutFragAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var withOutFragSegmentedView : UIView = {
                          
                          let view = inputSurgeryContainerView(labelName: "Without Frag",segmentedControl: withOutFragSegmentedControl, items: ["No" , "Yes"])
                           view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                          return view
                          
                      }()
       // IOL exchange
        lazy var iolExchangeSegmentedControl: UISegmentedControl  = {
              
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = iolExchangeAccesiblityIdentifier
           return sc
             
              }()
       
       lazy var iolExchangeSegmentedView : UIView = {
                             
                             let view = inputSurgeryContainerView(labelName: "IOL Exchange", segmentedControl: iolExchangeSegmentedControl, items: ["No" , "Yes"])
                              view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                             return view
                             
                         }()
       
       
       
       // acTap
        lazy var acTapSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = acTapAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var acTapSegmentedView : UIView = {
           
           let view = inputSurgeryContainerView(labelName: "AC tap ", segmentedControl: acTapSegmentedControl, items: ["No" , "Yes"])
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
           
       }()
    
    // Radial Elemt Segmented Control
           lazy var radialElementSegmentedControl: UISegmentedControl  = {
                
                let sc = UISegmentedControl(items: ["No" , "Yes"])
                sc.selectedSegmentIndex = 0
              sc.accessibilityIdentifier = radialElementAccesiblityIdentifier
                return sc
               
                }()
       
       
       // Radial Element
       lazy var radialElementSegmentedView : UIView = {
             
             let view = inputSurgeryContainerView(labelName: "Radial Element", segmentedControl: radialElementSegmentedControl, items: ["No" , "Yes"])
              view.heightAnchor.constraint(equalToConstant: 40).isActive = true
             return view
             
         }()
         
       
       // srf Drain
       lazy var srfDrainSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["No" , "Yes"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = srfDrainAccesiblityIdentifier
             return sc
            
             }()
       
       lazy var srfDrainSegmentedView : UIView = {
              
              let view = inputSurgeryContainerView(labelName: "SRF drain?", segmentedControl: srfDrainSegmentedControl, items: ["No" , "Yes"])
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
              return view
              
          }()
       
       // tamponade (first one)
//        lazy var tamponadeSegmentedControl: UISegmentedControl  = {
//
//                let sc = UISegmentedControl(items: ["Air" , "C3F8" , "SF6" , "None"])
//                sc.selectedSegmentIndex = 0
//           sc.accessibilityIdentifier = tamponade1AccesiblityIdentifier
//                return sc
//
//                }()
//       // tamponade (first one)
//       lazy var tamponade1SegmentedView : UIView = {
//
//                 let view = inputSurgeryContainerView(labelName: "Tamponade", segmentedControl: tamponadeSegmentedControl, items: ["Air" , "C3F8" , "SF6" , "None"])
//                  view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//                 return view
//
//             }()
       
      
       
       
       // band Label
    var bandLabel: UILabel = {
             let label = UILabel()
             label.text = "Band"
             label.textColor = .black
             label.font = UIFont.systemFont(ofSize: 16.0)
             
             return label
    }()
       // sleeve Label
    var sleeveLabel: UILabel = {
                let label = UILabel()
                label.text = "Sleeve"
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 16.0)
                
                return label
       }()
        // gauge Label
    var gaugeLabel: UILabel = {
                    let label = UILabel()
                    label.text = "Gauge"
                    label.textColor = .black
                    label.font = UIFont.systemFont(ofSize: 16.0)
                    
                    return label
           }()
  
    
       
       
       // Silicone Oil Removal
       
        lazy var siliconeOilRemovalSegmentedControl: UISegmentedControl  = {
                
                let sc = UISegmentedControl(items: ["No" , "Yes"])
                sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = siliconeOilRemovalAccesiblityIdentifier
                return sc
               
                }()
       
       lazy var siliconeOilRemovalSegmentedView : UIView = {
                          
                          let view = inputSurgeryContainerView(labelName: "Silicone Oil Removal", segmentedControl: siliconeOilRemovalSegmentedControl, items:   ["No" , "Yes"])
                           view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                          return view
                          
                      }()
       // Silicone Oil Exchange
       lazy var siliconeOilExchangeSegmentedControl: UISegmentedControl  = {
                
                let sc = UISegmentedControl(items: ["No" , "Yes"])
                sc.selectedSegmentIndex = 0
                sc.accessibilityIdentifier  = siliconeOilExchangeAccesiblityIdentifier
                return sc
               
                }()
       
       lazy var siliconeOilExchangeSegmentedView : UIView = {
                             
                             let view = inputSurgeryContainerView(labelName: "Silicone Oil Exchange", segmentedControl: siliconeOilExchangeSegmentedControl, items:   ["No" , "Yes"])
                              view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                             return view
                             
                         }()
       
       // Choroidal Drainage
       lazy var corodialDamageSegmented: UISegmentedControl  = {
                 
                 let sc = UISegmentedControl(items: ["No" , "Yes"])
                 sc.selectedSegmentIndex = 0
                 sc.accessibilityIdentifier = choroidalDrainageAccesiblityIdentifier
                 return sc
                
                 }()
       
       lazy var corodialDamageSegmentedView : UIView = {
                                
                 let view = inputSurgeryContainerView(labelName: "Choroidal Drainage", segmentedControl: corodialDamageSegmented, items:   ["No","Yes"])
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                return view
                                
                            }()
    
    //cryotherapy
    lazy var cryotherapySegmentedControl: UISegmentedControl  = {
     
     let sc = UISegmentedControl(items: ["No" , "Yes"])
     sc.selectedSegmentIndex = 0
     sc.accessibilityIdentifier = cryotherapyAccesiblityIdentifier
     return sc
    
     }()
    
    lazy var cryotherapySegmentedView : UIView = {
                     
      let view = inputSurgeryContainerView(labelName: "Cryotherapy", segmentedControl: cryotherapySegmentedControl , items:   ["No","Yes"])
    view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                     return view
                     
                 }()
    
    // iolReposition
    lazy var iolRepositionSegmentedControl: UISegmentedControl  = {
     
     let sc = UISegmentedControl(items: ["No" , "Yes"])
     sc.selectedSegmentIndex = 0
     sc.accessibilityIdentifier = iolRepositionAccesiblityIdentifier
     return sc
    
     }()
    
    lazy var iolRepositionSegmentedView : UIView = {
                        
         let view = inputSurgeryContainerView(labelName: "IOL Reposition", segmentedControl: iolRepositionSegmentedControl, items:   ["No","Yes"])
       view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        return view
                        
                    }()
    
    // PPL
    lazy var pplSegmentedControl: UISegmentedControl  = {
     
     let sc = UISegmentedControl(items: ["No" , "Yes"])
     sc.selectedSegmentIndex = 0
     sc.accessibilityIdentifier = pplAccesiblityIdentifier
     return sc
    
     }()
    
    lazy var pplSegmentedView : UIView = {
                        
         let view = inputSurgeryContainerView(labelName: "PPL", segmentedControl:  pplSegmentedControl, items:   ["No","Yes"])
         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        return view
    }()
    
    var commentLabel: UILabel = { // label
                let label = UILabel()
                label.text = "Comment"
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 16.0)
                
                return label
          }()
       
       var tamponadeLabel: UILabel = { // label
                   let label = UILabel()
                   label.text = "Tamponade"
                   label.textColor = .black
                   label.font = UIFont.systemFont(ofSize: 16.0)
                   
                   return label
             }()
    
       
  
    
    
    // MARK:- Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
           
        getSurgeryList = DatabaseManager.shared.loadPatientSurgeryDetailsWhileEditing(Id: valuesurg)
        
        print ("getSurgeryList count is" , getSurgeryList.count)
         
        // gauge Textfield
        textFieldGauge.text = getSurgeryList[0]
        // band Textfield
        textFieldBand.text = getSurgeryList[1]
        // sleeve TextField
        textFieldSleeve.text = getSurgeryList[2]
        
        // tamponadeSegmentControl
        switch(getSurgeryList[3])
        {
        case "Air" :  tamponadeSegmentControl.selectedSegmentIndex = 0
            break
        case "C3F8" : tamponadeSegmentControl.selectedSegmentIndex = 1
            break
        case "SF6" :  tamponadeSegmentControl.selectedSegmentIndex = 2
            break
        case "None":  tamponadeSegmentControl.selectedSegmentIndex = 3
            break
       
        default: print("Not a valid choice -- it was disabled during entery")
            
        }
        // srfDrainSegmentedControl
        if getSurgeryList[4] == "Yes" {
            
            srfDrainSegmentedControl.selectedSegmentIndex = 1
            
        }
        else{
            srfDrainSegmentedControl.selectedSegmentIndex = 0
        }
        
        // for acTapSegmentedControl
        if getSurgeryList[5] == "Yes" {
                   
                   acTapSegmentedControl.selectedSegmentIndex = 1
                   
               }
               else{
                   acTapSegmentedControl.selectedSegmentIndex = 0
               }
        // membranePeelSegmentedControl
        if getSurgeryList[6] == "Yes" {
                          
                          membranePeelSegmentedControl.selectedSegmentIndex = 1
                          
                      }
                      else{
                          membranePeelSegmentedControl.selectedSegmentIndex = 0
                      }
        
        // ilmPeelSegmentControl
        if getSurgeryList[7] == "Yes" {
                                 
                           ilmPeelSegmentControl.selectedSegmentIndex = 1
                                 
                             }
                             else{
                           ilmPeelSegmentControl.selectedSegmentIndex = 0
                             }
        
        // retinectomySegmentControl
        if getSurgeryList[8] == "Yes" {
                                 
                                 retinectomySegmentControl.selectedSegmentIndex = 1
                                 
                             }
                             else{
                                 retinectomySegmentControl.selectedSegmentIndex = 0
                             }
        
        //fluidAirExchangeSegmentedControl
        if getSurgeryList[9] == "Yes" {
                                        
                                        fluidAirExchangeSegmentedControl.selectedSegmentIndex = 1
                                        
                                    }
                                    else{
                                        fluidAirExchangeSegmentedControl.selectedSegmentIndex = 0
                                    }
        // pfoSegmentedControl
        if getSurgeryList[10] == "Yes" {
                                        
                                        pfoSegmentedControl.selectedSegmentIndex = 1
                                        
                                    }
                                    else{
                                        pfoSegmentedControl.selectedSegmentIndex = 0
                                    }
        
        // focalEndolasorSegmentedControl
        if getSurgeryList[11] == "Yes" {
                                        
                                        focalEndolasorSegmentedControl.selectedSegmentIndex = 1
                                        
                                    }
                                    else{
                                        focalEndolasorSegmentedControl.selectedSegmentIndex = 0
                                    }
        // prpLaserSegmentedControl
        if getSurgeryList[12] == "Yes" {
                                              
                                              prpLaserSegmentedControl.selectedSegmentIndex = 1
                                              
                                          }
                                          else{
                                              prpLaserSegmentedControl.selectedSegmentIndex = 0
                                          }
        // indirectLaserTearSegmentedControl
        if getSurgeryList[13] == "Yes" {
                                                     
                                                     indirectLaserTearSegmentedControl.selectedSegmentIndex = 1
                                                     
                                                 }
                                                 else{
                                                     indirectLaserTearSegmentedControl.selectedSegmentIndex = 0
                                                 }
        // iolExchangeSegmentedControl
        if getSurgeryList[14] == "Yes" {
                                                     
                                                     iolExchangeSegmentedControl.selectedSegmentIndex = 1
                                                     
                                                 }
                                                 else{
            
                                                     iolExchangeSegmentedControl.selectedSegmentIndex = 0
                                                 }
        
        // aciolSegmentedControl
        if getSurgeryList[15] == "Yes" {
                                                            
                                                            aciolSegmentedControl.selectedSegmentIndex = 1
                                                            
                                                        }
                                                        else{
                                                            aciolSegmentedControl.selectedSegmentIndex = 0
                                                        }
        
        // selcusIOLSegmentedControl
        if getSurgeryList[16] == "Yes" {
                                                                  
                                                                  selcusIOLSegmentedControl.selectedSegmentIndex = 1
                                                                  
                                                              }
                                                              else{
                                                                  selcusIOLSegmentedControl.selectedSegmentIndex = 0
                                                              }
        
        // suturedSegmentedControl
        if getSurgeryList[17] == "Yes" {
                                                                         
                                                                         suturedSegmentedControl.selectedSegmentIndex = 1
                                                                         
                                                                     }
                                                                     else{
                                                                         suturedSegmentedControl.selectedSegmentIndex = 0
                                                                     }
        
        // withFragSegmentedControl
        if getSurgeryList[19] == "Yes" || getSurgeryList[18] == "Optional(\"Yes\")" {
                                                                         print("getSurgeryList" + getSurgeryList[18])
                                                                         withFragSegmentedControl.selectedSegmentIndex = 1
                                                                         
                                                                     }
                                                                     else{
                                                                         print("getSurgeryList" + getSurgeryList[18])
                                                                         withFragSegmentedControl.selectedSegmentIndex = 0
                                                                     }
        
//        // withOutFragSegmentedControl
//        if getSurgeryList[19] == "Yes" {
//                                                                         
//                                                                         withOutFragSegmentedControl.selectedSegmentIndex = 1
//                                                                         
//                                                                     }
//                                                                     else{
//                                                                         withOutFragSegmentedControl.selectedSegmentIndex = 0
//                                                                     }
//        
        // suturelessSegmentedControl
        if getSurgeryList[20] == "Yes" {
                                                                                
                                                                                suturelessSegmentedControl.selectedSegmentIndex = 1
                                                                                
                                                                            }
                                                                            else{
                                                                                suturelessSegmentedControl.selectedSegmentIndex = 0
                                                                            }
    
       // This for first temponade control which was removed on 18 November 2020
        // tamponadeSegmentedControl
//        switch(getSurgeryList[21])
//        {
//        case "None" :  tamponadeSegmentedControl.selectedSegmentIndex = 0
//            break
//        case "Air"  :  tamponadeSegmentedControl.selectedSegmentIndex = 1
//            break
//        case "SF6"  :  tamponadeSegmentedControl.selectedSegmentIndex = 2
//            break
//        case "C3F8" :  tamponadeSegmentedControl.selectedSegmentIndex = 3
//            break
//        case "PFO"  :  tamponadeSegmentedControl.selectedSegmentIndex = 4
//            break
//        case "SO"   :  tamponadeSegmentedControl.selectedSegmentIndex = 5
//            break
//
//        default:
//            print("Not A valid option")
//        }
        
        commentTexfield.text! = getSurgeryList[22]
        percentageValueTextField.text! = getSurgeryList[23]
        otherFieldLabel.text! = getSurgeryList[24]
        otherField2.text! = getSurgeryList[25]
       
        
        // For Viectomy Segmented Control
        switch(getSurgeryList[26])
        {
        case "Yes" : virectomySegmentedControl.selectedSegmentIndex = 1
            break
        case "No" : virectomySegmentedControl.selectedSegmentIndex = 0
            break
        
            
        default : print("Not in the option Virectomy Segmented Control")
            
            
        }
        
        // For Scleral Buckle Segmented Control
        switch(getSurgeryList[27])
        {
        case "Yes" : scleralBuckleSegmentedControl.selectedSegmentIndex = 1
            break
        case "No" : scleralBuckleSegmentedControl.selectedSegmentIndex = 0
            break
        
            
        default : print("Not in the option Scleral Buckle Segmented Control")
            
            
        }
        
        
        // For   IOL Insertion Segmented  Control
        switch(getSurgeryList[28])
        {
        case "Yes" : iosInsertionSegmentedControl.selectedSegmentIndex = 1
            break
        case "No" : iosInsertionSegmentedControl.selectedSegmentIndex = 0
            break
        
            
        default : print("Not in the option")
            
            
        }
        
        
        iolNameTextField.text! = getSurgeryList[29]
        iolPowersTextField.text! = getSurgeryList[30]
        positioningTextField.text! = getSurgeryList[31]
        
        //
        switch getSurgeryList[32] {
            
            case "Yes" : siliconeOilRemovalSegmentedControl.selectedSegmentIndex = 1
                       break
                   case "No" : siliconeOilRemovalSegmentedControl.selectedSegmentIndex = 0
                       break
                   
                       
                   default : print("Not in the option")
            
        }
        
        //
        switch getSurgeryList[33] {
        
        case "Yes" : siliconeOilExchangeSegmentedControl.selectedSegmentIndex = 1
                   break
               case "No" : siliconeOilExchangeSegmentedControl.selectedSegmentIndex = 0
                   break
               
                   
               default : print("Not in the option")
        }
        
        switch getSurgeryList[34] {
        
        case "Yes" : corodialDamageSegmented.selectedSegmentIndex = 1
                   break
        case "No" : corodialDamageSegmented.selectedSegmentIndex = 0
                   break
               
                   
               default : print("Not in the option")
        }
        
        switch getSurgeryList[35] {
        
        case "Yes" : iolRepositionSegmentedControl.selectedSegmentIndex = 1
                   break
        case "No" : iolRepositionSegmentedControl.selectedSegmentIndex = 0
                   break
               
                   
               default : print("Not in the option")
        }
        
        cptCodeTextField.text! = getSurgeryList[36]
        
        cptCodeOtherTextField.text! = getSurgeryList[37]
        
        switch getSurgeryList[38] {
               
               case "Yes" : cryotherapySegmentedControl.selectedSegmentIndex = 1
                          break
               case "No" : cryotherapySegmentedControl.selectedSegmentIndex = 0
                          break
                      
                          
                      default : print("Not in the option")
               }
        
//        ilmCodeTextField.text = getSurgeryList[39]
        
        switch(getSurgeryList[39]){
        case "ICG":
            ilmCodeSegmentedControl.selectedSegmentIndex = 0;
            break;
        case "BBG" :
            ilmCodeSegmentedControl.selectedSegmentIndex = 1;
            break;
        case "Triamcinolone" :
            ilmCodeSegmentedControl.selectedSegmentIndex = 2;
            break;
        case "None" :
            ilmCodeSegmentedControl.selectedSegmentIndex = 3 ;
            break;
            
        default : print("Not in the option");
        }
        
        // Radial Element
        switch getSurgeryList[40] {
                      
                      case "Yes" : radialElementSegmentedControl.selectedSegmentIndex = 1
                                 break
                      case "No" : radialElementSegmentedControl.selectedSegmentIndex = 0
                                 break
                             
                                 
                             default : print("Not in the option")
                      }
        
        
        // PPL
        switch getSurgeryList[41] {
                      
                      case "Yes" : pplSegmentedControl.selectedSegmentIndex = 1
                                   withFragSegmentedControl.isEnabled = true
                                 break
                      case "No" : pplSegmentedControl.selectedSegmentIndex = 0
                                  withFragSegmentedControl.isEnabled = false
                                 break
                             
                                 
                             default : print("Not in the option")
                      }
        
       
//            print("uniqueidWhileEditingDaignosis" , valuesurg)
//               print("first elent removes during edit at EditDemographics2ViewController ")
       
        let virectomySeg1 =  virectomySegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex)
                   let scleralBuckleSeg1 = scleralBuckleSegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex)
                   
                   if virectomySeg1 == "Yes" {
                       textFieldGauge.isEnabled = true
                   }
                   else {
                        textFieldGauge.isEnabled = false
                   }
                   
                   if scleralBuckleSeg1 == "Yes" {
                       textFieldBand.isEnabled = true
                       textFieldSleeve.isEnabled = true
                   } else {
                       textFieldBand.isEnabled = false
                       textFieldSleeve.isEnabled = false
                   }
        
    }
       // View did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
            
        
        doneButtonForKeyboard()
        configureUI()
//         
          
    }
    
    // MARK:- Selectors
    
    @objc func handleVirectomySegMentedControll(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
                       textFieldGauge.isEnabled = true
                   }
                   else {
                        textFieldGauge.isEnabled = false
                        textFieldGauge.text = ""
                   }
        
    }
    
    
    
    
    
    @objc func handleScleralBuckleSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
                       textFieldBand.isEnabled = true
                       textFieldSleeve.isEnabled = true
                   } else {
                       textFieldBand.isEnabled = false
                       textFieldSleeve.isEnabled = false
                       textFieldBand.text = ""
                       textFieldSleeve.text = ""
                   }
        
    }
    
   
    
    @objc func handleDoneButtonPress() {
        
        var ilmDropDownString : String?
        print("value of id at surgery" , valuesurg)
         
         var bandText  = textFieldBand.text!
         var gaugeText  = textFieldGauge.text!
         var sleeveText  = textFieldGauge.text!
          
         let indirectLaserTearSeg = indirectLaserTearSegmentedControl.titleForSegment(at: indirectLaserTearSegmentedControl.selectedSegmentIndex)
         let prpLaserSeg = prpLaserSegmentedControl.titleForSegment(at: prpLaserSegmentedControl.selectedSegmentIndex)
         let focalEndolasorSeg = focalEndolasorSegmentedControl.titleForSegment(at: focalEndolasorSegmentedControl.selectedSegmentIndex)
         let pfoSeg = pfoSegmentedControl.titleForSegment(at: pfoSegmentedControl.selectedSegmentIndex)!
         let fluidAirExchangeSeg = fluidAirExchangeSegmentedControl.titleForSegment(at: fluidAirExchangeSegmentedControl.selectedSegmentIndex)!
         let retinectomySeg = retinectomySegmentControl.titleForSegment(at: retinectomySegmentControl.selectedSegmentIndex)!
         let ilmPeelSeg = ilmPeelSegmentControl.titleForSegment(at: ilmPeelSegmentControl.selectedSegmentIndex)!
         let membranePeelSeg = membranePeelSegmentedControl.titleForSegment(at: membranePeelSegmentedControl.selectedSegmentIndex)!
        
         let commentText = commentTexfield.text!
         let tamponadeSeg1 = "NA"
         let withFragSeg = withFragSegmentedControl.titleForSegment(at: withFragSegmentedControl.selectedSegmentIndex)
         let suturedSeg = suturedSegmentedControl.titleForSegment(at: suturedSegmentedControl.selectedSegmentIndex)
         let suturelessSeg = suturelessSegmentedControl.titleForSegment(at: suturelessSegmentedControl.selectedSegmentIndex)
         let sulcusIOLSeg = selcusIOLSegmentedControl.titleForSegment(at: selcusIOLSegmentedControl.selectedSegmentIndex)
         let aciolSeg = aciolSegmentedControl.titleForSegment(at: aciolSegmentedControl.selectedSegmentIndex)
         let iolExchangeSeg = aciolSegmentedControl.titleForSegment(at: aciolSegmentedControl.selectedSegmentIndex)
         let gaugeSeg = gaugeText
         let acTapSeg = acTapSegmentedControl.titleForSegment(at: acTapSegmentedControl.selectedSegmentIndex)
         let srfDrainSeg = srfDrainSegmentedControl.titleForSegment(at: srfDrainSegmentedControl.selectedSegmentIndex)
         let tamponadeSeg2 = tamponadeSegmentControl.titleForSegment(at: tamponadeSegmentControl.selectedSegmentIndex)
         let sleeveSeg = sleeveText
         let bandSegmented = bandText
         let withoutFragSeg = withOutFragSegmentedControl.titleForSegment(at: withOutFragSegmentedControl.selectedSegmentIndex)
         // To check gauge Textfield (textFieldGauge) is empty or not
        
        //--
        let percentageTampnadeString = percentageValueTextField.text!
        let otherField1String  = otherFieldLabel.text!
        let otherField2String = otherField2.text!
        let virectomySeg =  virectomySegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex)
        let scleralBuckleSeg = scleralBuckleSegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex)
        let iolInsertionSeg = iosInsertionSegmentedControl.titleForSegment(at: iosInsertionSegmentedControl.selectedSegmentIndex)
      
        let iolNameString = iolNameTextField.text!
        let IolPowerString  = iolPowersTextField.text!
        let positioningString  = positioningTextField.text!
        
        let siliconeOilRemovalString = siliconeOilRemovalSegmentedControl.titleForSegment(at: siliconeOilRemovalSegmentedControl.selectedSegmentIndex)
        let siliconeOilExchangeString = siliconeOilExchangeSegmentedControl.titleForSegment(at: siliconeOilExchangeSegmentedControl.selectedSegmentIndex )
        let corodialDrainageString = corodialDamageSegmented.titleForSegment(at: corodialDamageSegmented.selectedSegmentIndex )
        
        // updated in last 2 major version
               let iolRepositionString = iolRepositionSegmentedControl.titleForSegment(at:iolRepositionSegmentedControl.selectedSegmentIndex)
               
               let cryotherapyString = cryotherapySegmentedControl.titleForSegment(at:cryotherapySegmentedControl.selectedSegmentIndex)
               
               let cptCodeDropdownString = cptCodeTextField.text
               
               let cptFreeTextBoxString = cptCodeOtherTextField.text
        
        

        
        if ilmCodeSegmentedControl.isEnabled == true {
            ilmDropDownString = ilmCodeSegmentedControl.titleForSegment(at:ilmCodeSegmentedControl.selectedSegmentIndex)
        } else {
            ilmDropDownString = ""
        }
        
          
         let radialElementSeg = radialElementSegmentedControl.titleForSegment(at: radialElementSegmentedControl.selectedSegmentIndex)
        
        // For PPL
        let pplString : String?
        
        
        if pplSegmentedControl.isEnabled == true {
            pplString = pplSegmentedControl.titleForSegment(at: pplSegmentedControl.selectedSegmentIndex)
               } else {
                   pplString = ""
               }
        
        let withFragStr = pplString == "Yes" ? withFragSeg : "No"
        
        print("withFragStr" , withFragStr)
        
        
        
         
         
         // To insert data in SurgeryModel
        let surgeryModelInfo = SurgeryModel(personIdfromDemo1:valuesurg, gauge: gaugeText, band: bandText, sleeve: sleeveText, tamponad1: tamponadeSeg1, srfDrain: srfDrainSeg, acTap: acTapSeg, radialElement: radialElementSeg!  , membranePeel: membranePeelSeg, ilmPeel: ilmPeelSeg, retinectomy: retinectomySeg , fluidAirExchange: fluidAirExchangeSeg, pfo: pfoSeg, focalEndolaser: focalEndolasorSeg, prpLaser: prpLaserSeg, indirectLaserTear: indirectLaserTearSeg, iolExchange: iolExchangeSeg, aciol: aciolSeg, sulcusIol: sulcusIOLSeg, sutured: suturedSeg, sutureless: suturelessSeg,ppl: pplString, pplWithFrag: withFragStr, pplWithoutFrag: withoutFragSeg ,  tamponade1: tamponadeSeg2, percentageTamponade: percentageTampnadeString, otherFieldTamponade:otherField1String , otherField2: otherField2String, comments: commentText,virectomy: virectomySeg, scleralBuckle: scleralBuckleSeg , iolInsertion: iolInsertionSeg,iolName: iolNameString, iolPower: IolPowerString, positioning: positioningString, siliconeOilRemoval: siliconeOilRemovalString , siliconeOilExchange: siliconeOilExchangeString ,corodialDrainage: corodialDrainageString, iolReposition : iolRepositionString, cptCodeDropdown: cptCodeDropdownString, cptFreeTextBox: cptFreeTextBoxString, cryotherapy: cryotherapyString, ilmDropDown: ilmDropDownString, status: 1)
         
         // To create table in database
        
          // To insert the values in Surgery table in database
         let inserted = DatabaseManager.shared.UpdateSurgeryDataAfterEding(surgeryModel: surgeryModelInfo, id: valuesurg)
         print(inserted)
        
        
        dismiss(animated: true, completion: nil)
        
//         self.present(vc, animated: true, completion: nil)
         
         
    }
    
    
    @objc func handleSegmentedControl(sender : UISegmentedControl )   {
            let index = sender.selectedSegmentIndex
            print(index)
           switch sender.accessibilityIdentifier {
           case   vitrectomyAccesiblityIdentifier:
                  virectomySegmentedControl.titleForSegment(at: index)
                  handleVirectomySegMentedControll(virectomySegmentedControl)
                  
                  print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case  gaugeAccesiblityIdentifier:
                  
               //   GaugeSegmentedControl.titleForSegment(at: index)
                  print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case scleralBuckleAccesiblityIdentifier :
               scleralBuckleSegmentedControl.titleForSegment(at: index)
               handleScleralBuckleSegmentedControl(scleralBuckleSegmentedControl)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case bandAccesiblityIdentifier :
              //  bandSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case sleeveAccesiblityIdentifier :
             //  SleeveSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
//           case tamponade1AccesiblityIdentifier :
//                tamponadeSegmentedControl.titleForSegment(at: index)
//               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
//               break
           case srfDrainAccesiblityIdentifier :
               srfDrainSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case acTapAccesiblityIdentifier :
               acTapSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
            
            case radialElementAccesiblityIdentifier :
            radialElementSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
           case membranePeelAccesiblityIdentifier :
               membranePeelSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case ilmPeelAccesiblityIdentifier :
               ilmPeelSegmentControl.titleForSegment(at: index)
               
               handleIlmPeelSegmentedControllPress()
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case retinectomyAccesiblityIdentifier :
               retinectomySegmentControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case fluidAidrExchangeAccesiblityIdentifier :
               fluidAirExchangeSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case siliconeOilRemovalAccesiblityIdentifier :
                siliconeOilRemovalSegmentedControl.titleForSegment(at: index)
                print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
                break
           case siliconeOilExchangeAccesiblityIdentifier :
               siliconeOilExchangeSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case choroidalDrainageAccesiblityIdentifier :
               corodialDamageSegmented.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case pfoAccesiblityIdentifier :
               pfoSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case focalEndolaserAccesiblityIdentifier :
               focalEndolasorSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case prpLaserAccesiblityIdentifier :
               prpLaserSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case indirectLaserTearAccesiblityIdentifier :
                indirectLaserTearSegmentedControl.titleForSegment(at: index)
              print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case iolExchangeAccesiblityIdentifier :
               iolExchangeSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case iolInsertionAccesiblityIdentifier :
               iolExchangeSegmentedControl.titleForSegment(at: index)
              
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case aciolAccesiblityIdentifier :
               aciolSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case sulcusIolAccesiblityIdentifier :
               selcusIOLSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case suturedAccesiblityIdentifier :
               suturedSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case suturelessAccesiblityIdentifier :
               suturelessSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case pplWithFragAccesiblityIdentifier :
               withFragSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case pplWithoutFragAccesiblityIdentifier :
               withOutFragSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case tamponade2AccesiblityIdentifier :
                tamponadeSegmentControl.titleForSegment(at: index)
                
              print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
            
           case iolRepositionAccesiblityIdentifier :
                       iolRepositionSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
                       break
           case cryotherapyAccesiblityIdentifier :
                       cryotherapySegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
                       break
               
           case ilmCodeAccesiblityIdentifier :
               ilmCodeSegmentedControl.titleForSegment(at: index)
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
           case pplAccesiblityIdentifier :
               pplSegmentedControl.titleForSegment(at: index)
               handlePplSegmentedControl()
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
               break
            
           default:  print("Not an Option")
               
           }
       }
   
    // done for keyboard (Object C function )
       @objc func doneClicked(){
           view.endEditing(true)
    
    }
    
    // objc function for when ppl clicked
    @objc func handlePplSegmentedControl(){
        print("ppl pressed")
        
        if  pplSegmentedControl.titleForSegment(at: pplSegmentedControl.selectedSegmentIndex) == "Yes" {
            withFragSegmentedControl.isEnabled = true
           
                   
                   
               }
               else {
                   withFragSegmentedControl.isEnabled = false
             
               }
        
        
    }

    @objc func handleaddTemponadeField() {
        
        let vc = storyboard?.instantiateViewController(identifier: "AddFieldSurgeryViewController") as! AddFieldSurgeryViewController
        vc.modalPresentationStyle = .fullScreen
        vc.addFieldDelegateSurgery = self
        vc.txtField1 = otherFieldLabel.text!
        vc.txtField2 = otherField2.text!
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
               
        
        
    }
    @IBAction func WhenBackButtonPressed(_ sender: UIButton) {
        let deleted = DatabaseManager.shared.deleteDiagnosisTempDataWhenBactPressedAtSurgery(withID: valuesurg)
            print("deleted is " , deleted)
            dismiss(animated: true, completion: nil)
       
    }
    
    @objc func  handleCptCodePressed(){
           
          DispatchQueue.main.async {
                    
                    let vc = CPTSelectionViewController()
                    vc.modalPresentationStyle = .automatic
                    vc.cptCodesEditDelegate = self
                    vc.codeType = 1
                    self.present(vc, animated: true, completion: nil)
                }
              
       }
    
    @objc func  handleIlmCodePressed(){
              
              DispatchQueue.main.async {
                  
                  
                  let vc = CPTSelectionViewController()
                  vc.modalPresentationStyle = .automatic
                  vc.ilmCodesEditDelegate = self
                   vc.codeType = 0
                  self.present(vc, animated: true, completion: nil)
              }
          }
           
       
    
    // MARK:- Helpers
    
    
    // For configuring User Interface
    func configureUI(){
        
        let gestureCptCodeType = UITapGestureRecognizer(target: self , action: #selector(self.handleCptCodePressed))
        self.cptCodeTextField.addGestureRecognizer(gestureCptCodeType)
        
       let gestureIlmCodeType = UITapGestureRecognizer(target: self , action: #selector(self.handleIlmCodePressed))
//        self.ilmCodeTextField.addGestureRecognizer(gestureIlmCodeType)
//
        addFieldButton.addTarget(self, action: #selector(handleaddTemponadeField), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(handleDoneButtonPress) , for: .touchUpInside)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
               
       // containerView.addSubview(backButton)
       // backButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 16, paddingLeft: 16, width: 25, height: 30)
       // containerView.addSubview(titleLabel)
       // titleLabel.centerX(inView: backButton)
        
        containerView.addSubview(doneButton)
        doneButton.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingRight: 20, height: 31)
        
        containerView.addSubview(virectomySegmentedView)
        
        virectomySegmentedView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 60, paddingLeft: 20,  paddingRight: 20, height: 31)
        
        containerView.addSubview(gaugeLabel)
        gaugeLabel.anchor(top: virectomySegmentedView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 8, paddingLeft: 30, width : 60 , height: 31)
        
        containerView.addSubview(textFieldGauge)
        textFieldGauge.anchor(top: virectomySegmentedView.bottomAnchor, left: gaugeLabel.rightAnchor, paddingTop: 8, paddingLeft: 90, width : 60 , height: 31)
       
        containerView.addSubview(scleralBuckleSegmentedView)
        scleralBuckleSegmentedView.anchor(top: gaugeLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20, height: 31)
         
        
         containerView.addSubview(bandLabel)
         bandLabel.anchor(top: scleralBuckleSegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 8, paddingLeft: 30,  width : 60, height: 31)
        
        containerView.addSubview(textFieldBand)
        textFieldBand.anchor(top: scleralBuckleSegmentedView.bottomAnchor, left: bandLabel.rightAnchor,  paddingTop: 8, paddingLeft: 90,  width : 60, height: 31)
        
        containerView.addSubview(sleeveLabel)
        sleeveLabel.anchor(top: bandLabel.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 8, paddingLeft: 30, width: 60 , height: 31)
        
        containerView.addSubview(textFieldSleeve)
        textFieldSleeve.anchor(top: textFieldBand.bottomAnchor, left: sleeveLabel.rightAnchor,  paddingTop: 8, paddingLeft: 90,  width : 60, height: 31)
         
        containerView.addSubview(srfDrainSegmentedView)
        srfDrainSegmentedView.anchor(top: sleeveLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(acTapSegmentedView)
        acTapSegmentedView.anchor(top: srfDrainSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(radialElementSegmentedView)
                      radialElementSegmentedView.anchor(top: acTapSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
               
        let stackView1 = UIStackView(arrangedSubviews: [corodialDamageSegmentedView , cryotherapySegmentedView, fluidAirExchangeSegmentedView , focalEndolasorSegmentedView , ilmPeelSegmentedView , ilmCodeSegmentedControl,indirectLaserTearSegmentedView ,  membranePeelSegmentedView , pfoSegmentedView , prpLaserSegmentedView ,
            retinectomySegmentedView , siliconeOilExchangeSegmentedView,siliconeOilRemovalSegmentedView, iolExchangeSegmentedView ,  iolRepositionSegmentedView , iosInsertionSegmentedView] )
        
        stackView1.spacing = 0
        stackView1.axis = .vertical
        stackView1.distribution = .fillProportionally
               
        containerView.addSubview(stackView1)
        stackView1.anchor(top: radialElementSegmentedView.bottomAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 8,paddingLeft: 20,paddingRight: 20)
        
        containerView.addSubview(aciolSegmentedView)
        aciolSegmentedView.anchor(top: stackView1.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
       
        containerView.addSubview(selcusIOLSegmentedView)
        selcusIOLSegmentedView.anchor(top: aciolSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
//        containerView.addSubview(scleralFixatedIOLLabel)
//        scleralFixatedIOLLabel.anchor(top: selcusIOLSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(suturedSegmentedView)
        suturedSegmentedView.anchor(top: selcusIOLSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(suturelessSegmentedView)
        suturelessSegmentedView.anchor(top: suturedSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(iolName)
        iolName.anchor(top: suturelessSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 31)
        
        containerView.addSubview(iolNameTextField)
        iolNameTextField.anchor(top: iolName.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 34)
        
        containerView.addSubview(iolPowers)
        iolPowers.anchor(top: iolNameTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 31)
        
        containerView.addSubview(iolPowersTextField)
        iolPowersTextField.anchor(top: iolPowers.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 34)
        
       
        containerView.addSubview(pplSegmentedView)
        pplSegmentedView.anchor(top: iolPowersTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20, height: 31)
        
        containerView.addSubview(withFragSegmentedView)
        withFragSegmentedView.anchor(top: pplSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
//        containerView.addSubview(withOutFragSegmentedView)
//               withOutFragSegmentedView.anchor(top: withFragSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(tamponadeLabel)
        tamponadeLabel.anchor(top: withFragSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 10, height: 31)
        
        containerView.addSubview(tamponadeSegmentControl)
        tamponadeSegmentControl.anchor(top: tamponadeLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 10, height: 31)
        
        containerView.addSubview(addFieldButton)
        addFieldButton.anchor(top: tamponadeSegmentControl.bottomAnchor, left: containerView.leftAnchor, paddingTop: 10, paddingLeft: 10  , width: 100 ,height: 31)
        
        containerView.addSubview(percentageValueLabel)
        percentageValueLabel.anchor(top: tamponadeSegmentControl.bottomAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingRight: 150  , width: 40 ,height: 31)
        
        containerView.addSubview(percentageValueTextField)
        percentageValueTextField.anchor(top: tamponadeSegmentControl.bottomAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingRight: 130  , width: 40 ,height: 31)
        containerView.addSubview(otherFieldLabel)
        otherFieldLabel.anchor(top: addFieldButton.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20,  paddingRight: 20, width: 100 ,height: 31)
        
        containerView.addSubview(otherField2)
        otherField2.anchor(top: otherFieldLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, width: 100 ,height: 31)
        
        
        
        containerView.addSubview(positioning)
        positioning.anchor(top: otherField2.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 31)
        
        containerView.addSubview(positioningTextField)
        
        positioningTextField.anchor(top: positioning.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 34)
        
        containerView.addSubview(cptCodeLabel)
        cptCodeLabel.anchor(top: positioningTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 34)
        
        containerView.addSubview(cptCodeTextField)
       cptCodeTextField.anchor(top: cptCodeLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20 , height: 100 )
        
        containerView.addSubview(cptCodeOtherTextField)
        cptCodeOtherTextField.anchor(top: cptCodeTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 34)
        
        
        containerView.addSubview(commentLabel)
        
        commentLabel.anchor(top: cptCodeOtherTextField.bottomAnchor, left: containerView.leftAnchor,right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 30)
        
        
        containerView.addSubview(commentTexfield)
        commentTexfield.anchor(top: commentLabel.bottomAnchor, left: containerView.leftAnchor,right: containerView.rightAnchor , paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 120)
        commentTexfield.backgroundColor = .lightGray
        
       
       
    }
    
        @objc func handleIlmPeelSegmentedControllPress(){
            
             if ilmPeelSegmentControl.titleForSegment(at: ilmPeelSegmentControl.selectedSegmentIndex) == "Yes" {
//              ilmCodeTextField.isEnabled = true
             } else{
//                ilmCodeTextField.isEnabled = false
            }
      
        
        
    
    }
    

    
    
    
    // done button for keyboard
        func doneButtonForKeyboard(){
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
            
            
            toolbar.setItems([flexibleSpace,doneButton], animated: false)
           
          commentTexfield.inputAccessoryView = toolbar
          textFieldGauge.inputAccessoryView = toolbar
          textFieldSleeve.inputAccessoryView = toolbar
          textFieldBand.inputAccessoryView = toolbar
          iolPowersTextField.inputAccessoryView = toolbar
          iolNameTextField.inputAccessoryView = toolbar
          positioningTextField.inputAccessoryView = toolbar
          percentageValueTextField.inputAccessoryView = toolbar
          cptCodeOtherTextField.inputAccessoryView = toolbar
          cptCodeTextField.inputAccessoryView = toolbar
        
        }
    
    
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           activeField = textField
       }
       
       func textFieldDidEndEditing(_ textField: UITextField){
           activeField = nil
       }
    
   
}

@available(iOS 13.0, *)
extension EditSurgeryViewController : AddFieldDelegateSurgery {
    func addFieldSelectionDelegate(otherSpace: String , otherSpace1 : String) {
        self.otherFieldLabel.text = otherSpace
        self.otherField2.text = otherSpace1
    }
    
    
    
}

@available(iOS 13.0, *)
extension EditSurgeryViewController : CptCodesEditDelegate {
    func SelectedCptEditCodes(cptCodes: [Any]) {
        
        print("entered here")
        var dataArray = cptCodes as! [String]
        
        let dataString = dataArray.joined(separator: ", ")
        print("data String " , dataString )
        cptCodeTextField.text! = dataString
        
    }
    
    
}

@available(iOS 13.0, *)
extension EditSurgeryViewController : IlmCodesEditDelegate {
    func SelectedIlmEditCodes(ilmCodes: [Any]) {
        
        var dataArray = ilmCodes as! [String]
                    
                    let dataString = dataArray.joined(separator: ", ")
                    
//              ilmCodeTextField.text! = dataString
    }
  
    
}

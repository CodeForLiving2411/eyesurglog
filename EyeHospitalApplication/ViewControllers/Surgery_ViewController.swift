//
//  Surgery_ViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
//import IHKeyboardAvoiding
//bimport DropDown

@available(iOS 13.0, *)
class Surgery_ViewController: UIViewController , UITextFieldDelegate {
    
    // MARK:- Properties
     var valuesurg = 0
     var mrnTemp = 0
    var unloggedCaseId = 0;
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
    
    var dataList = [ "Select CPT Code" ,"67036 - PPV" , "67039 - PPV with focal laser" , "67040 - PPV with PRP laser" , "67041 - PPV for ERM" , "67042 - PPV with ILM peel (MH)"  , "67043 - PPV with subretinal membrane removal" , "67107 - Scleral buckle for RRD" , "67108 - PPV with or without SB for RRD" , "67110 - Pneumatic retinopexy" , "67113 - Complex RD repair" , "67121 - Removal of implanted material" ,"67141 - Cryo tear" , "67145 - Laser tear or lattice" , "66825 - IOL reposition" , "66850 - Removal of lens material" , "66985 - Insert secondary IOL" , "66986 - IOL exchange" , "65236 - Remove IOFB from AC" , "65260 - Remove IOFB from vitreous with magnet" , "65265 - Remove IOFB from vitreous without magnet"]
    
   
    
    
    
    
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
         segControl.selectedSegmentTintColor = .link
         segControl.selectedSegmentIndex = 0
        
        // segControl.backgroundColor = .link
         segControl.addTarget(self, action: #selector(handleSegmentedControl(sender:)), for: .valueChanged)
       //  label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 160 , height: 30)
         view.addSubview(segControl)
        
        segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
                segControl.centerY(inView: view)
      if items.count == 2  {
          width = 81
         label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 220 , height: 30)
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
                    width = 280
        label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 70 , height: 30)
        label.font = UIFont.systemFont(ofSize: 14)
        segControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
        segControl.centerY(inView: view)
        
        let font = UIFont.systemFont(ofSize: 8)
               segControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
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
          label.textColor = UIColor.link
          label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
          
          return label
      }()
      
      
      // Home Button
         let homeButton: UIButton = {
                   let button = UIButton(type: .system)
                   button.setImage(#imageLiteral(resourceName: "home1").withRenderingMode(.alwaysOriginal), for: .normal)
            //       button.addTarget(self, action: #selector(handleHomeTapped), for: .touchUpInside)
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
              
       
              return button
          }()
    
  
    // Textfeld gauge, band , Sleeve
    //--------------------------------------------
    
  //  @IBOutlet weak var scrollView: UIScrollView!
    
    
    var textFieldGauge: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16.0)
        return tf
    }()
    
     var textFieldBand: UITextField = {
         let tf = UITextField()
        tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 16.0)
         return tf
    }()

     var textFieldSleeve: UITextField = {
     let tf = UITextField()
             tf.borderStyle = .roundedRect
             tf.font = UIFont.systemFont(ofSize: 16.0)
             return tf
   }()
    //--------------------------------------------
    
    var percentageValueTextField: UITextField = {
    let tf = UITextField()
    tf.borderStyle = .roundedRect
    return tf
    }()
    
    var percentageValueLabel: UILabel = {
               let label = UILabel()
               label.text = "% val"
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
    
//    var pplLabel: UILabel = { // label
//             let label = UILabel()
//             label.text = "PPL"
//             label.textColor = .black
//             label.font = UIFont.systemFont(ofSize: 16.0)
//
//             return label
//       }()
    
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
        tf.placeholder = "CPT Free Field(Optional)"
    return tf
    }()
    
//    var ilmCodeTextField: UITextField = {
//       let tf = UITextField()
//           tf.borderStyle = .roundedRect
//           tf.placeholder = "ILM Stain"
//           tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
//       return tf
//       }()
    
    
    // ilmCodeSegmentedControl
    lazy var ilmCodeSegmentedControl: UISegmentedControl = {
     
     let sc = UISegmentedControl(items: ["ICG" , "BBG" ,"Triamcinolone" ,"None"])
     sc.selectedSegmentIndex = 0
     sc.selectedSegmentTintColor = .link
     sc.accessibilityIdentifier = ilmCodeAccesiblityIdentifier
     sc.apportionsSegmentWidthsByContent = true
     return sc
    
     }()
    
    var gaugeLabel: UILabel = { // label
             let label = UILabel()
             label.text = "Gauge"
             label.textColor = .black
             label.font = UIFont.systemFont(ofSize: 16.0)
             
             return label
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
    
    var gaugeMultipleTextField: UITextField = {
          let tf = UITextField()
        tf.placeholder = "Select gauge"
               tf.borderStyle = .roundedRect
          return tf
          }()
    
  
  
        var addGaugeButton:  UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
           
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true // height
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16) // font
        return button
       
    }()
    
         var addBandButton:  UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Add", for: .normal)
         button.setTitleColor(UIColor.link, for: .normal)
    
         button.layer.cornerRadius = 5
       
         button.widthAnchor.constraint(equalToConstant: 50).isActive = true // height
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16) // font
        
         return button
        
     }()
    
        var addSleeveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.link, for: .normal)
        button.layer.cornerRadius = 5
      
     
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true // height
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16) // font
      
        return button
       
    }()
    //------------------
    
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
    
    
    var activeField: UITextField?
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
    
//    lazy var tamponadeSegmentedView : UIView = {
//
//        let view = inputSurgeryContainerView(labelName: "Tamponade", segmentedControl: tamponadeSegmentControl, items: ["None" , "Air" , "SF6" , "C3F8" , "PFO" , "SO"])
//         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return view
//
//    }()
    
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
    
    // guage
//     lazy var gaugeSegmentedControl: UISegmentedControl  = {
//
//              let sc = UISegmentedControl(items: ["23" , "25", "27"])
//              sc.selectedSegmentIndex = 0
//        sc.accessibilityIdentifier = sleeveAccesiblityIdentifier
//        sc.selectedSegmentTintColor = .link
//              return sc
//
//              }()
//
//    lazy var gaugeSegmentedView : UIView = {
//
//                 let view = inputSurgeryContainerView(labelName: "Gauge", segmentedControl: gaugeSegmentedControl, items:  ["240" , "41" , "42"])
//                  view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//                 return view
//
//             }()

    //  Gauge
         lazy var gaugeSegmentedControl: UISegmentedControl  = {

              let sc = UISegmentedControl(items: ["20" , "23", "25" , "27" ,"25/27"])
              sc.selectedSegmentIndex = 2
              sc.accessibilityIdentifier = gaugeAccesiblityIdentifier
             sc.apportionsSegmentWidthsByContent = true
            sc.selectedSegmentTintColor = .link
              return sc

              }()

//        lazy var gaugeSegmentedView : UIView = {
//
//            let view = inputSurgeryContainerView(labelName: "Gauge", segmentedControl: gaugeSegmentedControl, items: ["23" , "25" , "27"])
//            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            return view
//              }()
//    // Gauge
//     lazy var GaugeSegmentedControl: UISegmentedControl  = {
//
//          let sc = UISegmentedControl(items: ["46" , "25" , "27"])
//          sc.selectedSegmentIndex = 0
//          sc.accessibilityIdentifier = gaugeAccesiblityIdentifier
//          return sc
//
//          }()
//
//    lazy var GaugeSegmentedView : UIView = {
//
//        let view = inputSurgeryContainerView(labelName: "Gauge 11", segmentedControl: GaugeSegmentedControl, items: ["23" , "25" , "27"])
//        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return view
//          }()
    
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
           
           let view = inputSurgeryContainerView(labelName: "SRF Drain ?", segmentedControl: srfDrainSegmentedControl, items: ["No" , "Yes"])
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
           
       }()
    
    // tamponade (first one)
//     lazy var tamponadeSegmentedControl: UISegmentedControl  = {
//
//             let sc = UISegmentedControl(items: ["Air" , "C3F8" , "SF6" , "None"])
//             sc.selectedSegmentIndex = 0
//        sc.accessibilityIdentifier = tamponade1AccesiblityIdentifier
//             return sc
//
//             }()
//    // tamponade (first one)
//    lazy var tamponade1SegmentedView : UIView = {
//
//              let view = inputSurgeryContainerView(labelName: "Tamponade", segmentedControl: tamponadeSegmentedControl, items: ["Air" , "C3F8" , "SF6" , "None"])
//               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//              return view
//
//          }()
    
    // sleeve
     lazy var SleeveSegmentedControl: UISegmentedControl  = {
              
              let sc = UISegmentedControl(items: ["270" , "70", "72"])
              sc.selectedSegmentIndex = 0
        sc.accessibilityIdentifier = sleeveAccesiblityIdentifier
              return sc
             
              }()
    
    lazy var SleeveSegmentedView : UIView = {
                 
                 let view = inputSurgeryContainerView(labelName: "Sleeve", segmentedControl: SleeveSegmentedControl, items:  ["270" , "41" , "42"])
                  view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                 return view
                 
             }()
    
    // band
    lazy var bandSegmentedControl: UISegmentedControl  = {
             
             let sc = UISegmentedControl(items: ["240" , "41" , "42"])
             sc.selectedSegmentIndex = 0
             sc.accessibilityIdentifier = bandAccesiblityIdentifier
             return sc
            
             }()
    
    lazy var bandSegmentedView : UIView = {
                    
                    let view = inputSurgeryContainerView(labelName: "Band", segmentedControl: bandSegmentedControl, items:   ["240" , "41" , "42"])
                    view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    return view
                    
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
                        
         let view = inputSurgeryContainerView(labelName: "IOL Reposition", segmentedControl:  iolRepositionSegmentedControl, items:   ["No","Yes"])
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
    
    
    
    
    
    
   
    
    
    
    
    //---------------------------------------
   
     //---------------------------------------
  //  @IBOutlet weak var avoidingView: UIView!
      // MARK:- Lifecycle
       override func viewWillAppear(_ animated: Bool) {
       // KeyboardAvoiding.avoidingView = self.avoidingView
        percentageValueLabel.isHidden = true
        percentageValueTextField.isHidden = true
           virectomySegmentedControl.selectedSegmentIndex = 1
           gaugeMultipleTextField.isEnabled = true
           gaugeMultipleTextField.backgroundColor = .white
           addGaugeButton.isEnabled = true
           addGaugeButton.isHidden = false
         
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
      
        textFieldGauge.isHidden = true
        textFieldBand.isHidden  = true
        textFieldSleeve.isHidden = true
    
       
        doneButtonForKeyboard()
        
        configureUI()

      //  -------------------------------
        gaugeMultipleTextField.isEnabled = false
        gaugeMultipleTextField.backgroundColor = .gray
        addGaugeButton.isHidden       = true
        bandSegmentedControl.isEnabled  = false
        addBandButton.isHidden         = true
        SleeveSegmentedControl.isEnabled = false
        addSleeveButton.isHidden       = true
       // tamponadeSegmentedControl.isEnabled = false
        srfDrainSegmentedControl.isEnabled = false
        acTapSegmentedControl.isEnabled = false
        radialElementSegmentedControl.isEnabled = false
       //-------------------------------
        
        aciolSegmentedControl.isEnabled = false
        selcusIOLSegmentedControl.isEnabled = false
        suturedSegmentedControl.isEnabled = false
        suturelessSegmentedControl.isEnabled = false
//        ilmCodeTextField.isEnabled = false
        ilmCodeSegmentedControl.isEnabled = false
        withFragSegmentedControl.isEnabled = false
        
                              
        
               
    }
    
    // MARK:- Selectors
    
    // add tamponade other Field
    @objc func handleaddTemponadeField() {
        
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddFieldSurgeryViewController") as! AddFieldSurgeryViewController
        vc.modalPresentationStyle = .fullScreen
        vc.addFieldDelegateSurgery = self
        vc.txtField1 = otherFieldLabel.text!
        vc.txtField2 = otherField2.text!
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
   
    
    @objc func handleSegmentedControl(sender : UISegmentedControl )   {
         let index = sender.selectedSegmentIndex
         print(index)
        switch sender.accessibilityIdentifier {
        case   vitrectomyAccesiblityIdentifier:
               virectomySegmentedControl.titleForSegment(at: index)
               handleVirectomySegMentedControll()
               
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case  gaugeAccesiblityIdentifier:
               
               gaugeSegmentedControl.titleForSegment(at: index)
               
               print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case scleralBuckleAccesiblityIdentifier :
             scleralBuckleSegmentedControl.titleForSegment(at: index)
            handleScleralBuckleSegmentedControl()
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case bandAccesiblityIdentifier :
             bandSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case sleeveAccesiblityIdentifier :
            SleeveSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
       
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
            handleIOLInsertionSegmentedControl()
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
             handleTamponade2SegmentedControl()
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
    
    
    // Tamponade 2 segmented Controll
    @objc func handleTamponade2SegmentedControl() {
        
        print(" Tamponade Button Was Pressed")
        
        if (tamponadeSegmentControl.selectedSegmentIndex == 2) || ( tamponadeSegmentControl.selectedSegmentIndex == 3) {
            percentageValueLabel.isHidden = false
            percentageValueTextField.isHidden = false
            
        }
        
        else {
            
            percentageValueLabel.isHidden = true
            percentageValueTextField.isHidden = true
            percentageValueTextField.text = ""
            
        }
    }
    
   
    
    
    // What happens on Surgery Next button pressed
    @objc func handleNextButton() {
        
        print("value of id at surgery" , valuesurg)
        
        var bandText  = String()
        var gaugeText  = String()
        var sleeveText  = String()
         
        let indirectLaserTearSeg = indirectLaserTearSegmentedControl.titleForSegment(at: indirectLaserTearSegmentedControl.selectedSegmentIndex)
        let prpLaserSeg = prpLaserSegmentedControl.titleForSegment(at: prpLaserSegmentedControl.selectedSegmentIndex)
        let focalEndolasorSeg = focalEndolasorSegmentedControl.titleForSegment(at: focalEndolasorSegmentedControl.selectedSegmentIndex)
        let pfoSeg = pfoSegmentedControl.titleForSegment(at: pfoSegmentedControl.selectedSegmentIndex)
        let fluidAirExchangeSeg = fluidAirExchangeSegmentedControl.titleForSegment(at: fluidAirExchangeSegmentedControl.selectedSegmentIndex)
        let retinectomySeg = retinectomySegmentControl.titleForSegment(at: retinectomySegmentControl.selectedSegmentIndex)
        let ilmPeelSeg = ilmPeelSegmentControl.titleForSegment(at: ilmPeelSegmentControl.selectedSegmentIndex)
        let membranePeelSeg = membranePeelSegmentedControl.titleForSegment(at: membranePeelSegmentedControl.selectedSegmentIndex)
        let commentText = commentTexfield.text
        var tamponadeSeg1 = "NA"
        let withFragSeg = withFragSegmentedControl.titleForSegment(at: withFragSegmentedControl.selectedSegmentIndex)
        var suturedSeg = suturedSegmentedControl.titleForSegment(at: suturedSegmentedControl.selectedSegmentIndex)
        var suturelessSeg = suturelessSegmentedControl.titleForSegment(at: suturelessSegmentedControl.selectedSegmentIndex)
        var sulcusIOLSeg = selcusIOLSegmentedControl.titleForSegment(at: selcusIOLSegmentedControl.selectedSegmentIndex)
        var aciolSeg = aciolSegmentedControl.titleForSegment(at: aciolSegmentedControl.selectedSegmentIndex)
        let iolExchangeSeg = aciolSegmentedControl.titleForSegment(at: aciolSegmentedControl.selectedSegmentIndex)
        let gaugeSeg = gaugeSegmentedControl.titleForSegment(at: gaugeSegmentedControl.selectedSegmentIndex)
        var acTapSeg = acTapSegmentedControl.titleForSegment(at: acTapSegmentedControl.selectedSegmentIndex)
        
          var radialElementSeg = radialElementSegmentedControl.titleForSegment(at: radialElementSegmentedControl.selectedSegmentIndex)
        var srfDrainSeg = srfDrainSegmentedControl.titleForSegment(at: srfDrainSegmentedControl.selectedSegmentIndex)
        let tamponadeSeg2 = tamponadeSegmentControl.titleForSegment(at: tamponadeSegmentControl.selectedSegmentIndex)
        let percentageTamponadeString = percentageValueTextField.text
        let otherFieldTamponadeString = otherFieldLabel.text
        let sleeveSeg = SleeveSegmentedControl.titleForSegment(at: SleeveSegmentedControl.selectedSegmentIndex)
        let bandSegmented = bandSegmentedControl.titleForSegment(at: bandSegmentedControl.selectedSegmentIndex)
        let withoutFragSeg = withOutFragSegmentedControl.titleForSegment(at: withOutFragSegmentedControl.selectedSegmentIndex)
        let otherField2String = otherField2.text // otherfield 2 is a label
        let virectomyString = virectomySegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex)
        let scleralBuckleString =
           scleralBuckleSegmentedControl.titleForSegment(at:scleralBuckleSegmentedControl.selectedSegmentIndex)
        
        let iolInsertionString =  iosInsertionSegmentedControl.titleForSegment(at:iosInsertionSegmentedControl.selectedSegmentIndex)
        let siliconeOilRemovalString = siliconeOilRemovalSegmentedControl.titleForSegment(at:siliconeOilRemovalSegmentedControl.selectedSegmentIndex)
        
        let siliconeOilExchangeString = siliconeOilExchangeSegmentedControl.titleForSegment(at:siliconeOilExchangeSegmentedControl.selectedSegmentIndex)
        
        let iolNameString =  iolNameTextField.text!
        let IolPowerstring = iolPowersTextField.text!
        let positioningString  = positioningTextField.text!
        
        // updated in last 2 major version
        let iolRepositionString = iolRepositionSegmentedControl.titleForSegment(at:iolRepositionSegmentedControl.selectedSegmentIndex)
        
        let cryotherapyString = cryotherapySegmentedControl.titleForSegment(at:cryotherapySegmentedControl.selectedSegmentIndex)
        
        let cptCodeDropdownString = cptCodeTextField.text
        
        let cptFreeTextBoxString = cptCodeOtherTextField.text
        
        
        
       
        
        // To check gauge Textfield (textFieldGauge) is empty or not
        if textFieldGauge.text == "" {
            gaugeText = gaugeSeg!
        }
        else{
            gaugeText = textFieldGauge.text!
        }
        
        // To check band Textfield (textFieldband) is empty or not
        if textFieldBand.text == "" {
            bandText = bandSegmented!
        }
        else{
            bandText = textFieldBand.text!
        }
        
        
        // To check band Textfield (textFieldSleeve) is empty or not
        if textFieldSleeve.text == "" {
            sleeveText = sleeveSeg!
        }
        else{
            sleeveText = textFieldSleeve.text!
        }
        
        
        //------------------------------------------------
        let virectomyValue = virectomySegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex)
        
       
        
        switch(virectomyValue) {

        case "Yes" :  print("proceed as it is")
            break
        case "No" : gaugeText =  ""
         print("Null value sent to gauge")

            break
        default : print("Not an option")
            break
        }
        
       //--------------------------------------------------
        let scleralBuckleValue = scleralBuckleSegmentedControl.titleForSegment(at: scleralBuckleSegmentedControl.selectedSegmentIndex)
        switch(scleralBuckleValue) {
            
        case "Yes" :   print("proceed as is it")
            break
        case "No"  :
                   bandText = ""
                   sleeveText = ""
                   tamponadeSeg1 = ""
                   srfDrainSeg = ""
                   acTapSeg = ""
                   radialElementSeg = ""
                   print("Null value sent to all")
                   
                   
         
                   
                   
                    
            break
        default : print("Not an Option")
            break
        }
        //--------------------------------------------------
        
        let iolInsertionValue = iosInsertionSegmentedControl.titleForSegment(at: iosInsertionSegmentedControl.selectedSegmentIndex)
        
        switch iolInsertionValue {
        case "Yes": print("proceed as it is ")
            break
        case "No" : aciolSeg = ""
                   sulcusIOLSeg = ""
                   suturedSeg = ""
                   suturelessSeg = ""
            
            break
        default: print("Not an Option")
        break
            
        }
        
        let corodialDrainageSeg = corodialDamageSegmented.titleForSegment(at: corodialDamageSegmented.selectedSegmentIndex)
        
        let ilmDrpDownString : String? 
        
        
        if ilmCodeSegmentedControl.isEnabled == true {
                   ilmDrpDownString = ilmCodeSegmentedControl.titleForSegment(at: ilmCodeSegmentedControl.selectedSegmentIndex)
               } else {
                   ilmDrpDownString = ""
               }
        
         //--------------------------------------------------
        // For PPL
        let pplString : String?
        
        
        if pplSegmentedControl.isEnabled == true {
            pplString = pplSegmentedControl.titleForSegment(at: pplSegmentedControl.selectedSegmentIndex)
               } else {
                   pplString = ""
               }
        
        
        
        
        
        
        
        //--------------------------------------------------
        
       
        // To insert data in SurgeryModel
        let surgeryModelInfo = SurgeryModel(personIdfromDemo1:valuesurg, gauge: gaugeText, band: bandText, sleeve: sleeveText, tamponad1: tamponadeSeg1, srfDrain: srfDrainSeg, acTap: acTapSeg,radialElement: radialElementSeg ,  membranePeel: membranePeelSeg, ilmPeel: ilmPeelSeg, retinectomy: retinectomySeg , fluidAirExchange: fluidAirExchangeSeg, pfo: pfoSeg, focalEndolaser: focalEndolasorSeg, prpLaser: prpLaserSeg, indirectLaserTear: indirectLaserTearSeg, iolExchange: iolExchangeSeg, aciol: aciolSeg, sulcusIol: sulcusIOLSeg, sutured: suturedSeg, sutureless: suturelessSeg, ppl: pplString, pplWithFrag: withFragSeg, pplWithoutFrag: withoutFragSeg , tamponade1: tamponadeSeg2,percentageTamponade: percentageTamponadeString ,otherFieldTamponade : otherFieldTamponadeString , otherField2: otherField2String, comments: commentText , virectomy: virectomyString , scleralBuckle: scleralBuckleString , iolInsertion: iolInsertionString, iolName: iolNameString , iolPower: IolPowerstring ,positioning: positioningString, siliconeOilRemoval: siliconeOilRemovalString , siliconeOilExchange: siliconeOilExchangeString , corodialDrainage: corodialDrainageSeg, iolReposition: iolRepositionString , cptCodeDropdown: cptCodeDropdownString, cptFreeTextBox: cptFreeTextBoxString, cryotherapy: cryotherapyString , ilmDropDown: ilmDrpDownString
            ,status: 0)
        
        // To create table in database
      
         // To insert the values in Surgery table in database
        let inserted = DatabaseManager.shared.insertSurgeryData(surgeryModelInfo)
               print(inserted)
        
       nextViewController()
      
        
       
        
        
    }
    
    func nextViewController(){
        DispatchQueue.main.async {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "Camera_ViewController") as! Camera_ViewController
               vc.modalPresentationStyle = .fullScreen
               vc.imageid = self.valuesurg
               vc.mrnTemp = self.mrnTemp
               vc.unloggedCaseId = self.unloggedCaseId
                               
            self.present(vc, animated: true, completion: nil)
                     
                    
                          
                 }
    }
    

     // button to show gauge textfield
    @objc func handleGaugeButton() {
        
        print("gauge Button Clicked")
        textFieldGauge.isHidden = false
    }
    
     // button to show band textfield
    @objc func handleBandButton() {
        textFieldBand.isHidden = false
    }
    
     // button to show sleeve textfield
    @objc func handleSleeveButton() {
        textFieldSleeve.isHidden = false
    }
    
    // done button for keyboard
      func doneButtonForKeyboard(){
          let toolbar = UIToolbar()
          toolbar.sizeToFit()
          let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
          
          let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
          
          
          toolbar.setItems([flexibleSpace,doneButton], animated: false)
          

        
        commentTexfield.inputAccessoryView = toolbar
        textFieldBand.inputAccessoryView = toolbar
        textFieldSleeve.inputAccessoryView = toolbar
        textFieldGauge.inputAccessoryView = toolbar
        iolPowersTextField.inputAccessoryView = toolbar
        iolNameTextField.inputAccessoryView = toolbar
        positioningTextField.inputAccessoryView = toolbar
        percentageValueTextField.inputAccessoryView = toolbar
        cptCodeOtherTextField.inputAccessoryView = toolbar
       
        
          
          
         
      }
    
       // done for keyboard (Object C function )
       @objc func doneClicked(){
           view.endEditing(true)
       
    }
    @objc func handleBackButton() {
        let deleted = DatabaseManager.shared.deleteDiagnosisTempDataWhenBactPressedAtSurgery(withID: valuesurg)
            print("deleted is " , deleted)
            dismiss(animated: true, completion: nil)
       
    }
    

    
     @objc func handleHomeButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: true)
        }
    
    
    @objc func handleVirectomySegMentedControll() {
        
        print("virectory pressed")
        
        if  virectomySegmentedControl.titleForSegment(at: virectomySegmentedControl.selectedSegmentIndex) == "Yes" {
            gaugeSegmentedControl.isEnabled = true
            gaugeMultipleTextField.backgroundColor = .white
            addGaugeButton.isEnabled = false
            addGaugeButton.isHidden = true
                   
                   
               }
               else {
                   gaugeSegmentedControl.isEnabled = false
//                 gaugeMultipleTextField.backgroundColor = .gray;               addGaugeButton.isEnabled = false
                    addGaugeButton.isHidden = true 
               }
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
    
    
    @objc func handleScleralBuckleSegmentedControl() {
         print("sceleral Buckcle pressed")
        
        if scleralBuckleSegmentedControl.titleForSegment(at: scleralBuckleSegmentedControl.selectedSegmentIndex) == "Yes" {

            bandSegmentedControl.isEnabled = true
            addBandButton.isHidden = false
            SleeveSegmentedControl.isEnabled = true
            addSleeveButton.isHidden = false
           // tamponadeSegmentedControl.isEnabled = true
            srfDrainSegmentedControl.isEnabled = true
            acTapSegmentedControl.isEnabled = true
            radialElementSegmentedControl.isEnabled = true
              
              
              
              }
        else  {
             bandSegmentedControl.isEnabled = false
              
                              addBandButton.isHidden = true
                              SleeveSegmentedControl.isEnabled = false
                              addSleeveButton.isHidden = true
                           //   tamponadeSegmentedControl.isEnabled = false
                              srfDrainSegmentedControl.isEnabled = false
                              acTapSegmentedControl.isEnabled = false
                            radialElementSegmentedControl.isEnabled = false
              }
             
    }
    
    @objc func handleIOLInsertionSegmentedControl() {
        
        if iosInsertionSegmentedControl.titleForSegment(at: iosInsertionSegmentedControl.selectedSegmentIndex) == "Yes" {
            aciolSegmentedControl.isEnabled = true
            selcusIOLSegmentedControl.isEnabled = true
            suturedSegmentedControl.isEnabled = true
            suturelessSegmentedControl.isEnabled = true
        }
        
        else {
            
            aciolSegmentedControl.isEnabled = false
            selcusIOLSegmentedControl.isEnabled = false
            suturedSegmentedControl.isEnabled = false
            suturelessSegmentedControl.isEnabled = false
                       
            
        }
    }
    
    @objc func  handleCptCodePressed(){
        
        DispatchQueue.main.async {
            
            
            let vc = CPTSelectionViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.cptCodesDelegate = self
            vc.codeType = 1
            self.present(vc, animated: true, completion: nil)
        }
    }
    
//    @objc func  handleIlmCodePressed(){
//
//           DispatchQueue.main.async {
//
//
//               let vc = CPTSelectionViewController()
//               vc.modalPresentationStyle = .fullScreen
//               vc.ilmCodesDelegate = self
//                vc.codeType = 2
//               self.present(vc, animated: true, completion: nil)
//           }
//       }
//
    
    @objc func  handleGaugeCodePressed(){
        
        DispatchQueue.main.async {
          
            let vc = CPTSelectionViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.gaugeCodeDelegate = self
            vc.codeType = 3
         
            self.present(vc, animated: true, completion: nil)
        }
    }
        
        @objc func handleIlmPeelSegmentedControllPress(){
            
             if ilmPeelSegmentControl.titleForSegment(at: ilmPeelSegmentControl.selectedSegmentIndex) == "Yes" {
                 ilmCodeSegmentedControl.isEnabled  = true
//              ilmCodeTextField.isEnabled = true
             } else{
//                ilmCodeTextField.isEnabled = false
                 ilmCodeSegmentedControl.isEnabled  = false

            }
      
    }
    
    
    
     // MARK:- Helpers Functions
    
    // For configuring User Interface
    func configureUI(){
        
        let gestureCptCodeType = UITapGestureRecognizer(target: self , action: #selector(self.handleCptCodePressed))
        self.cptCodeTextField.addGestureRecognizer(gestureCptCodeType)
        
//        let gestureIlmCodeType = UITapGestureRecognizer(target: self , action: #selector(self.handleIlmCodePressed))
//        self.ilmCodeTextField.addGestureRecognizer(gestureIlmCodeType)
        
        
        // Geature for gauge Code 
        let gestureGaugeCodeType = UITapGestureRecognizer(target: self , action: #selector(self.handleGaugeCodePressed))
        self.gaugeMultipleTextField.addGestureRecognizer(gestureGaugeCodeType)
        
        
        addGaugeButton.addTarget(self, action: #selector(handleGaugeButton), for: .touchUpInside)
        
        addBandButton.addTarget(self, action: #selector(handleBandButton), for: .touchUpInside)
        
        addSleeveButton.addTarget(self, action: #selector(handleSleeveButton), for: .touchUpInside)
        
        
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        homeButton.addTarget(self, action: #selector(handleHomeButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        addGaugeButton.addTarget(self, action: #selector(handleGaugeButton), for: .touchUpInside)
        addBandButton.addTarget(self, action: #selector(handleBandButton), for: .touchUpInside)
        addSleeveButton.addTarget(self, action: #selector(handleSleeveButton), for: .touchUpInside)
        addFieldButton.addTarget(self, action: #selector(handleaddTemponadeField), for: .touchUpInside)
        tamponadeSegmentControl.addTarget(self, action: #selector(handleSegmentedControl(sender:)), for: .valueChanged)
        
        
        
        
        
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
               
        containerView.addSubview(backButton)
        
        backButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 8, width: 26, height: 24)
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 12, paddingLeft: 8, width: 26, height: 24)
        
        
        containerView.addSubview(homeButton)
        homeButton.anchor(top: containerView.topAnchor,right: containerView.rightAnchor , paddingTop: 6, paddingRight: 20 , width: 40, height: 40)
        
       
        
        containerView.addSubview(virectomySegmentedView)
        
        virectomySegmentedView.anchor(top: backButton.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 20,  paddingRight: 20, height: 31)
        
        
        
        containerView.addSubview(gaugeSegmentedControl)
        gaugeSegmentedControl.anchor(top: virectomySegmentedView.bottomAnchor, left: containerView.leftAnchor , paddingTop: 10, paddingLeft: 127, height: 31)
        
        containerView.addSubview(gaugeLabel)
        gaugeLabel.anchor(top: virectomySegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 20,  width: 60, height: 31)
       
       
        
//        containerView.addSubview(gaugeMultipleTextField)
//               gaugeMultipleTextField.anchor(top: virectomySegmentedView.bottomAnchor, left: gaugeLabel.rightAnchor,  paddingTop: 10, paddingLeft: 45,  width: 145, height: 31)
//
//        containerView.addSubview(addGaugeButton)
//        addGaugeButton.anchor(top: virectomySegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 280, width: 40 ,height: 31)
////
//      containerView.addSubview(textFieldGauge)
//      textFieldGauge.anchor(top: virectomySegmentedView.bottomAnchor, left:     containerView.leftAnchor,  paddingTop: 10, paddingLeft: 325, width: 50 ,height: 31)
        
        containerView.addSubview(scleralBuckleSegmentedView)
        scleralBuckleSegmentedView.anchor(top: gaugeSegmentedControl.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20, height: 31)
         
         containerView.addSubview(bandSegmentedView)
         bandSegmentedView.anchor(top: scleralBuckleSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
                containerView.addSubview(addBandButton)
                addBandButton.anchor(top: scleralBuckleSegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 280, width: 40 ,height: 31)
        //
              containerView.addSubview(textFieldBand)
              textFieldBand.anchor(top: scleralBuckleSegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 325, width: 50 ,height: 31)
                
         containerView.addSubview(SleeveSegmentedView)
         SleeveSegmentedView.anchor(top: bandSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        
        containerView.addSubview(addSleeveButton)
                addSleeveButton.anchor(top: bandSegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 280, width: 40 ,height: 31)
        //
              containerView.addSubview(textFieldSleeve)
              textFieldSleeve.anchor(top: bandSegmentedView.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 325, width: 50 ,height: 31)
                
        
        containerView.addSubview(srfDrainSegmentedView)
        srfDrainSegmentedView.anchor(top: SleeveSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(acTapSegmentedView)
        acTapSegmentedView.anchor(top: srfDrainSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        
        containerView.addSubview(radialElementSegmentedView)
               radialElementSegmentedView.anchor(top: acTapSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
               
        let stackView1 = UIStackView(arrangedSubviews: [corodialDamageSegmentedView , cryotherapySegmentedView, fluidAirExchangeSegmentedView , focalEndolasorSegmentedView , ilmPeelSegmentedView , ilmCodeSegmentedControl ,indirectLaserTearSegmentedView   , membranePeelSegmentedView , pfoSegmentedView , prpLaserSegmentedView ,retinectomySegmentedView , siliconeOilExchangeSegmentedView,siliconeOilRemovalSegmentedView ,iolExchangeSegmentedView, iolRepositionSegmentedView, iosInsertionSegmentedView ] )
        
        stackView1.spacing = 0
        stackView1.axis = .vertical
        stackView1.distribution = .fillProportionally
               
        containerView.addSubview(stackView1)
        stackView1.anchor(top: radialElementSegmentedView.bottomAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 8,paddingLeft: 20,paddingRight:20)
        
        containerView.addSubview(aciolSegmentedView)
        aciolSegmentedView.anchor(top: stackView1.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
       
        containerView.addSubview(selcusIOLSegmentedView)
        selcusIOLSegmentedView.anchor(top: aciolSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
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
        tamponadeLabel.anchor(top: withFragSegmentedView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 30,  paddingRight: 20, height: 31)
        
        containerView.addSubview(tamponadeSegmentControl)
        tamponadeSegmentControl.anchor(top: tamponadeLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 10,  paddingRight: 10, height: 31)
        
        containerView.addSubview(addFieldButton)
        addFieldButton.anchor(top: tamponadeSegmentControl.bottomAnchor, left: containerView.leftAnchor, paddingTop: 10, paddingLeft: 10  , width: 100 ,height: 31)
        // percentage label 
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
        
        containerView.addSubview(nextButton)
        nextButton.anchor(top: commentTexfield.bottomAnchor, right: containerView.rightAnchor , paddingTop: 10 , paddingRight: 20, width: 100)
        
       
        
    }
    
       func textFieldDidBeginEditing(_ textField: UITextField) {
           activeField = textField
       }
       
       func textFieldDidEndEditing(_ textField: UITextField){
           activeField = nil
       }
    
   
}

@available(iOS 13.0, *)
extension Surgery_ViewController : AddFieldDelegateSurgery {
    func addFieldSelectionDelegate(otherSpace: String , otherSpace1 : String) {
        self.otherFieldLabel.text = otherSpace
        self.otherField2.text = otherSpace1
    }
  
}


@available(iOS 13.0, *)
extension Surgery_ViewController : CptCodesDelegate {
    
    
    func SelectedCptCodes(cptCodes: [Any]) {
        
        var dataArray = cptCodes as! [String]
        
        let dataString = dataArray.joined(separator: " & ")
        
        cptCodeTextField.text! = dataString
   
    }
}

@available(iOS 13.0, *)
extension Surgery_ViewController : IlmCodesDelegate {
    
    
    func SelectedIlmCodes(ilmCodes: [Any]) {
        var dataArray = ilmCodes as! [String]
              
              let dataString = dataArray.joined(separator: " & ")
              
//        ilmCodeTextField.text! = dataString
    }
  
    }


@available(iOS 13.0, *)
extension Surgery_ViewController : GaugeCodeDelegate {
    
    
    func SelectGaugeCode(gaugeCodes: [Any]) {
        var dataArray = gaugeCodes as! [String]
                     
        let dataString = dataArray.joined(separator: " & ")
                     
        gaugeMultipleTextField.text! = dataString
    }
    }
































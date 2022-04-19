//
//  Demographics2_ViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 23/09/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
// others field not crezted yet
 @available(iOS 13.0, *)
extension UIViewController{
    
//    func HideKeyboardForDemo2(){
//        let Tap = UITapGestureRecognizer(target : self , action : #selector(DismissKeyboardForDemo2))
//        view.addGestureRecognizer(Tap)
//
//    }
//
//    @objc func DismissKeyboardForDemo2(){
//        view.endEditing(true)
//    }
}
 @available(iOS 13.0, *)
class Demographics2_ViewController: UIViewController, UITextFieldDelegate{
    
    // MARK:- Properties
    var validation = Validation()
    var valueDemo = 0
    var textFieldCount = 0
    var mrnTemp = 0
    var unloggedCaseId = 0;
    
    // Accesiblity Identifier
    let aphakiaAccessIdentifier = "aphakia"
    let cataractAccessIdentifier = "cataract"
    let choroidalEffusionAccessIdentifier =  "choroidalEffusion"
    let choroidalHemorrhageAccessIdentifier = "choroidalHemorrhage"
    let diabeticTRDAccessIdentifier = "diabeticTRD"
    let dislocatedIntraocularLensAccessIdentifier = "dislocatedIntraocularLens"
    let endophthalmitisAccessIdentifier = "endophthalmitis"
    let epiretinalMembraneAccessIdentifier = "epiretinalMembrane"
    let fevrAccessIdentifier = "fevr"
    let floatersAccessIdentifier = "floaters"
    let fullThicknessMacularHoleAccessIdentifier =  "fullThicknessMacularHole"
    let intraocularForeignBodyAccessIdentifier = "intraocularForeignBody"
    let lamellarMacularHoleAccessIdentifier = "lamellarMacularHole"
    let latticeDegenerationAccessIdentifier = "latticeDegeneration"
    let pdrAccessIdentifier = "pdr"
    let primaryRDWithPVRAccessIdentifier =  "primaryRDWithPVR"
    let recurrentRDWithPVRAccessIdentifier = "recurrentRDWithPVR"
    let recurrentRDWithoutPVRAccessIdentifier = "recurrentRDWithoutPVR"
    let retainedLensFragmentsAccessIdentifier = "retainedLensFragments"
    let retinalTearAccessIdentifier = "retinalTear"
    let retinalVeinOcclusionAccessIdentifier = "retinalVeinOcclusion"
    let rhegmatogenousRDMaculaOffAccessIdentifier = "rhegmatogenousRDMaculaOff"
    let rhegmatogenousRDMaculaOnAccessIdentifier = "rhegmatogenousRDMaculaOn"
    let ropAccessIdentifier = "rop"
    let sickleCellAccessIdentifier = "sickleCell"
    let spRDRepairWithSiliconeOilAccessIdentifier = "spRDRepairWithSiliconeOil"
    let subluxedCrystallineLensAccessIdentifier = "subluxedCrystallineLens"
    let vitreousHemorrhageAccessIdentifier = "vitreousHemorrhage"
    let retinalDefectAccessIdentifier = "retinalDefect"
    
    var segControl = UISegmentedControl()
     
    
    func inputContainerView(labelName: String , segmentedControl : UISegmentedControl) -> UIView {
         let view = UIView()
         
         let label = UILabel()
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 16)
       //  label.backgroundColor = .red
         
         label.numberOfLines = 2
         label.text = labelName
         view.addSubview(label)
         
         segControl = UISegmentedControl(items: ["No", "Yes"] )
         segControl = segmentedControl
        // segControl.tintColor = .link
         segControl.selectedSegmentIndex = 0
        // segControl.backgroundColor = .link
         segControl.selectedSegmentTintColor = .link
         segControl.addTarget(self, action: #selector(handleSegmentedControl(sender:) ), for: .valueChanged)
        
         
         label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 5, paddingLeft: 20, width: 150, height: 30)
         view.addSubview(segControl)
         segControl.anchor( left: label.rightAnchor,  right: view.rightAnchor,  width: 81, height: 31)
         segControl.centerY(inView: view)
    
          return view
     }
    @objc func handleSegmentedControl(sender : UISegmentedControl )   {
        
        let index = sender.selectedSegmentIndex
      //  sender.titleForSegment(at: index)
       
        switch  sender.accessibilityIdentifier  {
        case aphakiaAccessIdentifier :   aphakiaSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
        
            
            break
        case cataractAccessIdentifier : catractSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case choroidalEffusionAccessIdentifier : choroidalEffusionSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
                       break
        case choroidalHemorrhageAccessIdentifier : choroidalHemorrhageSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case diabeticTRDAccessIdentifier :
            diabeticTRDSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case dislocatedIntraocularLensAccessIdentifier :
            dislocatedIntraocularLensSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case endophthalmitisAccessIdentifier :
            endophthalmitisSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case epiretinalMembraneAccessIdentifier :
            epiretinalMembraneSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case fevrAccessIdentifier :  fevrSegmentedControl.titleForSegment(at: index)
                   print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case floatersAccessIdentifier :
            floatersSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case fullThicknessMacularHoleAccessIdentifier :
            fullThicknessMacularHoleSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case intraocularForeignBodyAccessIdentifier :
            intraocularForeignBodySegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case lamellarMacularHoleAccessIdentifier :
            lamellarMacularHoleSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case latticeDegenerationAccessIdentifier:
            latticeDegenerationSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case pdrAccessIdentifier :
            pdrSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case primaryRDWithPVRAccessIdentifier :
            primaryRdWithPVRSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case recurrentRDWithPVRAccessIdentifier :
            
            recurrentRdWithPVRSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case recurrentRDWithoutPVRAccessIdentifier :
            recurrentRdWithoutPVRSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case retainedLensFragmentsAccessIdentifier :
            retainedLensFragmentsSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case retinalTearAccessIdentifier :
            retinalTearSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case retinalVeinOcclusionAccessIdentifier :
            retinalVeinOcclusionSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case rhegmatogenousRDMaculaOffAccessIdentifier :
            rhegmatogenousRdMaculaOffSegmentedControl.titleForSegment(at: index)
                       print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case rhegmatogenousRDMaculaOnAccessIdentifier :
            rhegmatogenousRdMaculaOnSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case ropAccessIdentifier :
            ropSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case sickleCellAccessIdentifier :
            sickleCellSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case spRDRepairWithSiliconeOilAccessIdentifier :
            spRdRepairWithSiliconeOilSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case subluxedCrystallineLensAccessIdentifier :
            subluxedCrystallineLensSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case vitreousHemorrhageAccessIdentifier :
            vitreousHemorrhageSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
        case retinalDefectAccessIdentifier :
            retinalDefectSegmentedControl.titleForSegment(at: index)
            print("name -->" , sender.accessibilityIdentifier , "index -->"  , index)
            break
            
        default : print("not a valid option")
            
       
        }
        
        
    }
    
     lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)
    
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
        label.text = "Diagnosis"
        label.textColor = UIColor.link
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        return label
    }()
    
    
    // Home Button
       let homeButton: UIButton = {
                 let button = UIButton(type: .system)
                 button.setImage(#imageLiteral(resourceName: "home1").withRenderingMode(.alwaysOriginal), for: .normal)
          
                 return button
             }()
    
    // Add Field Button
    private let addFieldButton : UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Add Field", for: .normal)
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
    
   
    
   
    
    let otherFieldLabel1 : UILabel = {
        let lbl = UILabel()
        // tf.borderStyle = .roundedRect
         lbl.font = UIFont.systemFont(ofSize: 18)
         lbl.textColor = .black
        lbl.text = ""
        // tf.keyboardAppearance = .dark
        // tf.isSecureTextEntry = isSecureTextEntry
        // tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return lbl
    }()
    
    let otherFieldLabel2 : UILabel = {
           let lbl = UILabel()
           // tf.borderStyle = .roundedRect
            lbl.font = UIFont.systemFont(ofSize: 18)
            lbl.textColor = .black
         lbl.text = ""
           // tf.keyboardAppearance = .dark
           // tf.isSecureTextEntry = isSecureTextEntry
           // tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
           return lbl
       }()
    
    let otherFieldLabel3 : UILabel = {
           let lbl = UILabel()
           // tf.borderStyle = .roundedRect
            lbl.font = UIFont.systemFont(ofSize: 18)
            lbl.textColor = .black
        lbl.text = ""
           // tf.keyboardAppearance = .dark
           // tf.isSecureTextEntry = isSecureTextEntry
           // tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
           return lbl
       }()
    
    let otherFieldLabel4 : UILabel = {
           let lbl = UILabel()
           // tf.borderStyle = .roundedRect
            lbl.font = UIFont.systemFont(ofSize: 18)
            lbl.textColor = .black
            lbl.text = ""
           // tf.keyboardAppearance = .dark
           // tf.isSecureTextEntry = isSecureTextEntry
           // tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
           return lbl
       }()
   
    
    
    
    
    
   
    
    
   
    // aphakia
    lazy var aphakiaSegmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["No" , "Yes"])
        sc.selectedSegmentIndex = 0
        sc.accessibilityIdentifier = aphakiaAccessIdentifier
        
        
        return sc
        
        
    }()
    
    lazy var aphakiaSegmentedView : UIView = {
        
        
           var view = inputContainerView(labelName: "Aphakia", segmentedControl: aphakiaSegmentedControl )
         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
        
    }()
    
    //catract
    lazy var catractSegmentedControl : UISegmentedControl = {
           let sc = UISegmentedControl(items: ["No" , "Yes"])
           sc.selectedSegmentIndex = 0
         sc.accessibilityIdentifier = cataractAccessIdentifier
           
           return sc
           
           
       }()
    
    lazy var catractSegmentedView : UIView = {
           
           
            var view = inputContainerView(labelName: "Cataract", segmentedControl: catractSegmentedControl )
           view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
       }()
    
   // Choroidaleffusion
    
    lazy var choroidalEffusionSegmentedControl : UISegmentedControl = {
           let sc = UISegmentedControl(items: ["No" , "Yes"])
           sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = choroidalEffusionAccessIdentifier
        
           
           return sc
           
           
       }()
    
    lazy var choroidalEffusionSegmentedView : UIView = {
           
           var  view = inputContainerView(labelName: "Choroidal effusion", segmentedControl: choroidalEffusionSegmentedControl )
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
       }()
    
    // choroidalHemorrhage
       
       lazy var choroidalHemorrhageSegmentedControl : UISegmentedControl = {
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
              sc.accessibilityIdentifier = choroidalHemorrhageAccessIdentifier
              return sc
              
              
          }()
       
       lazy var choroidalHemorrhageSegmentedView : UIView = {
              
              let view = inputContainerView(labelName: "Choroidal Hemorrhage", segmentedControl: choroidalHemorrhageSegmentedControl )
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
          }()
       
    
    // diabeticTRD
    
    lazy var diabeticTRDSegmentedControl : UISegmentedControl = {
           let sc = UISegmentedControl(items: ["No" , "Yes"])
           sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = diabeticTRDAccessIdentifier
           
           return sc
           
           
       }()
    
    lazy var diabeticTRDSegmentedView : UIView = {
           
           let view = inputContainerView(labelName: "Diabetic TRD", segmentedControl: diabeticTRDSegmentedControl )
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
       }()
    
      // dislocatedIntraocularLens

       
       lazy var  dislocatedIntraocularLensSegmentedControl : UISegmentedControl = {
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
              sc.accessibilityIdentifier = dislocatedIntraocularLensAccessIdentifier
              return sc
              
              
          }()
       
       lazy var dislocatedIntraocularLensSegmentedView : UIView = {
              
              let view = inputContainerView(labelName: "Dislocated Intraocular lens", segmentedControl: dislocatedIntraocularLensSegmentedControl )
               view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
          }()
    
         //  endophthalmitis

            
            lazy var endophthalmitisSegmentedControl : UISegmentedControl = {
                   let sc = UISegmentedControl(items: ["No" , "Yes"])
                   sc.selectedSegmentIndex = 0
                   sc.accessibilityIdentifier = endophthalmitisAccessIdentifier
                   return sc
                   
                   
               }()
            
            lazy var endophthalmitisSegmentedView : UIView = {
                   
                   let view = inputContainerView(labelName: "Endophthalmitis", segmentedControl: endophthalmitisSegmentedControl )
                 view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                   return view
               }()
       
   // epiretinalMembrane
    
              lazy var  epiretinalMembraneSegmentedControl : UISegmentedControl = {
                      let sc = UISegmentedControl(items: ["No" , "Yes"])
                      sc.selectedSegmentIndex = 0
                      sc.accessibilityIdentifier = epiretinalMembraneAccessIdentifier
                      return sc
                      
                      
                  }()
               
               lazy var epiretinalMembraneSegmentedView : UIView = {
                      
                      let view = inputContainerView(labelName: "Epiretinal Membrane", segmentedControl: epiretinalMembraneSegmentedControl )
                 view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                      return view
                  }()
    
    
    // FEVR
       
       lazy var  fevrSegmentedControl : UISegmentedControl = {
                         let sc = UISegmentedControl(items: ["No" , "Yes"])
                         sc.selectedSegmentIndex = 0
                         sc.accessibilityIdentifier = fevrAccessIdentifier
                         return sc
                         
                         
                     }()
                  
                  lazy var fevrSegmentedView : UIView = {
                         
                         let view = inputContainerView(labelName: "FEVR", segmentedControl: fevrSegmentedControl )
                          view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    
                         return view
                     }()
    
    // floaters 0r vitreous opacities
          
          lazy var floatersSegmentedControl : UISegmentedControl = {
                            let sc = UISegmentedControl(items: ["No" , "Yes"])
                            sc.selectedSegmentIndex = 0
                            sc.accessibilityIdentifier = floatersAccessIdentifier
                            return sc
                            
                            
                        }()
                     
                     lazy var floatersSegmentedView : UIView = {
                            
                            let view = inputContainerView(labelName: "Vitreous Opacities", segmentedControl: floatersSegmentedControl )
                         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        
                            return view
                        }()
       
    //fullThicknessMacularHole
    
    lazy var  fullThicknessMacularHoleSegmentedControl : UISegmentedControl = {
           let sc = UISegmentedControl(items: ["No" , "Yes"])
           sc.selectedSegmentIndex = 0
           sc.accessibilityIdentifier = fullThicknessMacularHoleAccessIdentifier
           return sc
           
           
       }()
    
    lazy var fullThicknessMacularHoleSegmentedView : UIView = {
           
           let view = inputContainerView(labelName: "Full thickness macular hole", segmentedControl: fullThicknessMacularHoleSegmentedControl )
         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
           return view
       }()
    
    //   intraocularForeignBody
       
       lazy var  intraocularForeignBodySegmentedControl : UISegmentedControl = {
              let sc = UISegmentedControl(items: ["No" , "Yes"])
              sc.selectedSegmentIndex = 0
              sc.accessibilityIdentifier = intraocularForeignBodyAccessIdentifier
              return sc
              
              
          }()
       
       lazy var intraocularForeignBodySegmentedView : UIView = {
              
              let view = inputContainerView(labelName: "Intraocular foreign body", segmentedControl: intraocularForeignBodySegmentedControl )
         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
              return view
          }()
       
    
    // lamellarMacularHole
    
      lazy var lamellarMacularHoleSegmentedControl : UISegmentedControl = {
                 let sc = UISegmentedControl(items: ["No" , "Yes"])
                 sc.selectedSegmentIndex = 0
                 sc.accessibilityIdentifier = lamellarMacularHoleAccessIdentifier
                 return sc
                 
                 
             }()
          
          lazy var lamellarMacularHoleSegmentedView : UIView = {
                 
                 let view = inputContainerView(labelName: "Lamellar macular hole", segmentedControl: lamellarMacularHoleSegmentedControl )
             view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                 return view
             }()
    
    // latticeDegeneration
    
    lazy var  latticeDegenerationSegmentedControl : UISegmentedControl = {
                    let sc = UISegmentedControl(items: ["No" , "Yes"])
                    sc.selectedSegmentIndex = 0
                    sc.accessibilityIdentifier = latticeDegenerationAccessIdentifier
                    return sc
                    
                    
                }()
             
             lazy var latticeDegenerationSegmentedView : UIView = {
                    
                    let view = inputContainerView(labelName: "Lattice degeneration", segmentedControl: latticeDegenerationSegmentedControl )
                 view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    return view
                }()
    
    // PDR
    
                lazy var  pdrSegmentedControl : UISegmentedControl = {
                       let sc = UISegmentedControl(items: ["No" , "Yes"])
                       sc.selectedSegmentIndex = 0
                       sc.accessibilityIdentifier = pdrAccessIdentifier
                       return sc
                       
                       
                   }()
                
                lazy var pdrSegmentedView : UIView = {
                       
                       let view = inputContainerView(labelName: "PDR", segmentedControl: pdrSegmentedControl )
                     view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                       return view
                   }()
    
    
   // primaryRdWithPVR
    
                          lazy var  primaryRdWithPVRSegmentedControl : UISegmentedControl = {
                          let sc = UISegmentedControl(items: ["No" , "Yes"])
                          sc.selectedSegmentIndex = 0
                          sc.accessibilityIdentifier = primaryRDWithPVRAccessIdentifier
                          return sc
                          
                          
                      }()
                   
                          lazy var primaryRdWithPVRSegmentedView : UIView = {
                          
                          let view = inputContainerView(labelName: "Primary RD with PVR", segmentedControl: primaryRdWithPVRSegmentedControl )
                          view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                          return view
                      }()
    // recurrentRdWithPVR
    
                       lazy var  recurrentRdWithPVRSegmentedControl : UISegmentedControl = {
                             let sc = UISegmentedControl(items: ["No" , "Yes"])
                             sc.selectedSegmentIndex = 0
                             sc.accessibilityIdentifier = recurrentRDWithPVRAccessIdentifier
                             return sc
                             
                             
                         }()
                      
                      lazy var recurrentRdWithPVRSegmentedView : UIView = {
                             
                             let view = inputContainerView(labelName: "Recurrent RD with PVR", segmentedControl: recurrentRdWithPVRSegmentedControl )
                             view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                             return view
         
                      }()
    
   // recurrentRdWithoutPVR
    
                               lazy var recurrentRdWithoutPVRSegmentedControl : UISegmentedControl = {
                               let sc = UISegmentedControl(items: ["No" , "Yes"])
                               sc.selectedSegmentIndex = 0
                               sc.accessibilityIdentifier =                   recurrentRDWithoutPVRAccessIdentifier
                               return sc
                               
                               
                           }()
                        
                             lazy var recurrentRdWithoutPVRSegmentedView : UIView = {
                               
                               let view = inputContainerView(labelName: "Recurrent RD without PVR", segmentedControl: recurrentRdWithoutPVRSegmentedControl )
                             view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                               return view
           
                        }()
    
   // retainedLensFragments
    
                             lazy var  retainedLensFragmentsSegmentedControl : UISegmentedControl = {
                                 let sc = UISegmentedControl(items: ["No" , "Yes"])
                                 sc.selectedSegmentIndex = 0
                                 sc.accessibilityIdentifier =                   retainedLensFragmentsAccessIdentifier
                                 return sc
                                 
                                 
                             }()
                          
                          lazy var retainedLensFragmentsPVRSegmentedView : UIView = {
                                 
                                 let view = inputContainerView(labelName: "Retained Lens Fragments", segmentedControl: retainedLensFragmentsSegmentedControl )
                                 view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                 return view
             
                          }()
    
    // retinalTear
    
                               lazy var  retinalTearSegmentedControl : UISegmentedControl = {
                                    let sc = UISegmentedControl(items: ["No" , "Yes"])
                                    sc.selectedSegmentIndex = 0
                                    sc.accessibilityIdentifier =                   retinalTearAccessIdentifier
                                    return sc
                                    
                                    
                                }()
                             
                             lazy var retinalTearSegmentedView : UIView = {
                                    
                                    let view = inputContainerView(labelName: "Retinal Tear", segmentedControl: retinalTearSegmentedControl )
                                    view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                    return view
                
                             }()
    
    // retinalVeinOcclusion
    
                                 lazy var  retinalVeinOcclusionSegmentedControl : UISegmentedControl = {
                                       let sc = UISegmentedControl(items: ["No" , "Yes"])
                                       sc.selectedSegmentIndex = 0
                                       sc.accessibilityIdentifier =                   retinalVeinOcclusionAccessIdentifier
                                       return sc
                                       
                                       
                                   }()
                                
                                lazy var retinalVeinOcclusionSegmentedView : UIView = {
                                       
                                       let view = inputContainerView(labelName: "Retinal vein occlusion", segmentedControl: retinalVeinOcclusionSegmentedControl )
                                       view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                       return view
                   
                                }()
    
    // rhegmatogenousRdMaculaOff
    
                                lazy var rhegmatogenousRdMaculaOffSegmentedControl : UISegmentedControl = {
                                       let sc = UISegmentedControl(items: ["No" , "Yes"])
                                       sc.selectedSegmentIndex = 0
                                       sc.accessibilityIdentifier =   rhegmatogenousRDMaculaOffAccessIdentifier
                                       return sc
                                       
                                       
                                   }()
                                
                                lazy var rhegmatogenousRdMaculaOffSegmentedView : UIView = {
                                       
                                       let view = inputContainerView(labelName: "Rhegmatogenous RD (macula off)", segmentedControl:  rhegmatogenousRdMaculaOffSegmentedControl )
                                       view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                       
                                        return view
                                }()
    
    // rhegmatogenousRdMaculaOn
    
                                       lazy var  rhegmatogenousRdMaculaOnSegmentedControl : UISegmentedControl = {
                                       let sc = UISegmentedControl(items: ["No" , "Yes"])
                                       sc.selectedSegmentIndex = 0
                                       sc.accessibilityIdentifier =   rhegmatogenousRDMaculaOnAccessIdentifier
                                       return sc
                                       
                                       
                                   }()
                                
                                lazy var rhegmatogenousRdMaculaOnSegmentedView : UIView = {
                                       
                                       let view = inputContainerView(labelName: "Rhegmatogenous RD (macula on)", segmentedControl: rhegmatogenousRdMaculaOnSegmentedControl )
                                        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                       return view
                                }()
    
    // ROP
    
                                     lazy var ropSegmentedControl : UISegmentedControl = {
                                       let sc = UISegmentedControl(items: ["No" , "Yes"])
                                       sc.selectedSegmentIndex = 0
                                       sc.accessibilityIdentifier = ropAccessIdentifier
                                       return sc
                                       
                                       
                                   }()
                                
                                     lazy var ropSegmentedView : UIView = {
                                       
                                       let view = inputContainerView(labelName: "ROP", segmentedControl: ropSegmentedControl )
                                     view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                        return view
                   
                                }()
    
    // sickleCell
       
                                          lazy var  sickleCellSegmentedControl : UISegmentedControl = {
                                          let sc = UISegmentedControl(items: ["No" , "Yes"])
                                          sc.selectedSegmentIndex = 0
                                          sc.accessibilityIdentifier = sickleCellAccessIdentifier
                                          return sc
                                          
                                          
                                      }()
                                   
                                   lazy var sickleCellSegmentedView : UIView = {
                                          
                                          let view = inputContainerView(labelName: "Sickle cell", segmentedControl: sickleCellSegmentedControl )
                                     view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                          
                                          return view
                                   }()
    
    // spRdRepairWithSiliconeOil
    
                                    lazy var  spRdRepairWithSiliconeOilSegmentedControl : UISegmentedControl = {
                                             let sc = UISegmentedControl(items: ["No" , "Yes"])
                                             sc.selectedSegmentIndex = 0
                                             sc.accessibilityIdentifier = spRDRepairWithSiliconeOilAccessIdentifier
                                             return sc
                                             
                                             
                                         }()
                                      
                                      lazy var spRdRepairWithSiliconeOilSegmentedView : UIView = {
                                             
                                             let view = inputContainerView(labelName: "s/p RD repair with silicone oil", segmentedControl: spRdRepairWithSiliconeOilSegmentedControl )
                                         view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                             
                                             return view
                                      }()

    // subluxedCrystallineLens
    
                                         lazy var  subluxedCrystallineLensSegmentedControl : UISegmentedControl = {
                                                let sc = UISegmentedControl(items: ["No" , "Yes"])
                                                sc.selectedSegmentIndex = 0
                                                 sc.accessibilityIdentifier = subluxedCrystallineLensAccessIdentifier
                                                return sc
                                                
                                                
                                            }()
                                         
                                         lazy var subluxedCrystallineLensSegmentedView : UIView = {
                                                
                                                let view = inputContainerView(labelName: "Subluxed crystalline lens", segmentedControl: subluxedCrystallineLensSegmentedControl )
                                             view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                                 return view
                            
                                         }()
    
    // vitreousHemorrhage
    
                                                  lazy var  vitreousHemorrhageSegmentedControl : UISegmentedControl = {
                                                  let sc = UISegmentedControl(items: ["No" , "Yes"])
                                                  sc.selectedSegmentIndex = 0
                                                  sc.accessibilityIdentifier = vitreousHemorrhageAccessIdentifier
                                                  return sc
                                                  
                                                  
                                              }()
                                           
                                           lazy var vitreousHemorrhageSegmentedView : UIView = {
                                                  
                                                  let view = inputContainerView(labelName: "Vitreous Hemorrhage", segmentedControl: vitreousHemorrhageSegmentedControl )
                                             view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                                  
                                                   return view
                                           }()
    
    // retinal defect , NOS
    
                                                  lazy var  retinalDefectSegmentedControl : UISegmentedControl = {
                                                  let sc = UISegmentedControl(items: ["No" , "Yes"])
                                                  sc.selectedSegmentIndex = 0
                                                  sc.accessibilityIdentifier = retinalDefectAccessIdentifier
                                                  return sc
                                                  
                                                  
                                              }()
                                           
                                           lazy var retinalDefectSegmentedView : UIView = {
                                                  
                                                  let view = inputContainerView(labelName: "Retinal Defect,NOS", segmentedControl: retinalDefectSegmentedControl )
                                             view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                                                  
                                                   return view
                                           }()
    

  
//    @IBOutlet weak var headingImageView: UIImageView!
//    @IBOutlet weak var otherFielfTextField: UITextField!
//    
//    @IBOutlet weak var otherField2TextField: UITextField!
//    
//    @IBOutlet weak var otherField3TextField: UITextField!
//    
//    @IBOutlet weak var otherField4TextField: UITextField!
    
//    @IBOutlet weak var otherLabel4: UILabel!
//    @IBOutlet weak var otherLabel3: UILabel!
//    @IBOutlet weak var otherLabel2: UILabel!
//    @IBOutlet weak var otherLabel1: UILabel!
//    @IBOutlet weak var aphakiaSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var catractSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var fevrSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var fullThicknessMacularHoleSegmentedControl: UISegmentedControl!
//
//    @IBOutlet weak var diagnosisSegmentedControl: UISegmentedControl!
//
//    @IBOutlet weak var vitreousHemorrhage: UISegmentedControl!
//    @IBOutlet weak var endophthalmitisSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var floatersSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var epiretinalMembrane: UISegmentedControl!
//
//    @IBOutlet weak var choroidalEffusionSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var sublucedCrystallineLensSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var repairWithSiliconeOil: UISegmentedControl!
//    @IBOutlet weak var sickleCellSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var ropSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var maculaOnSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var retinalVeinOcclusionSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var MaculaOffSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var retinalTearSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var retainedLensFragmentSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var recurrentRdWithoutPVRSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var recurrentRdWithPVRSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var primaryRdWithPVRSelegmentedControl: UISegmentedControl!
//    @IBOutlet weak var latticeDegenerationSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var lamellarMacularSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var intraocularForeignBodySegmentedControll: UISegmentedControl!
//
//    @IBOutlet weak var pdrSegmentedControl: UISegmentedControl!
//    @IBOutlet weak var dislocatedIntraocularLens: UISegmentedControl!
//    @IBOutlet weak var diabeticTRD: UISegmentedControl!
//
//    @IBOutlet weak var choroidalHemorrhageSegmentedControl: UISegmentedControl!
//
//    @IBOutlet weak var otherFieldSegmentedControl: UISegmentedControl!
    
    
    // MARK:- Lifecycle
   
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light
        doneButtonForKeyboard()
        
        
         // Configure UI Function
         configureUI()
        
       
    }
    
    
   
     // MARK:- Helpers
        
    // For configuring the whole UI of the Page
       func configureUI(){
        
        backButton.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(handleHomeTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNextButtonTapped), for: .touchUpInside)
        addFieldButton.addTarget(self, action: #selector(handleAddFieldTapped), for: .touchUpInside)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(backButton)
       backButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 8, width: 26, height: 24)
       containerView.addSubview(titleLabel)
       titleLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor , paddingTop: 12, paddingLeft: 8,  height: 24)
        
        containerView.addSubview(homeButton)
        homeButton.anchor(top: containerView.topAnchor,right: containerView.rightAnchor , paddingTop: 6, paddingRight: 20 , width: 40, height: 40)
        
        let stackView1 = UIStackView(arrangedSubviews: [aphakiaSegmentedView , catractSegmentedView , choroidalEffusionSegmentedView , choroidalHemorrhageSegmentedView , diabeticTRDSegmentedView , dislocatedIntraocularLensSegmentedView , endophthalmitisSegmentedView , epiretinalMembraneSegmentedView , fevrSegmentedView  , fullThicknessMacularHoleSegmentedView , intraocularForeignBodySegmentedView , lamellarMacularHoleSegmentedView , latticeDegenerationSegmentedView , pdrSegmentedView , primaryRdWithPVRSegmentedView , recurrentRdWithPVRSegmentedView , recurrentRdWithoutPVRSegmentedView , retainedLensFragmentsPVRSegmentedView , retinalTearSegmentedView ,retinalDefectSegmentedView, retinalVeinOcclusionSegmentedView , rhegmatogenousRdMaculaOffSegmentedView, rhegmatogenousRdMaculaOnSegmentedView , ropSegmentedView, sickleCellSegmentedView , spRdRepairWithSiliconeOilSegmentedView , subluxedCrystallineLensSegmentedView , vitreousHemorrhageSegmentedView , floatersSegmentedView  ] )
        stackView1.spacing = 8
        stackView1.axis = .vertical
        stackView1.distribution = .fillProportionally
        
        containerView.addSubview(stackView1)
        stackView1.anchor(top: containerView.topAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 70,   paddingRight: 20  )
        // addFieldButton , otherFieldLabel1 , otherFieldLabel2 , otherFieldLabel3 , otherFieldLabel4 , nextButton
        containerView.addSubview(addFieldButton)
        addFieldButton.anchor(top: stackView1.bottomAnchor, left: containerView.leftAnchor,  paddingTop: 10, paddingLeft: 20, width: 100  )
        
        containerView.addSubview(otherFieldLabel1)
        otherFieldLabel1.anchor(top: addFieldButton.bottomAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20  )
        
        containerView.addSubview(otherFieldLabel2)
        otherFieldLabel2.anchor(top: otherFieldLabel1.bottomAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20  )
        
        containerView.addSubview(otherFieldLabel3)
        otherFieldLabel3.anchor(top: otherFieldLabel2.bottomAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20  )
        
        containerView.addSubview(otherFieldLabel4)
        otherFieldLabel4.anchor(top: otherFieldLabel3.bottomAnchor, left: containerView.leftAnchor,  right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20)
        
        containerView.addSubview(nextButton)
        nextButton.anchor(top: otherFieldLabel4.bottomAnchor,   right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 20,  paddingRight: 20 , width: 100)
        
       }
    
   
     // MARK:- Selectors
   
    @objc func handleAddFieldTapped() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiagnosisAddFieldViewController") as! DiagnosisAddFieldViewController
        vc.diagnosisAddField = self
        vc.txtField1 = otherFieldLabel1.text!
        vc.txtField2 = otherFieldLabel2.text!
        vc.txtField3 = otherFieldLabel3.text!
        vc.txtField4 = otherFieldLabel4.text!
        
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    // What happened when next button is tapped
      @objc func handleNextButtonTapped() {
        // to get the value from selegmented control
        //------------------------------------------------------------
       
       
        print("value in button", valueDemo)
        let aphakiaSeg = aphakiaSegmentedControl.titleForSegment(at: aphakiaSegmentedControl.selectedSegmentIndex)
       
        let catractSeg = catractSegmentedControl.titleForSegment(at: catractSegmentedControl.selectedSegmentIndex)
       
        let choroidalEffusionSeg = choroidalEffusionSegmentedControl.titleForSegment(at: choroidalEffusionSegmentedControl.selectedSegmentIndex)
       
        let choroidalHemorrhageSeg = choroidalHemorrhageSegmentedControl.titleForSegment(at: choroidalHemorrhageSegmentedControl.selectedSegmentIndex)
        
        let diabeticTRDSeg = diabeticTRDSegmentedControl.titleForSegment(at: diabeticTRDSegmentedControl.selectedSegmentIndex)
        
        let dislocatedIntraocularLensSeg = diabeticTRDSegmentedControl.titleForSegment(at:
            diabeticTRDSegmentedControl.selectedSegmentIndex)
       
        let endophthalmitisSeg = endophthalmitisSegmentedControl.titleForSegment(at: endophthalmitisSegmentedControl.selectedSegmentIndex)
        
        let epiretinalMembraneSeg = epiretinalMembraneSegmentedControl.titleForSegment(at: epiretinalMembraneSegmentedControl.selectedSegmentIndex)
        
        let  pdrSeg = pdrSegmentedControl.titleForSegment(at: pdrSegmentedControl.selectedSegmentIndex)
        
        let primaryRdWithPVRSeleg = primaryRdWithPVRSegmentedControl.titleForSegment(at: primaryRdWithPVRSegmentedControl.selectedSegmentIndex)
        
        let recurrentRdWithPVRSeg =
            recurrentRdWithPVRSegmentedControl.titleForSegment(at: recurrentRdWithPVRSegmentedControl.selectedSegmentIndex)
        
        let recurrentRdWithoutPVRSeg =
            recurrentRdWithoutPVRSegmentedControl.titleForSegment(at: recurrentRdWithoutPVRSegmentedControl.selectedSegmentIndex)
        
        let retainedLensFragmentSeg =
            retainedLensFragmentsSegmentedControl.titleForSegment(at: retainedLensFragmentsSegmentedControl.selectedSegmentIndex)
       
        let retinalTearSeg =
            retinalTearSegmentedControl.titleForSegment(at: retinalTearSegmentedControl.selectedSegmentIndex)
        
        let retinalVeinOcclusionSeg =
            retinalTearSegmentedControl.titleForSegment(at: retinalTearSegmentedControl.selectedSegmentIndex)
        
        let MaculaOffSeg = rhegmatogenousRdMaculaOffSegmentedControl.titleForSegment(at: rhegmatogenousRdMaculaOffSegmentedControl.selectedSegmentIndex)
       
        let MaculaOnSeg = rhegmatogenousRdMaculaOnSegmentedControl.titleForSegment(at: rhegmatogenousRdMaculaOnSegmentedControl.selectedSegmentIndex)
       
        let ropSeg = ropSegmentedControl.titleForSegment(at: ropSegmentedControl.selectedSegmentIndex)
       
        let sickleCellSeg = sickleCellSegmentedControl.titleForSegment(at: sickleCellSegmentedControl.selectedSegmentIndex)
        
        let repairWithSiliconeOilSeg = spRdRepairWithSiliconeOilSegmentedControl.titleForSegment(at: spRdRepairWithSiliconeOilSegmentedControl.selectedSegmentIndex)
        
        let sublucedCrystallineLensSeg = subluxedCrystallineLensSegmentedControl.titleForSegment(at: subluxedCrystallineLensSegmentedControl.selectedSegmentIndex)
        
        let vitreousHemorrhageSeg = vitreousHemorrhageSegmentedControl.titleForSegment(at: vitreousHemorrhageSegmentedControl.selectedSegmentIndex)
        
        let fevrSeg = fevrSegmentedControl.titleForSegment(at: fevrSegmentedControl.selectedSegmentIndex)
        
        let floatersSeg = floatersSegmentedControl.titleForSegment(at: floatersSegmentedControl.selectedSegmentIndex)
        
        let fullThicknessMacularHoleSeg = fullThicknessMacularHoleSegmentedControl.titleForSegment(at: fullThicknessMacularHoleSegmentedControl.selectedSegmentIndex)
        
        let intraocularForeignBodySeg =
            intraocularForeignBodySegmentedControl.titleForSegment(at: intraocularForeignBodySegmentedControl.selectedSegmentIndex)
        
        let lamellarMacularSeg = lamellarMacularHoleSegmentedControl.titleForSegment(at: lamellarMacularHoleSegmentedControl.selectedSegmentIndex)
        
        let latticeDegenerationSeg = latticeDegenerationSegmentedControl.titleForSegment(at: latticeDegenerationSegmentedControl.selectedSegmentIndex)
          let retinalDefectSeg = retinalDefectSegmentedControl.titleForSegment(at: retinalDefectSegmentedControl.selectedSegmentIndex)
        
        //------------------------------------------------------------
        
        let of1 = otherFieldLabel1.text!
        let of2 = otherFieldLabel2.text!
        let of3 = otherFieldLabel3.text!
        let of4 = otherFieldLabel4.text!
        
        
        
        
        //--------------------------------------------------------
        
        
        
        // setting the values to the model
        let demographics2Info = Demographics2Model(personIdFromDemo1:valueDemo,aphakia: aphakiaSeg, cataract: catractSeg, choroidalEffusion: choroidalEffusionSeg, choroidalHemorrhage: choroidalHemorrhageSeg, diabeticTrd: diabeticTRDSeg, dislocatedIntraocularLens: dislocatedIntraocularLensSeg, endophthalmitis: endophthalmitisSeg, epiretinalMembrane: epiretinalMembraneSeg, fevr: fevrSeg, floaters: floatersSeg, fullThicknessMacularHole: fullThicknessMacularHoleSeg, intraocularForeignBody: intraocularForeignBodySeg , lamellarMacularHole: lamellarMacularSeg, latticeDegeneration: latticeDegenerationSeg, pdr: pdrSeg, primaryRdWithPvr: primaryRdWithPVRSeleg, recurrentRdWithPvr: recurrentRdWithPVRSeg, recurrentRdWithOutPvr: recurrentRdWithoutPVRSeg, retainedLensFragments: retainedLensFragmentSeg, retinalTear: retinalTearSeg, retinalVeinOcclusion: retinalVeinOcclusionSeg, rhegmatogenousRdMaculaOff: MaculaOffSeg, rhegmatogenousRdMaculaOn: MaculaOnSeg, rop: ropSeg, sickleCell: sickleCellSeg, spRdRepairWithSiliconeOil: repairWithSiliconeOilSeg , subluxedCrystallineLens: sublucedCrystallineLensSeg, vitreousHemorrhage: vitreousHemorrhageSeg , retinalDefect: retinalDefectSeg ,otherField: of1,otherField2: of2, otherField3: of3, otherField4: of4,status: 0)
        
        // DataBase Work insertion
        //
      //  DatabaseManager.shared.createDemographics2Table()
        let inserted = DatabaseManager.shared.insertDemographics2Data(demographics2Info)
        print(inserted)
        
       
        
        DispatchQueue.main.async {
              let vc = Surgery_ViewController()
                   
                    vc.modalPresentationStyle = .fullScreen
            vc.valuesurg = self.valueDemo
            vc.mrnTemp = self.mrnTemp
            vc.unloggedCaseId = self.unloggedCaseId
            self.present(vc, animated: true, completion: nil)
        
       
               //---------------------------------------------------------------
              //---------------------------------------      -------------------
    }
    

    }
    
    
    @objc func handleHomeTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: true)
        }
    
    
        @objc func handleBackTapped() {
        let deleted = DatabaseManager.shared.deleteDemographicsTempDataWhenBactPressedAtDiagnosis(withID: valueDemo)
        print("deleted is " , deleted)
         dismiss(animated: true, completion: nil)
        //
    }
    
      // done button on keyboard appears by this code
      // done button for keyboard
    func doneButtonForKeyboard(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        
       
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
  
 
    
}

@available(iOS 13.0, *)
extension Demographics2_ViewController : DiagnosisAddField  {
    func addFieldValue(textField1: String, textField2: String, textField3: String, textField4: String) {
        otherFieldLabel1.text = textField1
        otherFieldLabel2.text = textField2
        otherFieldLabel3.text = textField3
        otherFieldLabel4.text = textField4
        
    }
    
    
}


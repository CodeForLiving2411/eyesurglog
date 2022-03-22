//
//  extension.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 14/10/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red : CGFloat , green: CGFloat , blue : CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
}

extension UIView {
    // Container with image, textField , seperator
    @available(iOS 13.0, *)
    func inputContainerView(labelName: String , segmentedControl : UISegmentedControl) -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
       // label.backgroundColor = .red
        
        label.numberOfLines = 2
        label.text = labelName
        view.addSubview(label)
        
        var segControl = UISegmentedControl(items: ["No", "Yes"])
        segControl = segmentedControl
        segControl.tintColor = .link
        segControl.selectedSegmentIndex = 0
        segControl.backgroundColor = .link
        
        label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 5, paddingLeft: 20, width: 150, height: 30)
        view.addSubview(segmentedControl)
        segmentedControl.anchor( left: label.rightAnchor,  right: view.rightAnchor,  width: 81, height: 31)
        segmentedControl.centerY(inView: view)
   
         return view
    }
    
    @available(iOS 13.0, *)
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
           segControl.tintColor = .link
           segControl.selectedSegmentIndex = 0
           segControl.backgroundColor = .link
           label.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 0, width: 150 , height: 30)
           view.addSubview(segControl)
        if items.count == 2  {
            width = 81
        }
            else if items.count == 3 {
            width = 121
        }  else if items.count == 4 {
            width = 160
               }
        else if items.count == 5 {
             width = 200
        }
        
        segmentedControl.anchor( left: label.rightAnchor,  width: width ,height: 31)
           segmentedControl.centerY(inView: view)
      
            return view
       }
    
    // imageButton
       func imageButton(image : UIImage , title : String) -> UIView{
           let view = UIView()
           
           let imageView = UIImageView()
           imageView.image = image
           imageView.alpha = 0.87
           view.addSubview(imageView)
           imageView.centerY(inView: view)
           imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 40, height: 40)
        
           let label = UILabel()
           label.text = title
           label.font = UIFont(name: "Avenir-Light", size: 16)
           label.textColor = UIColor.rgb(red: 0, green: 100, blue: 0)
           
           label.lineBreakMode = NSLineBreakMode.byWordWrapping
           label.numberOfLines = 0
           label.font = UIFont.boldSystemFont(ofSize: 16.0)
           view.addSubview(label)
        
           label.anchor(left: imageView.rightAnchor, paddingLeft: 8, height: 40)
           imageView.centerY(inView: label)
         //  view.backgroundColor = .green
           
        
           return view
       }
    // For setting corner radius Of any View
    func setBorder(radius:CGFloat, color:UIColor = UIColor.clear) -> UIView{
        var roundView:UIView = self
        roundView.layer.cornerRadius = CGFloat(radius)
        roundView.layer.borderWidth = 0.1
        roundView.layer.borderColor = color.cgColor
        roundView.clipsToBounds = true
        
        return roundView
    }
    
    
    
   
    
    func anchor(top : NSLayoutYAxisAnchor? = nil ,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil ,
                paddingTop: CGFloat = 0,
                paddingLeft : CGFloat = 0,
                paddingBottom:CGFloat = 0,
                paddingRight:CGFloat = 0,
                width:CGFloat? = nil,
                height: CGFloat? = nil ){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left , constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom , constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right , constant:  -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    // Center your element respect to your View
    func centerX(inView view : UIView){
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view : UIView , leftAnchor : NSLayoutXAxisAnchor? = nil, paddingLeft : CGFloat = 0 , rightAnchor : NSLayoutXAxisAnchor? = nil , paddingRight : CGFloat = 0  ){
        translatesAutoresizingMaskIntoConstraints = false
           centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let left = leftAnchor {
                   anchor(left: left, paddingLeft: paddingLeft)
               }
       
    
    if let right = leftAnchor {
                      anchor(right: right, paddingRight: paddingRight)
                  }
          }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
           translatesAutoresizingMaskIntoConstraints = false
           heightAnchor.constraint(equalToConstant: height).isActive = true
           widthAnchor.constraint(equalToConstant: width).isActive = true
       }
       
       
    // MARK :- Card Views
    //-------------------------------------------------------
    func addShadow() {
           layer.shadowColor = UIColor.lightGray.cgColor
           layer.shadowOpacity = 1
           layer.shadowOffset = .zero
           layer.shadowRadius = 5
       }
    
        func cardView(){
         backgroundColor = UIColor.white
         layer.shadowColor = UIColor.lightGray.cgColor
         layer.shadowOpacity = 1
         layer.shadowOffset = CGSize.zero
         layer.cornerRadius = CGFloat(7)
         layer.shadowRadius = 7
               
    }
    func addViewShadow(){
        
        //backgroundColor = UIColor.yellow
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 7
    }
    
     //-------------------------------------------------------
    
    
    
    

}

extension UITextField {
    func textField(withPlaceholder placeholder : String , isSecureTextEntry : Bool) -> UITextField{
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .black
        tf.keyboardAppearance = .dark
        tf.isSecureTextEntry = isSecureTextEntry
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
       return tf
        
    }
}

// Hieght of navigation + status bar
//extension UIViewController {
//
//    /**
//     *  Height of status bar + navigation bar (if navigation bar exist)
//     */
//
//    var topbarHeight: CGFloat {
//        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
//            (self.navigationController?.navigationBar.frame.height ?? 0.0)
//    }
//}





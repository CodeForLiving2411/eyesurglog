//
//  EyeFundusDrawingViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 03/06/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit

protocol ImageDelagate {
    
    func getImage (image : UIImage , commentData : String)
    
}



class EyeFundusDrawingViewController: UIViewController {

       var imageid = 0
       var imageDelagate : ImageDelagate?
       @IBOutlet weak var canvasView: CanvasView!
       @IBOutlet var featuresView: UIView!
       @IBOutlet weak var collectionView: UICollectionView!
       @IBOutlet weak var btnArrow: UIButton!
       
       @IBOutlet weak var widthSlider: UISlider!
       @IBOutlet weak var opacitySlider: UISlider!
    
  
    
       
       var blurView = UIVisualEffectView()
       
       var kHeight: CGFloat = 130 // Total height of feature view
       var animationTime = 0.35
       
    var colorsArray: [UIColor] = [ .black, .brown , .red , .yellow , .green ,.blue ]
    
    
   
       
       override func viewDidLoad() {
           super.viewDidLoad()
        
         //  canvasView.strokeWidth = 1
         //  widthSlider.setThumbImage(#imageLiteral(resourceName: "brush"), for: .normal)
          // opacitySlider.setThumbImage(#imageLiteral(resourceName: "opacity"), for: .normal)
        
        print("image id for eye ", imageid)
        print("frame size" , self.view.frame.size)
        
        if imageid == 1  {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "eyeLeftNew.png")?.draw(in: self.canvasView.bounds)
            
        }
        else {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "eyeRightNew.png")?.draw(in: self.canvasView.bounds)
        }
       

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.canvasView.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }
           opacitySlider.tintColor = .systemBlue
           featuresView.transform = CGAffineTransform(translationX: 0, y: kHeight - (kHeight - 80))
           
       }
    
    
    @IBAction func WhenDoneButtonIsPressed(_ sender: UIButton) {
        let modifiedDiagramImage = UIImage(view : self.canvasView)
        
        var commentText = ""
        
        imageDelagate?.getImage(image: modifiedDiagramImage , commentData: commentText  )
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
       @IBAction func onClickHideShowFeatureView(_ sender: UIButton) {
           if sender.isSelected {
               UIView.animate(withDuration: animationTime) {
                   sender.isSelected = false
                   self.btnArrow.setBackgroundImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
                   self.featuresView.transform = CGAffineTransform(translationX: 0, y: self.kHeight - (self.kHeight - 80))
               }
           } else {
               UIView.animate(withDuration: animationTime) {
                   sender.isSelected = true
                   self.btnArrow.setBackgroundImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
                   self.featuresView.transform = CGAffineTransform.identity
               }
           }
           
       }
       @IBAction func onClickBrushWidth(_ sender: UISlider) {
           canvasView.strokeWidth = CGFloat(sender.value)
       }
       
       @IBAction func onClickOpacity(_ sender: UISlider) {
           canvasView.strokeOpacity = CGFloat(sender.value)
       }
       
       @IBAction func onClickClear(_ sender: Any) {
           canvasView.clearCanvasView()
       }
       @IBAction func onClickUndo(_ sender: Any) {
           canvasView.undoDraw()
       }
    // can be implemented Later 
//       @IBAction func onClickSave(_ sender: Any) {
////          let image = canvasView.takeScreenshot()
////           UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextType:)), nil)
//
//       }
       
       @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
           if let error = error {
               // we got back an error!
               let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "OK", style: .default))
               present(ac, animated: true)
           } else {
               let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "OK", style: .default))
               present(ac, animated: true)
           }
       }
   }

   extension EyeFundusDrawingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return colorsArray.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
           if let view = cell.viewWithTag(111) {
               view.layer.cornerRadius = 3
               view.backgroundColor = colorsArray[indexPath.row]
           }
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let color = colorsArray[indexPath.row]
           canvasView.strokeColor = color
       }
       
   }


   extension UIView {

       func takeScreenshot() -> UIImage {

           // Begin context
           UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

           // Draw view in that context
           drawHierarchy(in: self.bounds, afterScreenUpdates: true)

           // And finally, get image
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           if (image != nil)
           {
               return image!
           }
           return UIImage()
       }

       
    }


extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
    

    



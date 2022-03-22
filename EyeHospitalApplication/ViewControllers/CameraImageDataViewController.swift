//
//  CameraImageDataViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 19/12/19.
//  Copyright © 2019 abhishek dwivedi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class CameraImageDataViewController: UIViewController {
    var imageDetailsList : [Any] = []
   // var imagePath1 = ""
    var uniqueId = 0
    var mrn = ""
    
    @IBOutlet weak var commentTextView: UITextView!
    
    
   var documentsUrl: URL {
         return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
     }
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        imageDetailsList = DatabaseManager.shared.loadCameraImageDetails(withID: uniqueId)
               print(" imageDetailsList", imageDetailsList)
               imageDetailsList.remove(at: 0)
               print("list after removing" , imageDetailsList)
         let imagePath1 = imageDetailsList[0] as! String
         mrn  = imageDetailsList[1] as! String
        
        commentTextView.text! = imageDetailsList[2] as! String
        
        getImage(imagePath1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         overrideUserInterfaceStyle = .light    
      //  getImage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func WhenBackButtonPressed(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    func getImage(_ fileName : String){
      
        
        let fileURL = documentsUrl.appendingPathComponent(fileName)
           do {
               let imageData = try Data(contentsOf: fileURL)
               self.cameraImageView.image = UIImage(data: imageData)
           } catch {
               print("Error loading image : \(error)")
           }
          
    }
    

    @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               vc.modalPresentationStyle = .fullScreen
                   self.present(vc, animated: true)
    }
    
    @IBAction func WhenEditButtonWasPressed(_ sender: UIButton) {
          
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditCameraViewController") as! EditCameraViewController
           vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true, completion: nil)
       // vc.imagePath = imagePath1
        vc.imageid = uniqueId
        vc.mrnTemp = Int(mrn)!

}

}

//
//  EditCameraViewController.swift
//  EyeHospitalApplication
//
//  Created by abhishek dwivedi on 25/07/20.
//  Copyright © 2020 abhishek dwivedi. All rights reserved.
//

import UIKit



 import UIKit
 import IHKeyboardAvoiding
 @available(iOS 13.0, *)
 class EditCameraViewController: UIViewController,
  UINavigationControllerDelegate,
 UIImagePickerControllerDelegate{

     @IBOutlet weak var imageView: UIImageView!
     @IBOutlet weak var leftEyeImageView: UIImageView!
     @IBOutlet weak var rightEyeImageView: UIImageView!
   
    @IBOutlet weak var commentTextCamera: UITextView!
    var imageid = 0
     var mrnTemp = 0
     var imageName = ""
     var commentString = ""
   //  var imagePath = ""
     
 
    // For getting document directory relative path
   
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

     
     @IBOutlet weak var saveImageToPhotoGallery: UIButton!
     override func viewWillAppear(_ animated: Bool) {
       //   KeyboardAvoiding.avoidingView = self.avoidingView
       // print("at view will appear" , imagePath)
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         doneButtonForKeyboard()
          overrideUserInterfaceStyle = .light
         saveImageToPhotoGallery.isHidden = true
        commentTextCamera.isEditable = false 
         
         // UI Tap Gesture for the left Eye
         let leftEyeTapGesture = UITapGestureRecognizer(target: self, action: #selector(WhenLeftEyeImageViewWasPressed))
             leftEyeImageView.addGestureRecognizer(leftEyeTapGesture)
         
          // UI Tap Gesture for the right Eye
         let rightEyeTapGesture = UITapGestureRecognizer(target: self, action: #selector(WhenRightEyeImageViewWasPressed))
                rightEyeImageView.addGestureRecognizer(rightEyeTapGesture)
         

       
     }
     
      // When the Left Eye is pressed
     @objc func WhenLeftEyeImageViewWasPressed() {
         
         print("Left Eye  Pressed")
         
         let vc = storyboard?.instantiateViewController(identifier: "EyeFundusDrawingViewController") as! EyeFundusDrawingViewController
         vc.modalPresentationStyle = .fullScreen
         vc.imageid = 1
         vc.imageDelagate = self
         self.present(vc, animated: true, completion: nil)
     }
      // When the Right Eye is pressed
     @objc func WhenRightEyeImageViewWasPressed() {
             print(" Right Eye  Pressed")
         
         let vc = storyboard?.instantiateViewController(identifier: "EyeFundusDrawingViewController") as! EyeFundusDrawingViewController
                vc.modalPresentationStyle = .fullScreen
         vc.imageid = 2
         vc.imageDelagate = self
                self.present(vc, animated: true, completion: nil)
        }
     

     @IBAction func ChooseFromLibraryButton(_ sender: UIButton) {
         
         let imagePickerFromLibrary = UIImagePickerController()
         imagePickerFromLibrary.delegate = self
         imagePickerFromLibrary.sourceType = UIImagePickerController.SourceType.photoLibrary
         imagePickerFromLibrary.allowsEditing = true
         self.present(imagePickerFromLibrary,animated: true, completion: nil)
         

     }
     
     
     
     
    
     @IBAction func WhenSaveImageToPhotoLibraryWasPressed(_ sender: Any) {
          UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
         
     }
     @IBAction func OpenCameraButtonWasPressed(_ sender: UIButton) {
        
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self
             imagePicker.sourceType = UIImagePickerController.SourceType.camera
             imagePicker.allowsEditing = true
             self.present(imagePicker, animated: true, completion: nil)
        
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         self.imageView.image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage
         if imageView.image != nil {
             imageName = "img\(imageid)mrn\(mrnTemp)"
             saveImageToPhotoGallery.isHidden = false
             
         }
            self.dismiss(animated: true, completion: nil)
            
        }
     
 //    //MARK: - Add image to Library
 //       @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
 //           if let error = error {
 //               // we got back an error!
 //               showAlertWith(title: "Save error", message: error.localizedDescription)
 //           } else {
 //               showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
 //           }
 //       }
    
     
     
 //    @IBAction func WnenInstructionToUseButtonWasPressed(_ sender: UIButton) {
 //
 //        var messageToDisplay = "1. To open an image from gallery please click /"   "
 //
 //        let alertController = UIAlertController(title: "Instructions to use",
 //                                                          message: messageToDisplay, preferredStyle: .alert)
 //
 //                  let OKAction = UIAlertAction(title : "Ok", style : .default){
 //                      (action :UIAlertAction) in
 //
 //                      //
 //
 //
 //                  }
 //                  alertController.addAction(OKAction)
 //                  self.present(alertController, animated: true,completion: nil)
 //
 //
 //    }
     @IBAction func WhenCameraViewControllerNextButtonWasPressed(_ sender: UIButton) {
         print("value of person id at camera viewcontroller  is" , imageid)

        removeImageLocalPath(filename: imageName)

        var imagePath =  saveToDocuments(filename: imageName)
        print("image path" , imagePath)
        
      
//
//
//
        let updated = DatabaseManager.shared.UpdateCameraImagePathAfterEding(imageid, imagePath , comment: commentString)
         print("updated" , updated )
        
        dismiss(animated: true, completion: nil)

         
         
         /// performSegue(withIdentifier: "cameratocaselog", sender: self)
         
     }
     
     @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
         if let error = error {
             let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "OK", style: .default))
             present(ac, animated: true)
         } else {
             let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "OK", style: .default))
             present(ac, animated: true)
         }
     }

     
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           let vc = segue.destination as! EyeProcedureViewController
//         vc.personUID = imageid
//       }
//
     
     @IBAction func WhenBackButtonWasPressed(_ sender: UIButton) {
      
        let deleted = DatabaseManager.shared.deleteSurgeryTempDataWhenBactPressedAtCameraVC(withID: imageid)
                  print("deleted is" , deleted)
                  dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
   
    }
    
    // function to remove images from documents directory
    func removeImageLocalPath(filename:String) {
               let filemanager = FileManager.default
               let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
               let destinationPath = documentsPath.appendingPathComponent(filename)
    do {
           try filemanager.removeItem(atPath: destinationPath)
           print("Local path removed successfully")
       } catch let error as NSError {
           print("------Error",error.debugDescription)
       }
       }
    
    
    // function to save image in documrnt directory
     func saveToDocuments(filename:String) -> String {
        
       let fileURL = documentsUrl.appendingPathComponent(filename)
             if let imageData = imageView.image!.jpegData(compressionQuality: 1.0) {
                   try? imageData.write(to: fileURL, options: .atomic)
                   print(" Image saved succesfully")
                   return filename // ----> Save fileName
                }
             else {
                print("Error saving image")
                
             }
             return filename
         }
     
     // done button for keyboard
       func doneButtonForKeyboard(){
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
           
           
           toolbar.setItems([flexibleSpace,doneButton], animated: false)
           
          // imageNameTextField.inputAccessoryView = toolbar
 //          loginPasswordTextField.inputAccessoryView = toolbar
       }
       
       @objc func doneClicked(){
           view.endEditing(true)
         
         
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
     
     
     @IBAction func WhenHomeButtonWasPressed(_ sender: UIButton) {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                          vc.modalPresentationStyle = .fullScreen
                          self.present(vc, animated: true)
         }
     
     
     
     }
 @available(iOS 13.0, *)
extension EditCameraViewController : ImageDelagate {
   
    
     func getImage(image: UIImage , commentData: String ) {
         self.imageView.image = image
         
         if self.imageView.image != nil {
                    imageName = "img\(imageid)mrn\(mrnTemp)"
                    saveImageToPhotoGallery.isHidden = false
     }
         else {
             print("image is nil")
         }
        self.commentString = commentData
        
        commentTextCamera.text! = commentData
        
 }

 }


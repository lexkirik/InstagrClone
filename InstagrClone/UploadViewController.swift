//
//  UploadViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit
import Photos
import PhotosUI
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    var popup = Popup()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func chooseImage() {
        var imageCongiguration = PHPickerConfiguration(photoLibrary: .shared())
        imageCongiguration.selectionLimit = 1
        imageCongiguration.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let imagePicker = PHPickerViewController(configuration: imageCongiguration)
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
        // imagePicker using .photoLibrary will be deprecated soon
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
    }
    
    // imagePicker using .photoLibrary will be deprecated soon
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imageView.image = info[.originalImage] as? UIImage
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {return}
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
//                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "publc.image") { <#URL?#>, <#Error?#> in
//                    <#code#>
//                }
            }
        }
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        view.addSubview(popup)
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { url, error in
                        
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            //database
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference: DocumentReference? = nil
                            let firestorePost = ["imageURL" : imageURL!, "postedBy" : Auth.auth().currentUser!.email!, "postComent" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(named: "upload.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    self.popupClose()
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
    @objc func popupClose() {
        popup.removeFromSuperview()
    }

    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

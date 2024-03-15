//
//  ImageLoader.swift
//  InstagrClone
//
//  Created by Test on 15.03.24.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageLoader: UIViewController {
    var popup = PopupUploadView()
    var imageView = UIImageView()
    var commentText = UITextField()

    let mediaFolder = Storage.storage().reference().child("media")
    
    func upload() {
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
                                    self.imageView.image = UIImage(named: "single.png")
                                    self.commentText.text = ""
                                }
                            })
                            self.popupClose()
                        }
                    }
                }
            }
        }
    }
    
        func makeAlert(titleInput: String, messageInput: String) {
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
        }
    
    func popupClose() {
        popup.removeFromSuperview()
    }
}

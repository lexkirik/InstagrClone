//
//  ImageLoader.swift
//  InstagrClone
//
//  Created by Test on 15.03.24.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageLoader: ImageLoaderProtocol {
    internal var imageReference = Storage.storage().reference().child("media").child("\(UUID().uuidString).jpg")
    internal var firestoreDatabase = Firestore.firestore()
    internal var firestoreReference: DocumentReference? = nil
    
    func composePost(data: Data, postedBy: String, postComment: String, date: FieldValue, likes: Int, completion finish: (Bool) -> () = {_ in })  {
    
                imageReference.putData(data, metadata: nil) { metadata, error in
    
                    if error != nil {
                        self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    } else {
                        self.imageReference.downloadURL { url, error in
                            if error == nil {
                                let imageURL = url!.absoluteString
                                let keys = [FirestorePost.imageURL, FirestorePost.postedBy, FirestorePost.postComment, FirestorePost.date, FirestorePost.likes]
                                let values = [imageURL, postedBy, postComment, date, likes] as [Any]
                                let seg = zip(keys, values)
                                let post = Dictionary(seg, uniquingKeysWith: {return $1})
    
                                var firestoreReference = self.firestoreReference
                                firestoreReference = self.firestoreDatabase.collection("Posts").addDocument(data: post, completion: { _ in
    
                                })
                            }
                        }
                    }
                }
            }
        
    
//    func composePost(image: UIImage, postedBy: String, postComment: String, date: FieldValue, likes: Int, completion: (Bool) -> () = {_ in })  {
//    
//        let image = UIImageView().image
//        if let data = image?.jpegData(compressionQuality: 0.5) {
//
//            imageReference.putData(data, metadata: nil) { metadata, error in
//                
//                if error != nil {
//                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
//                } else {
//                    self.imageReference.downloadURL { url, error in
//                        if error == nil {
//                            let imageURL = url!.absoluteString
//                            let keys = [FirestorePost.imageURL, FirestorePost.postedBy, FirestorePost.postComment, FirestorePost.date, FirestorePost.likes]
//                            let values = [imageURL, postedBy, postComment, date, likes] as [Any]
//                            let seg = zip(keys, values)
//                            let post = Dictionary(seg, uniquingKeysWith: {return $1})
//                            
//                            var firestoreReference = self.firestoreReference
//                            firestoreReference = self.firestoreDatabase.collection("Posts").addDocument(data: post, completion: { error in
//                                
//                            })
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    private enum FirestorePost {
        static var imageURL = "imageURL"
        static var postedBy = "postedBy"
        static var postComment = "postComent"
        static var date = "date"
        static var likes = "likes"
    }
    
    private func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
    }
    }

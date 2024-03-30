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
    private let imageReference = Storage.storage().reference().child("media").child("\(UUID().uuidString).jpg")
    private let firestoreDatabase = Firestore.firestore()
    private var firestoreReference: DocumentReference? = nil
    
    func composePost(data: Data, postedBy: String, postComment: String, date: FieldValue, likes: Int, completion:  @escaping (_ result: ImageLoaderResult) -> ())  {
    
                imageReference.putData(data, metadata: nil) { metadata, error in
    
                    if error != nil {
                        completion(.error(.failedPuttingDataToFirebase))
                    } else {
                        self.imageReference.downloadURL { url, error in
                            if error == nil {
                                let imageURL = url!.absoluteString
                                let keys = [FirestorePost.imageURL, FirestorePost.postedBy, FirestorePost.postComment, FirestorePost.date, FirestorePost.likes]
                                let values = [imageURL, postedBy, postComment, date, likes] as [Any]
                                let seg = zip(keys, values)
                                let post = Dictionary(seg, uniquingKeysWith: {return $1})
    
                                self.firestoreReference = self.firestoreDatabase.collection("Posts").addDocument(data: post, completion: { _ in
                                    if error != nil {
                                        completion(.error(.failedDownloadingDataFromFirebase))
                                    } else {
                                        completion(.success(.success))
                                    }
                                })
                            } else {
                                completion(.error(.failedComposingDataAsPost))
                            }
                        }
                    }
                }
            }

    private enum FirestorePost {
        static var imageURL = "imageURL"
        static var postedBy = "postedBy"
        static var postComment = "postComent"
        static var date = "date"
        static var likes = "likes"
    }
    

    }

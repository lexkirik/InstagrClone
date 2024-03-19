//
//  File.swift
//  InstagrClone
//
//  Created by Test on 19.03.24.
//

import Foundation
import Firebase
import FirebaseStorage

protocol ImageLoaderProtocol {
    
    var imageReference: StorageReference {get}
    var firestoreDatabase: Firestore {get}
    func setPost(imageURL: String, postedBy: String, postComment: String, date: FieldValue, likes: Int) -> [String : Any]
}

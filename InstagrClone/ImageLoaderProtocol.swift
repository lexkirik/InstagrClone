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
    
    func composePost(data: Data, postedBy: String, postComment: String, date: FieldValue, likes: Int, completion:  @escaping (_ error: ImageLoaderError) -> ())
}

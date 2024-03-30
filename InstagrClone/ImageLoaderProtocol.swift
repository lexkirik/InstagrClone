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
    
    func composePost(data: Data, postedBy: String, postComment: String, date: FieldValue, likes: Int, completion:  @escaping (_ error: ImageLoaderResult) -> ())
}

enum ImageLoaderResult: Error, Equatable {
    case success (ImageLoaderSuccess)
    case error (ImageLoaderError)
    
    enum ImageLoaderError: LocalizedError {
        
        case failedPuttingDataToFirebase
        case failedDownloadingDataFromFirebase
        case failedComposingDataAsPost
        case unknown
        
        var errorDescription: String {
            switch self {
            case .failedComposingDataAsPost:
                return NSLocalizedString("Failed to compose post", comment: "Failed to compose data as a post in Firebase")
            case .failedPuttingDataToFirebase:
                return NSLocalizedString("Failed to put data", comment: "Failed to put data to Firebase")
            case .failedDownloadingDataFromFirebase:
                return NSLocalizedString("Failed to download data", comment: "Failed to download data from Firebase")
            case .unknown:
                return NSLocalizedString("Unknown error", comment: "Unknown error with uploading data")
            }
        }
    }
    
    enum ImageLoaderSuccess: LocalizedError {
        case success
        
        var resultDescription: Any {
            switch self {
                case .success:
                    return true
            }
        }
    }
}

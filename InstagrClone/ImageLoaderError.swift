//
//  ImageLoaderError.swift
//  InstagrClone
//
//  Created by Test on 25.03.24.
//

import Foundation

enum ImageLoaderError: LocalizedError {
    
    case failedPuttingDataToFirebase
    case failedDownloadingDataFromFirebase
    case failedComposingDataAsPost
    case noError
    case unknown
    
    var errorDescription: Any {
        switch self {
        case .failedPuttingDataToFirebase:
            return NSLocalizedString("Failed to put data", comment: "Failed to put data to Firebase")
        case .failedDownloadingDataFromFirebase:
            return NSLocalizedString("Failed to download data", comment: "Failed to download data from Firebase")
        case .failedComposingDataAsPost:
            return NSLocalizedString("Failed to compose post", comment: "Failed to compose data as a post in Firebase")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error with uploading data")
        case .noError:
            return true
        }
    }
}

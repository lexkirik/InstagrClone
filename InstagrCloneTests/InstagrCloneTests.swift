//
//  InstagrCloneTests.swift
//  InstagrCloneTests
//
//  Created by Test on 19.03.24.
//

import XCTest
import Foundation
import Firebase
import FirebaseStorage

@testable import InstagrClone

final class InstagrCloneTests: XCTestCase {

    var imageLoader: ImageLoader!
    override func setUpWithError() throws {
        try super.setUpWithError()
        imageLoader = ImageLoader()
    }

    override func tearDownWithError() throws {
        imageLoader = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        var post: () = imageLoader.composePost(data: <#Data#>, postedBy: "", postComment: "", date: FieldValue.serverTimestamp(), likes: 1) { error in
            
        }
        XCTAssertNoThrow(post)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            imageLoader.composePost(data: <#Data#>, postedBy: "", postComment: "", date: FieldValue.serverTimestamp(), likes: 1) { error in
                <#code#>
            }
        }
    }

}

//
//  LoadImageServiceTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest
import RxBlocking

class LoadImageServiceTest: XCTestCase {
    let thumbnailUrl = "https://search1.kakaocdn.net/argon/130x130_85_c/1kBkYCiT9Qx"

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadImage() throws {
        let bundle = Bundle(for: self.classForCoder)
        let thumbnailImage = UIImage(named: "thumbnail.png", in: bundle, with: nil)
        
        let image =  try! LoadImageService.loadImage(from: thumbnailUrl).toBlocking().first()!
        
        XCTAssertEqual(image?.pngData(), thumbnailImage?.pngData())
    }
    
    
    func testLoadImageNullImage() throws {
        let wrongUrl = "https://search1.kakaocdn.net/argon/130x130_85_/1kBkYCiT9Qx"
        
        let image =  try! LoadImageService.loadImage(from: wrongUrl).toBlocking().first()!
        
        XCTAssertNil(image)
    }

}

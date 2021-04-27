//
//  ServiceAPITest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest

class ServiceAPITest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    
    func testUrlString() throws {
        let expectStrirng1 = "https://dapi.kakao.com/v2/search/blog"
        let expectStrirng2 = "https://dapi.kakao.com/v2/search/cafe"
        
        let blogUrl = ServiceAPI.blog.urlString
        let cafeUrl = ServiceAPI.cafe.urlString
        
        XCTAssertEqual(blogUrl, expectStrirng1)
        XCTAssertEqual(cafeUrl, expectStrirng2)
    }

}

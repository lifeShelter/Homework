//
//  FilterEnumTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest

class FilterEnumTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testInit() throws {
        let expectAll = FilterEnum.all
        let expectBlog = FilterEnum.blog
        let expectCafe  = FilterEnum.cafe
        let expectDefault = FilterEnum.all
        
        let testAll = FilterEnum(rawValue: "All")
        let testBlog = FilterEnum(rawValue: "Blog")
        let testCafe = FilterEnum(rawValue: "Cafe")
        let testDefault = FilterEnum(rawValue: "blog")
        
        
        XCTAssertEqual(testAll, expectAll)
        XCTAssertEqual(testBlog, expectBlog)
        XCTAssertEqual(testCafe, expectCafe)
        XCTAssertEqual(testDefault, expectDefault)
    }

}

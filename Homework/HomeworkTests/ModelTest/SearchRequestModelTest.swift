//
//  SearchRequestModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest

class SearchRequestModelTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testInit() throws {
        let query = "검색어"
        var expect = SearchRequestModel(query)
        expect.sort = "accuracy"
        expect.page = 1
        expect.size = 25
        var expect2 = expect
        expect2.page = 2
        
        let result = SearchRequestModel(query)
        
        XCTAssertEqual(result, expect)
        XCTAssertEqual(result.hashValue, expect.hashValue)
        XCTAssertNotEqual(result, expect2)
        XCTAssertEqual(result.hashValue, expect2.hashValue)
    }
    
    
    func testParameter() throws {
        let query = "검색어"
        let expectDic:[String : Any] = ["query":query,"sort":"accuracy","page":1,"size":25]
        let expectQuery = expectDic["query"] as? String
        let expectSort = expectDic["sort"] as? String
        let expectPage = expectDic["page"] as? Int
        let expectSize = expectDic["size"] as? Int
        
        let result = SearchRequestModel(query).parameters
        let resultQuery = result["query"] as? String
        let resultSort = result["sort"] as? String
        let resultPage = result["page"] as? Int
        let resultSize = result["size"] as? Int
        
        
        XCTAssertEqual(resultQuery, expectQuery)
        XCTAssertEqual(resultSort, expectSort)
        XCTAssertEqual(resultPage, expectPage)
        XCTAssertEqual(resultSize, expectSize)
    }
}

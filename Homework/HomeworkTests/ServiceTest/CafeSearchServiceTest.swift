//
//  CafeSearchServiceTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking


class CafeSearchService {
    static var isNetworkOk = true
    static func cafeSearch(_ requestModel:SearchRequestModel) -> Observable<Result<[CafeSearchResultModel],ServiceError>> {
        if !isNetworkOk {
            return Observable.just(Result.failure(.networkError))
        }
        if requestModel.query == "맛집" && requestModel.page == 1 {
            return Observable.just(Result.success([Common.cafeSearchResult]))
        } else if requestModel.query == "맛집" && requestModel.page == 2 {
            return Observable.just(Result.success([Common.cafeSearchResult2]))
        }
        return Observable.just(Result.failure(.emptyResult))
    }
}


class CafeSearchServiceTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    
    func testCafeSearch() throws {
        let query = "맛집"
        let requestModel = SearchRequestModel(query)
        
        let result = try! CafeSearchService.cafeSearch(requestModel).toBlocking().first()!
        
        _ = result.map { array in
            XCTAssertEqual(array[0], Common.cafeSearchResult)
        }
    }
    
    
    func testNetworkError() throws {
        CafeSearchService.isNetworkOk = false
        let query = "맛집"
        let requestModel = SearchRequestModel(query)
        
        let result = try! CafeSearchService.cafeSearch(requestModel).toBlocking().first()!
        
        XCTAssertEqual(result, Result.failure(.networkError))
        
        CafeSearchService.isNetworkOk = true
    }
    
    
    func testEmptyResultError() throws {
        let query = "맛집아님"
        let requestModel = SearchRequestModel(query)
        
        let result = try! CafeSearchService.cafeSearch(requestModel).toBlocking().first()!
        
        XCTAssertEqual(result, Result.failure(.emptyResult))
    }
}

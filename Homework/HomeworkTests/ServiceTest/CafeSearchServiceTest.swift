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


fileprivate let cafeSearchResult = CafeSearchResultModel(cafeName: "소울드레서 (SoulDresser)", contents: "", dateTime:  "2021-04-13T12:16:53.000+09:00", thumbnail: "https://search1.kakaocdn.net/argon/130x130_85_c/HOefMzkcvL3", title: "로제떡볶이 배달<b>맛집</b> 6대장", url: "http://cafe.daum.net/SoulDresser/FLTB/390660")


class CafeSearchService {
    static var isNetworkOk = true
    static func cafeSearch(_ requestModel:SearchRequestModel) -> Observable<Result<[CafeSearchResultModel],ServiceError>> {
        if !isNetworkOk {
            return Observable.just(Result.failure(.networkError))
        }
        if requestModel.query == "맛집" {
            return Observable.just(Result.success([cafeSearchResult]))
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
            XCTAssertEqual(array[0], cafeSearchResult)
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

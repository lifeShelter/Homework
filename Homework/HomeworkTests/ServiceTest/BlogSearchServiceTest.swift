//
//  BlogSearchServiceTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking


class BlogSearchService {
    static var isNetworkOk = true
    static func blogSearch(_ requestModel:SearchRequestModel) -> Observable<Result<[BlogSearchResultModel],ServiceError>> {
        if !isNetworkOk {
            return Observable.just(Result.failure(.networkError))
        }
        if requestModel.query == "맛집" && requestModel.page == 1{
            return Observable.just(Result.success([Common.blogSearchResult]))
        } else if requestModel.query == "맛집" && requestModel.page == 2 {
            return Observable.just(Result.success([Common.blogSearchResult2]))
        }
        return Observable.just(Result.failure(.emptyResult))
    }
}


class BlogSearchServiceTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    
    func testBlogSearch() throws {
        let query = "맛집"
        let requestModel = SearchRequestModel(query)
        
        let result = try! BlogSearchService.blogSearch(requestModel).toBlocking().first()!
        
        _ = result.map { array in
            XCTAssertEqual(array[0], Common.blogSearchResult)
        }
    }
    
    
    func testNetworkError() throws {
        BlogSearchService.isNetworkOk = false
        let query = "맛집"
        let requestModel = SearchRequestModel(query)
        
        let result = try! BlogSearchService.blogSearch(requestModel).toBlocking().first()!
        
        XCTAssertEqual(result, Result.failure(.networkError))
        
        BlogSearchService.isNetworkOk = true
    }
    
    
    func testEmptyResultError() throws {
        let query = "맛집아님"
        let requestModel = SearchRequestModel(query)
        
        let result = try! BlogSearchService.blogSearch(requestModel).toBlocking().first()!
        
        XCTAssertEqual(result, Result.failure(.emptyResult))
    }


}

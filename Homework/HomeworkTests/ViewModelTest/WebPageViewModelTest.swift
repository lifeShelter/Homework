//
//  WebPageViewModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/26.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking


class WebPageViewModelTest: XCTestCase {
    var viewModel1:WebPageViewModel!
    var viewModel2:WebPageViewModel!
    var blogListViewModel:ListCellViewModel!
    var cafeListViewModel:ListCellViewModel!
    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        blogListViewModel = ListCellViewModel(Common.blogSearchResult)
        cafeListViewModel = ListCellViewModel(Common.cafeSearchResult2)
        viewModel1 = WebPageViewModel(blogListViewModel)
        viewModel2 = WebPageViewModel(cafeListViewModel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel1 = nil
        viewModel2 = nil
        blogListViewModel = nil
        cafeListViewModel = nil
        try super.tearDownWithError()
    }

    func testBlogOutputs() throws {
        let typeLabel = "Blog"
        let url = URL(string:blogListViewModel.url)!
        let request = URLRequest(url: url)
        
        let naviText = try! viewModel1.naviTitleText.toBlocking().first()!
        let urlRequest = try! viewModel1.urlRequest.toBlocking().first()!
    
        
        XCTAssertEqual(naviText, typeLabel)
        XCTAssertEqual(request, urlRequest)
    }
    
    
    func testCafeOutputs() throws {
        let typeLabel = "Cafe"
        let url = URL(string:cafeListViewModel.url)!
        let request = URLRequest(url: url)
        
        let naviText = try! viewModel2.naviTitleText.toBlocking().first()!
        let urlRequest = try! viewModel2.urlRequest.toBlocking().first()!
    
        
        XCTAssertEqual(naviText, typeLabel)
        XCTAssertEqual(request, urlRequest)
    }
}

//
//  DetailViewModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest


class DetailViewModelTest: XCTestCase {
    var viewModel1:DetailViewModel!
    var viewModel2:DetailViewModel!
    var blogListViewModel:ListCellViewModel!
    var cafeListViewModel:ListCellViewModel!
    var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        blogListViewModel = ListCellViewModel(Common.blogSearchResult)
        cafeListViewModel = ListCellViewModel(Common.cafeSearchResult2)
        viewModel1 = DetailViewModel(blogListViewModel)
        viewModel2 = DetailViewModel(cafeListViewModel)
    }
    
    
    override func tearDownWithError() throws {
        viewModel1 = nil
        viewModel2 = nil
        blogListViewModel = nil
        cafeListViewModel = nil
        try super.tearDownWithError()
    }
    
    
    func testNaviTitleText() throws {
        let expectedString = "Blog"
        let expectedString2 = "Cafe"
        
        let naviText = try! viewModel1.naviTitleText.toBlocking().first()!
        let naviText2 = try! viewModel2.naviTitleText.toBlocking().first()!
        
        XCTAssertEqual(naviText, expectedString)
        XCTAssertEqual(naviText2, expectedString2)
    }
    
    
    func testName() throws {
        let expectedString = "제주노"
        let expectedString2 = "＊여성시대＊ 차분한 20대들의 알흠다운 공간"
        
        let nameText = try! viewModel1.nameText.toBlocking().first()!
        let nameText2 = try! viewModel2.nameText.toBlocking().first()!
        
        XCTAssertEqual(nameText, expectedString)
        XCTAssertEqual(nameText2, expectedString2)
    }
    
    
    func testTitle() throws {
        let expectString = "제주 표선 맛집 '판타스틱버거'\n"
        viewModel1.titleLabelInfo.accept((UIFont.systemFont(ofSize: 15),UIColor.black))
        
        let output  = try! viewModel1.titleText.toBlocking().first()!
        
        XCTAssertEqual(output.string, expectString)
    }
    
    
    func testContents() throws {
        let expectString = ""
        let expectString2 = "너무 떨린다ㅎㅎㅎ 그럼 시작할게! 너무 주관적인 내 입맛이지만 서울위주의 맛집 기록해볼게~ 나는 화장실이 중요한 사람이여서 화장실 어떤지도 적어볼게(강제) 🤚🏻내...\n"
        viewModel1.textViewInfo.accept((nil,nil))
        viewModel2.textViewInfo.accept((UIFont.systemFont(ofSize: 15),UIColor.black))
        
        let contents  = try! viewModel1.contentsText.toBlocking().first()!
        let contents2  = try! viewModel2.contentsText.toBlocking().first()!
        
        XCTAssertEqual(contents.string, expectString)
        XCTAssertEqual(contents2.string, expectString2)
    }
    
    
    func testDate() throws {
        let expectString = "2021년 04월 22일 오전 09시 09분"
        let expectString2 = "2021년 03월 15일 오후 07시 14분"
        
        let date  = try! viewModel1.dateText.toBlocking().first()!
        let date2  = try! viewModel2.dateText.toBlocking().first()!
        
        XCTAssertEqual(date, expectString)
        XCTAssertEqual(date2, expectString2)
    }
    
    
    func testUrl() throws {
        let expectString = "http://jejuno.tistory.com/120"
        let expectString2 = "http://cafe.daum.net/subdued20club/LxCT/290467"
        
        let url  = try! viewModel1.urlText.toBlocking().first()!
        let url2  = try! viewModel2.urlText.toBlocking().first()!
        
        XCTAssertEqual(url, expectString)
        XCTAssertEqual(url2, expectString2)
    }
    
    
    func testGetListCellViewModel() throws {
        let expect = blogListViewModel
        let expect2 = cafeListViewModel
        
        let blogViewModel = viewModel1.getListCellViewModel()
        let cafeViewModel = viewModel2.getListCellViewModel()
        
        XCTAssertEqual(blogViewModel, expect)
        XCTAssertEqual(cafeViewModel, expect2)
    }
    
    
    func testUpdateListCellViewModel() throws {
        let expect = blogListViewModel
        let expect2 = cafeListViewModel
        
        viewModel1.updateListCellViewModel(cafeListViewModel)
        viewModel2.updateListCellViewModel(blogListViewModel)
        
        XCTAssertEqual(viewModel1.getListCellViewModel(), expect2)
        XCTAssertEqual(viewModel2.getListCellViewModel(), expect)
    }
}

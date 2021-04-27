//
//  SearchListViewModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest
import RxBlocking
import RxSwift
import RxCocoa
import RxTest


class SearchListViewModelTest: XCTestCase {
    var viewModel:SearchListViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = SearchListViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    
    func testSearchResult() throws {
        let expect = [ListCellViewModel(Common.cafeSearchResult),
                      ListCellViewModel(Common.blogSearchResult)]
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        
        XCTAssertEqual(result, expect)
    }
    
    
    func testBlankSearch() throws {
        let expect:[ListCellViewModel] = []
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("    ")
        viewModel.tapSearchButton.accept(())
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        
        XCTAssertEqual(result, expect)
    }
    
    
    func testShowDetail() throws {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        let showDetail = scheduler.createObserver(ListCellViewModel.self)
        
        viewModel.showDetail.bind(to: showDetail).disposed(by: disposeBag)
        
        scheduler.createColdObservable( [.next(10, IndexPath(row: 1, section: 0))]).bind(to: viewModel.cellSelected).disposed(by: disposeBag)
        
        scheduler.start()
        
        
        XCTAssertEqual(showDetail.events, [.next(10, ListCellViewModel(Common.blogSearchResult))])
    }
    
    
    func testPaging() throws {
        let expect:[ListCellViewModel] = [ListCellViewModel(Common.cafeSearchResult),ListCellViewModel(Common.blogSearchResult),ListCellViewModel(Common.blogSearchResult2),ListCellViewModel(Common.cafeSearchResult2)]
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        viewModel.needsMoreLoading.accept(())
        viewModel.needsMoreLoading.accept(())
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        
        XCTAssertEqual(result, expect)
    }
    
    
    func testFilterBlog() throws {
        let expect = true
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        viewModel.filterType.accept(.blog)
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        let resultIsBlog = isFilteredBlog(result)
        
        XCTAssertEqual(resultIsBlog, expect)
    }
    
    
    func testFilterCafe() throws {
        let expect = false
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        viewModel.filterType.accept(.cafe)
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        let resultIsBlog = isFilteredBlog(result)
        
        XCTAssertEqual(resultIsBlog, expect)
    }
    
    
    func isFilteredBlog(_ list:[ListCellViewModel]) -> Bool {
        var isFilteredBlog = true
        for listViewModel in list {
            isFilteredBlog =  listViewModel.typeLabel == "B"
        }
        return isFilteredBlog
    }
    
    
    func testSorted() throws {
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        viewModel.sortType.accept(.datetime)
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        
        XCTAssert(result[0].dateString < result[1].dateString)
    }
    
    
    func testUpdateCell() throws {
        viewModel.searchBarBeginEdit.accept(())
        viewModel.searchBarText.accept("맛집")
        viewModel.tapSearchButton.accept(())
        var listViewModel = ListCellViewModel(Common.blogSearchResult)
        listViewModel.isOpenWebPage = true
        viewModel.updateCell(listViewModel)
        
        let result = try! viewModel.searchResultList.toBlocking().first()!
        print(result)
        
        XCTAssertEqual(listViewModel.isOpenWebPage, result[1].isOpenWebPage)
    }
}

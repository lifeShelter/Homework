//
//  WebPageViewModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/26.
//

import XCTest
import RxSwift
import RxCocoa
import Nimble
import RxNimble
import RxTest


class WebPageViewModelTest: XCTestCase {
    var viewModel:WebPageViewModel!
    var scheduler:TestScheduler!
    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  CafeSearchResultModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking


fileprivate let cafeSearchResult = CafeSearchResultModel(cafeName: "소울드레서 (SoulDresser)", contents: "", dateTime:  "2021-04-13T12:16:53.000+09:00", thumbnail: "https://search1.kakaocdn.net/argon/130x130_85_c/HOefMzkcvL3", title: "로제떡볶이 배달<b>맛집</b> 6대장", url: "http://cafe.daum.net/SoulDresser/FLTB/390660")

class CafeSearchResultModelTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testEqual() throws {
        let expect  = cafeSearchResult
        
        let result = CafeSearchResultModel(cafeName: "소울드레서 (SoulDresser)", contents: "", dateTime:  "2021-04-13T12:16:53.000+09:00", thumbnail: "https://search1.kakaocdn.net/argon/130x130_85_c/HOefMzkcvL3", title: "로제떡볶이 배달<b>맛집</b> 6대장", url: "http://cafe.daum.net/SoulDresser/FLTB/390660")
        let result2 = CafeSearchResultModel(cafeName: "소울드레서 (SoulDresser)", contents: "", dateTime:  "2021-04-13T12:16:53.000+09:00", thumbnail: "https://search1.kakaocdn.net/argon/130x130_85_c/HOefMzkcvL3", title: "로제떡볶이 배달<b>맛집</b> 6대장", url: "http://cafe.daum.net/SoulDresser/FLTB/390661")
        
        XCTAssertEqual(result, expect)
        XCTAssertEqual(result.hashValue, expect.hashValue)
        XCTAssertNotEqual(result2, expect)
        XCTAssertNotEqual(result2.hashValue, expect.hashValue)
    }
}

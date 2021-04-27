//
//  BlogSearchResultModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest


class BlogSearchResultModelTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testEqual() throws {
        let expect  = Common.blogSearchResult
        
        let result = BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: "http://jejuno.tistory.com/120")
        let result2 = BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: "http://jejuno.tistory.com/121")
        
        XCTAssertEqual(result, expect)
        XCTAssertEqual(result.hashValue, expect.hashValue)
        XCTAssertNotEqual(result2, expect)
        XCTAssertNotEqual(result2.hashValue, expect.hashValue)
    }

}

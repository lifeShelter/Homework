//
//  ListCellViewModelTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/26.
//

import XCTest

class ListCellViewModelTest: XCTestCase {
    var modelWithBlog:ListCellViewModel!
    var modelWithBlogDifferentUrl:ListCellViewModel!
    var modelWithBlogWithWrongDate:ListCellViewModel!
    var modelWithCafe:ListCellViewModel!
    var modelWithCafeDifferentUrl:ListCellViewModel!
    var modelWithCafeWithWrongDate:ListCellViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        modelWithBlog = ListCellViewModel(BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: "http://jejuno.tistory.com/120"))
        modelWithBlogDifferentUrl = ListCellViewModel(BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: "http://jejuno.tistory.com/121"))
        modelWithBlogWithWrongDate = ListCellViewModel(BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: "http://jejuno.tistory.com/120"))
        modelWithCafe = ListCellViewModel(CafeSearchResultModel(cafeName: "＊여성시대＊ 차분한 20대들의 알흠다운 공간", contents: "너무 떨린다ㅎㅎㅎ 그럼 시작할게! 너무 주관적인 내 입맛이지만 서울위주의 <b>맛집</b> 기록해볼게~ 나는 화장실이 중요한 사람이여서 화장실 어떤지도 적어볼게(강제) 🤚🏻내...", dateTime: "2021-03-15T19:14:44.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/HLcbxkcFdrI", title: "내가 좋아하는 서울<b>맛집</b>🤸🏻‍♀️", url: "http://cafe.daum.net/subdued20club/LxCT/290467"))
        modelWithCafeDifferentUrl = ListCellViewModel(CafeSearchResultModel(cafeName: "＊여성시대＊ 차분한 20대들의 알흠다운 공간", contents: "너무 떨린다ㅎㅎㅎ 그럼 시작할게! 너무 주관적인 내 입맛이지만 서울위주의 <b>맛집</b> 기록해볼게~ 나는 화장실이 중요한 사람이여서 화장실 어떤지도 적어볼게(강제) 🤚🏻내...", dateTime: "2021-03-15T19:14:44.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/HLcbxkcFdrI", title: "내가 좋아하는 서울<b>맛집</b>🤸🏻‍♀️", url: "http://cafe.daum.net/subdued20club/LxCT/290468"))
        modelWithCafeWithWrongDate = ListCellViewModel(CafeSearchResultModel(cafeName: "＊여성시대＊ 차분한 20대들의 알흠다운 공간", contents: "너무 떨린다ㅎㅎㅎ 그럼 시작할게! 너무 주관적인 내 입맛이지만 서울위주의 <b>맛집</b> 기록해볼게~ 나는 화장실이 중요한 사람이여서 화장실 어떤지도 적어볼게(강제) 🤚🏻내...", dateTime: "", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/HLcbxkcFdrI", title: "내가 좋아하는 서울<b>맛집</b>🤸🏻‍♀️", url: "http://cafe.daum.net/subdued20club/LxCT/290467"))
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        modelWithBlog = nil
        modelWithBlogDifferentUrl  = nil
        modelWithBlogWithWrongDate = nil
        modelWithCafe = nil
        try super.tearDownWithError()
    }

    
    func testEqual() throws {
        let blogModel1  = modelWithBlog
        var blogModel2  = modelWithBlog
        let cafeModel1 = modelWithCafe
        var cafeModel2 = modelWithCafe
        
        blogModel2?.isOpenWebPage = true
        cafeModel2?.isOpenWebPage = true
        
        XCTAssertEqual(blogModel1, blogModel2)
        XCTAssertEqual(blogModel1?.hashValue, blogModel2?.hashValue)
        XCTAssertEqual(cafeModel1, cafeModel2)
        XCTAssertEqual(cafeModel1?.hashValue, cafeModel2?.hashValue)
    }
    
    
    func testNotEqual() throws {
        let blogModel1 = modelWithBlog
        let blogModel2 = modelWithBlogDifferentUrl
        let cafeModel1 = modelWithCafe
        let cafeModel2 = modelWithCafeDifferentUrl
        
        XCTAssertNotEqual(blogModel1, blogModel2)
        XCTAssertNotEqual(blogModel1?.hashValue, blogModel2?.hashValue)
        XCTAssertNotEqual(cafeModel1, cafeModel2)
        XCTAssertNotEqual(cafeModel1?.hashValue, cafeModel2?.hashValue)
    }
    
    
    func testIsOpenWebPage() throws {
        let url = "http://jejuno.tistory.com/120"
        UserDefaults.standard.setValue(url, forKey: url)
        UserDefaults.standard.synchronize()
        
        modelWithBlog = ListCellViewModel(BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: url))
        
        XCTAssertEqual(modelWithBlog.isOpenWebPage, true)
        UserDefaults.standard.removeObject(forKey: url)
        UserDefaults.standard.synchronize()
    }
    
    
    func testIsNotOpenWebPage() throws {
        let url = "http://jejuno.tistory.com/120"
        UserDefaults.standard.removeObject(forKey: url)
        UserDefaults.standard.synchronize()
        
        modelWithBlog = ListCellViewModel(BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: url))
        
        XCTAssertEqual(modelWithBlog.isOpenWebPage, false)
    }

}

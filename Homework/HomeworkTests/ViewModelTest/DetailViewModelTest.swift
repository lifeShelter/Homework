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

class DetailViewModelTest: XCTestCase {
    var viewModel1:DetailViewModel!
    var viewModel2:DetailViewModel!
    var blogListViewModel:ListCellViewModel!
    var cafeListViewModel:ListCellViewModel!
    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        try super.setUpWithError()
        blogListViewModel = ListCellViewModel(BlogSearchResultModel(blogName: "제주노", contents: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39; 안녕하세요~ &#39;제주노&#39;입니다!! 맛이 있거나 없거나 <b>맛집</b>이라면 제가 먼저 먹어보겠습니다. 맛 평가는 맨 아래에 있으니 급하신 분들은 맨 밑으로 가면 됩니당~~🙏🙏 자 그럼 오늘의 추천 <b>맛집</b>을 알아볼까요?? 오늘의 추천 <b>맛집</b>은 바로~~ 제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;입니다 ★판타스틱...", dateTime: "2021-04-22T09:09:11.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/JsN6Ur3r6pq", title: "제주 표선 <b>맛집</b> &#39;판타스틱버거&#39;", url: "http://jejuno.tistory.com/120"))
        cafeListViewModel = ListCellViewModel(CafeSearchResultModel(cafeName: "＊여성시대＊ 차분한 20대들의 알흠다운 공간", contents: "너무 떨린다ㅎㅎㅎ 그럼 시작할게! 너무 주관적인 내 입맛이지만 서울위주의 <b>맛집</b> 기록해볼게~ 나는 화장실이 중요한 사람이여서 화장실 어떤지도 적어볼게(강제) 🤚🏻내...", dateTime: "2021-03-15T19:14:44.000+09:00", thumbnail: "https://search3.kakaocdn.net/argon/130x130_85_c/HLcbxkcFdrI", title: "내가 좋아하는 서울<b>맛집</b>🤸🏻‍♀️", url: "http://cafe.daum.net/subdued20club/LxCT/290467"))
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

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

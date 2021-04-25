//
//  WebPageViewModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/25.
//

import Foundation
import RxSwift
import RxCocoa


class WebPageViewModel {
    //private
    private var listViewModel:ListCellViewModel
    private var disposeBag  = DisposeBag()
    
    // input
    
    
    // output
    let naviTitleText = BehaviorRelay<String>(value: "")
    let urlRequest = BehaviorRelay<URLRequest>(value: URLRequest(url: URL(string:"https://daum.net")!))
    
    
    init(_ listViewModel:ListCellViewModel) {
        self.listViewModel = listViewModel
        self.listViewModel.isOpenWebPage = true
        naviTitleText.accept((listViewModel.typeLabel == "B") ? "Blog" : "Cafe")
        if let url = URL(string:listViewModel.url) {
            let request = URLRequest(url: url)
            urlRequest.accept(request)
        }
    }
}

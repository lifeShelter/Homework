//
//  SearchListViewModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import Foundation
import RxSwift
import RxCocoa


class SearchListViewModel {
    // private
    private var disposeBag = DisposeBag()
    
    // input
    let searchBarText = PublishRelay<String>()
    let tapSearchButton = PublishRelay<Void>()
    
    // output
    
    
    
    init() {
        tapSearchButton.withLatestFrom(searchBarText)
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines) != ""}
            .subscribe(onNext:{ str in
                print("sub")
                print(str)
            }).disposed(by: disposeBag)
    }
}

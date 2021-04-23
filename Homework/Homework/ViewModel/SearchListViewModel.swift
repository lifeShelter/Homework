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
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter { $0 != ""}
            .subscribe(onNext:{[weak self] str in
                print("sub")
                print(str)
                self?.addHistory(str)
            }).disposed(by: disposeBag)
    }
    
    
    private func addHistory(_ str:String) {
        if let history = UserDefaults.standard.array(forKey: "history") as? Array<String> {
            var historySet:Set<String> = Set(history.map {$0})
            historySet.insert(str)
            print("historySet = \(historySet)")
            UserDefaults.standard.setValue(Array(historySet), forKey: "history")
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.setValue( [str], forKey: "history")
            UserDefaults.standard.synchronize()
        }
    }
}

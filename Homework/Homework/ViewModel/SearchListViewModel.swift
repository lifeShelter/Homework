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
    private let searchStart = PublishRelay<String>()
    private let filterAndSortChanged = BehaviorRelay<(FilterEnum,SortEnum)>(value: (.all, .title))
    private let searchCase = PublishRelay<(String,(FilterEnum,SortEnum))>()
    
    // input
    let searchBarText = PublishRelay<String>()
    let tapSearchButton = PublishRelay<Void>()
    let searchBarBeginEdit = PublishRelay<Void>()
    let filterType = BehaviorRelay<FilterEnum>(value:.all)
    let sortType = BehaviorRelay<SortEnum>(value:.title)
    
    // output
    let historyRelay = BehaviorRelay<Array<String>>(value: [])
    let showHistory = PublishRelay<Void>()
    
    
    init() {
        tapSearchButton.withLatestFrom(searchBarText)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter { $0 != ""}
            .bind(to: searchStart).disposed(by: disposeBag)
        searchStart.map(addHistory(_:)).subscribe().disposed(by: disposeBag)
        historyRelay.accept(getHistory())
        searchBarBeginEdit.bind(to: showHistory).disposed(by: disposeBag)
        Observable.combineLatest(filterType, sortType)
            .bind(to: filterAndSortChanged).disposed(by: disposeBag)
        Observable.combineLatest(searchStart, filterAndSortChanged)
            .bind(to: searchCase).disposed(by: disposeBag)
        searchCase.subscribe(onNext:{
            print("\($0),\($1)")
        }).disposed(by: disposeBag)
    }
    
    
    private func addHistory(_ str:String) {
        let history = getHistory()
        if history.count == 0 {
            UserDefaults.standard.setValue( [str], forKey: "history")
            UserDefaults.standard.synchronize()
            return
        }

        var historySet:Set<String> = Set(history.map {$0})
        historySet.insert(str)
//        print("historySet = \(historySet)")
        UserDefaults.standard.setValue(Array(historySet), forKey: "history")
        UserDefaults.standard.synchronize()
        historyRelay.accept(Array(historySet))
    }
    
    
    private func getHistory() -> Array<String> {
        if let history = UserDefaults.standard.array(forKey: "history") as? Array<String> {
            return history
        } else {
            return []
        }
    }
}

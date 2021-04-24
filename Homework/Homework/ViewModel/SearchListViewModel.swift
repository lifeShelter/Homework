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
    private let requestModel = PublishRelay<SearchRequestModel>()
    private let blogResult = PublishRelay<[BlogSearchResultModel]>()
    private let cafeResult = PublishRelay<[CafeSearchResultModel]>()
    
    // input
    let searchBarText = PublishRelay<String>()
    let tapSearchButton = PublishRelay<Void>()
    let searchBarBeginEdit = PublishRelay<Void>()
    let filterType = BehaviorRelay<FilterEnum>(value:.all)
    let sortType = BehaviorRelay<SortEnum>(value:.title)
    
    // output
    let historyRelay = BehaviorRelay<[String]>(value: [])
    let showHistory = PublishRelay<Void>()
    let searchResultList = BehaviorRelay<[ListCellViewModel]>(value: [])
    
    
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
        
        searchCase.map(makeRequestModel(_:))
            .flatMap(BlogSearchService.blogSearch(_:))
            .subscribe(onNext:{ [weak self]  in
                switch $0 {
                case .failure(.invalidJson):
                    break
                case .failure(.networkError):
                    break
                case .failure(.notAuthorized):
                    break
                case .failure(.emptyResult):
                    //                    self.showVerifyPhoneNumberPage.accept($0.1)
                    break
                case .success(_):
                _ = $0.map {
                    print($0)
                    self?.blogResult.accept($0)
                }
                break
                }
            }).disposed(by: disposeBag)
        searchCase.map(makeRequestModel(_:))
            .flatMap(CafeSearchService.cafeSearch(_:))
            .subscribe(onNext:{ [weak self]  in
                switch $0 {
                case .failure(.invalidJson):
                    break
                case .failure(.networkError):
                    break
                case .failure(.notAuthorized):
                    break
                case .failure(.emptyResult):
                    //                    self.showVerifyPhoneNumberPage.accept($0.1)
                    break
                case .success(_):
                _ = $0.map {
                    print($0)
                    self?.cafeResult.accept($0)
                }
                break
                }
            }).disposed(by: disposeBag)
        Observable.combineLatest(blogResult.map(makeListCellViewModel(_:)), cafeResult.map(makeListCellViewModel(_:))) {
            $0 + $1
        }.map {
            $0.sorted { left, right -> Bool in
                left.title < right.title
            }
        }.bind(to: searchResultList).disposed(by: disposeBag)
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
    
    
    private func makeRequestModel(_ searchCase:(String,(FilterEnum,SortEnum))) -> SearchRequestModel {
        return SearchRequestModel(searchCase.0, sort: searchCase.1.1)
    }
    
    
    private func makeListCellViewModel(_ blogResult:[BlogSearchResultModel]) -> [ListCellViewModel] {
        if blogResult.count == 0 {
            return  []
        }
        return blogResult.map {
            ListCellViewModel($0)
        }
    }
    
    
    private func makeListCellViewModel(_ cafeResult:[CafeSearchResultModel]) -> [ListCellViewModel] {
        if cafeResult.count == 0 {
            return  []
        }
        return cafeResult.map {
            ListCellViewModel($0)
        }
    }
}

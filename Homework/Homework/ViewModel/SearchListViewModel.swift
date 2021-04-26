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
    private var cellList:[ListCellViewModel] = []
    private var pageList:[ListCellViewModel] = []
    private var disposeBag = DisposeBag()
    private let searchTextReady = PublishRelay<String>()
    private let filterAndSortChanged = BehaviorRelay<(FilterEnum,SortEnum)>(value: (.all, .title))
    private let requestModel = PublishRelay<SearchRequestModel>()
    private let blogResult = PublishRelay<[BlogSearchResultModel]>()
    private let cafeResult = PublishRelay<[CafeSearchResultModel]>()
    private let combineResult = PublishRelay<[ListCellViewModel]>()
    private let nowLoading = BehaviorRelay<Bool>(value: false)
    private let updateRequestModel = PublishRelay<SearchRequestModel>()
    private let pageResults = BehaviorRelay<[ListCellViewModel]>(value: [])
    
    // input
    let searchBarText = PublishRelay<String>()
    let tapSearchButton = PublishRelay<Void>()
    let searchBarBeginEdit = PublishRelay<Void>()
    let filterType = BehaviorRelay<FilterEnum>(value:.all)
    let sortType = BehaviorRelay<SortEnum>(value:.title)
    let cellSelected = PublishRelay<IndexPath>()
    let needsMoreLoading  = PublishRelay<Void>()
    
    // output
    let searchHistoryRelay = BehaviorRelay<[String]>(value: [])
    let showSearchHistory = PublishRelay<Void>()
    let searchResultList = BehaviorRelay<[ListCellViewModel]>(value: [])
    let showDetail = PublishRelay<ListCellViewModel>()
    
    
    //MARK: - init
    init() {
        setupClearLists()
        setupSearchText()
        setupSearchHistory()
        setupFilterAndSort()
        setupRequestModel()
        setupServiceResults()
        setupSearchResultList()
        setupShowDetail()
        setupPaging()
    }
    
    
    //MARK: - setup
    private func setupClearLists() {
        tapSearchButton.subscribe(onNext:{ [weak self]  in
            self?.combineResult.accept([])
            self?.searchResultList.accept([])
            self?.pageResults.accept([])
        }).disposed(by: disposeBag)
    }
    
    
    private func setupSearchText() {
        tapSearchButton.withLatestFrom(searchBarText)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter { $0 != ""}
            .bind(to: searchTextReady).disposed(by: disposeBag)
    }
    
    
    private func setupSearchHistory() {
        searchTextReady.map(addSearchHistory(_:)).subscribe().disposed(by: disposeBag)
        searchHistoryRelay.accept(getSearchHistory())
        searchBarBeginEdit.bind(to: showSearchHistory).disposed(by: disposeBag)
    }
    
    
    private func setupFilterAndSort() {
        Observable.combineLatest(filterType, sortType)
            .bind(to: filterAndSortChanged).disposed(by: disposeBag)
        filterAndSortChanged.withLatestFrom(pageResults,resultSelector: filterAndSortArray)
            .bind(to: searchResultList).disposed(by: disposeBag)
    }
    
    
    private func setupRequestModel() {
        searchTextReady.map(makeRequestModel(_:)).bind(to: requestModel).disposed(by: disposeBag)
    }
    
    
    private func setupServiceResults() {
        requestModel
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
                    break
                case .success(_):
                    _ = $0.map {
                        //                        print($0)
                        self?.blogResult.accept($0)
                    }
                    break
                }
            }).disposed(by: disposeBag)
        
        requestModel
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
                    break
                case .success(_):
                    _ = $0.map {
                        //                        print($0)
                        self?.cafeResult.accept($0)
                    }
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    
    private func setupSearchResultList() {
        Observable.zip(blogResult.map(makeListCellViewModel(_:)), cafeResult.map(makeListCellViewModel(_:)))
            .map {
                $0.0 + $0.1
            }.bind(to: combineResult).disposed(by: disposeBag)
        
        combineResult.withLatestFrom(pageResults) { [weak self] in
            let array  = $1 + $0
            self?.pageList = array
            return array
        }.bind(to: pageResults).disposed(by: disposeBag)
        
        combineResult.filter{$0.count > 0}
            .withLatestFrom(filterAndSortChanged,resultSelector: filterAndSortArray)
            .withLatestFrom(searchResultList) { [weak self] in
                self?.nowLoading.accept(false)
                let returnArray = $1 + $0
                self?.cellList = returnArray
                return returnArray
            }.bind(to: searchResultList).disposed(by: disposeBag)
    }
    
    
    private func setupShowDetail() {
        cellSelected.withLatestFrom(searchResultList) {
            $1[$0.row]
        }.bind(to: showDetail).disposed(by: disposeBag)
    }
    
    
    private func setupPaging() {
        needsMoreLoading.withLatestFrom(nowLoading)
            .filter {$0 == false}
            .map { !$0 }.bind(to: nowLoading).disposed(by: disposeBag)
        
        nowLoading.filter { $0 }
            .withLatestFrom(requestModel)
            .map {
                var requestModel =  $0
                if let page =  requestModel.page {
                    requestModel.page = page + 1
                    print("page = \(String(describing: requestModel.page))")
                }
                return requestModel
            }.bind(to: requestModel).disposed(by: disposeBag)
    }
    
    
    //MARK: - history
    private func addSearchHistory(_ str:String) {
        let history = getSearchHistory()
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
        searchHistoryRelay.accept(Array(historySet))
    }
    
    
    private func getSearchHistory() -> Array<String> {
        if let history = UserDefaults.standard.array(forKey: "history") as? Array<String> {
            return history
        } else {
            return []
        }
    }
    
    
    //MARK: - requestModel
    private func makeRequestModel(_ str:String) -> SearchRequestModel {
        return SearchRequestModel(str)
    }
    
    
    //MARK: - ListCellViewModel
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
    
    
    //MARK: - filter and sort
    private func filterAndSortArray(_ array:[ListCellViewModel],_ filterAndSort:(FilterEnum,SortEnum)) -> [ListCellViewModel] {
        let deletedArray = deleteDuplicate(array)
        let filterArray = deletedArray.filter {
            if filterAndSort.0 == .cafe {
                return $0.typeLabel == "C"
            } else if filterAndSort.0 == .blog {
                return $0.typeLabel == "B"
            }
            return true
        }
        let returnArray =   filterArray.sorted { left, right -> Bool in
            if filterAndSort.1 == .title {
                return left.title < right.title
            } else {
                return left.dateString < right.dateString
            }
        }
        return returnArray
    }
    
    private func filterAndSortArray(_ filterAndSort:(FilterEnum,SortEnum),_ array:[ListCellViewModel]) -> [ListCellViewModel] {
        filterAndSortArray(array,filterAndSort)
    }
    
    
    private func deleteDuplicate(_ array:[ListCellViewModel]) ->[ListCellViewModel] {
        let resultSet:Set<ListCellViewModel> = Set(array.map { $0 })
        return Array(resultSet)
    }
    
    
    //MARK: - public
    func updateCell(_ listModel:ListCellViewModel) {
        print("updateCell")
        cellList = cellList.map {
            if $0  == listModel {
                return listModel
            } else {
                return $0
            }
        }
        pageList = pageList.map {
            if $0 == listModel {
                return listModel
            } else {
                return $0
            }
        }
        searchResultList.accept(cellList)
        pageResults.accept(pageList)
    }
}

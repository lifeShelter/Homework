//
//  ViewController.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import UIKit
import RxSwift
import RxCocoa
import DropDown


class SearchListViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private let viewModel = SearchListViewModel()
    private var historyDropDown = DropDown()
    private var filterDropDown = DropDown()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        inputBinding()
        outputBinding()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func setupDefaults() {
        filterDropDown.dataSource = ["All","Blog","Cafe"]
        historyDropDown.anchorView  = searchBar
        historyDropDown.bottomOffset = CGPoint(x: 0, y:(historyDropDown.anchorView?.plainView.bounds.height)!)
        historyDropDown.selectionAction = { [weak self] index, item in
            self?.searchBar.text = item
            self?.viewModel.searchBarText.accept(item)
            self?.viewModel.tapSearchButton.accept(())
            self?.historyDropDown.clearSelection()
        }
        historyDropDown.cancelAction = { [weak self] in
            self?.view.endEditing(true)
        }
    }
    
    
    private func inputBinding() {
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchBarText).disposed(by: disposeBag)
        searchBar.rx.searchButtonClicked.bind(to: viewModel.tapSearchButton).disposed(by: disposeBag)
        searchButton.rx.tap.bind(to: viewModel.tapSearchButton).disposed(by: disposeBag)
        searchBar.rx.textDidBeginEditing.bind(to: viewModel.searchBarBeginEdit).disposed(by: disposeBag)
    }
    
    
    private func outputBinding() {
        viewModel.historyRelay.subscribe(onNext:{[weak self] array in
            self?.historyDropDown.dataSource = array
        }).disposed(by: disposeBag)
        viewModel.showHistory.subscribe(onNext:{[weak self] _ in
            self?.historyDropDown.show()
        }).disposed(by: disposeBag)
    }
}


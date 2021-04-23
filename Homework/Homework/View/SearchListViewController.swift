//
//  ViewController.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import UIKit
import RxSwift
import RxCocoa


class SearchListViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private let viewModel = SearchListViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        inputBinding()
        outputBinding()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
    
    private func setupDefaults() {
        
    }
    
    
    private func inputBinding() {
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchBarText).disposed(by: disposeBag)
        searchBar.rx.searchButtonClicked.bind(to: viewModel.tapSearchButton).disposed(by: disposeBag)
        searchButton.rx.tap.bind(to: viewModel.tapSearchButton).disposed(by: disposeBag)
    }
    
    
    private func outputBinding() {
        
    }
}


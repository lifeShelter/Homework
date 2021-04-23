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
    @IBOutlet weak var tableView: UITableView!
    
    
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
        setupFilterDropDown()
        setupHistoryDropDown()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func setupFilterDropDown() {
        filterDropDown.dataSource = ["All","Blog","Cafe"]
    }
    
    
    private func setupHistoryDropDown()  {
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
    
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: "정렬기준", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let titleAction = UIAlertAction(title: "Title", style: .default) { [weak self] _ in
            self?.viewModel.sortType.accept(.title)
        }
        let dateTimeAction = UIAlertAction(title: "Datetime", style: .default) { [weak self] _ in
            self?.viewModel.sortType.accept(.datetime)
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(titleAction)
        actionSheet.addAction(dateTimeAction)
        present(actionSheet, animated: true, completion: nil)
    }
}


extension SearchListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}


extension SearchListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as? FilterTableViewCell else {
            print("filtercell load fail")
            return UIView()
        }
        filterDropDown.anchorView  = cell.textField
        filterDropDown.selectionAction = { [weak self] index, item in
            cell.textField.text = item
            self?.viewModel.filterType.accept(FilterEnum(rawValue: item) ?? .all)
            self?.filterDropDown.clearSelection()
        }
        cell.sortAction  = { [weak self] in
            self?.showActionSheet()
        }
        cell.filterAction  = { [weak self] in
            self?.filterDropDown.show()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


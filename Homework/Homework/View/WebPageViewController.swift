//
//  WebPageViewController.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import UIKit
import WebKit
import RxSwift


class WebPageViewController: UIViewController {
    // public
    var listCellViewModel:ListCellViewModel?
    var backAction:(ListCellViewModel)->Void = { _ in }

    // private
    private var viewModel:WebPageViewModel?
    private var disposeBag = DisposeBag()
    
    // IBOutlet
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    //MARK: -  override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        outputBinding()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let listCellViewModel  = self.listCellViewModel {
            backAction(listCellViewModel)
        }
    }
    
    
    //MARK: - setup
    private func setupDefaults() {
        guard let listViewModel = self.listCellViewModel else {
            print("셀데이터가 전달되지 않았습니다.")
            return
        }
        viewModel =  WebPageViewModel(listViewModel)
        self.listCellViewModel?.isOpenWebPage = true
    }
    
    
    //MARK: - binding
    private func outputBinding() {
        guard let viewModel = self.viewModel else {
            print("viewModel이 초기화 되지 않았습니다.")
            return
        }
        
        viewModel.naviTitleText.bind(to: titleView.rx.title).disposed(by: disposeBag)
        viewModel.urlRequest.subscribe(onNext: { [weak self] in
            self?.webView.load($0)
        }).disposed(by: disposeBag)
    }

}

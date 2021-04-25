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

    // private
    private var viewModel:WebPageViewModel?
    private var disposeBag = DisposeBag()
    
    // IBOutlet
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleView: UINavigationItem!
    
    
    //MARK: -  override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        inputBinding()
        outputBinding()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - setup
    private func setupDefaults() {
        guard let listViewModel = self.listCellViewModel else {
            print("셀데이터가 전달되지 않았습니다.")
            return
        }
        viewModel =  WebPageViewModel(listViewModel)
    }
    
    
    //MARK: - binding
    private func inputBinding() {
        
    }
    
    
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

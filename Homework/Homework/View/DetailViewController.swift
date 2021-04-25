//
//  DetailViewController.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import UIKit
import RxSwift


class DetailViewController: UIViewController {
    // public
    var listCellViewModel:ListCellViewModel?
    var closeAction:(ListCellViewModel)->Void = { _ in  }
    
    //private
    private var viewModel:DetailViewModel?
    private var disposeBag = DisposeBag()
    
    // IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIButton!
    
    
    //MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        inputBinding()
        outputBinding()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebPage" {
            if let dest = segue.destination as? WebPageViewController {
                dest.listCellViewModel = sender as? ListCellViewModel
            }
        }
    }
    
    
    //MARK: - setup
    private func setupDefaults() {
        guard let listCellViewModel = self.listCellViewModel else {
            print("cell 정보가 전달되지 않았습니다.")
            return
        }
        viewModel = DetailViewModel(listCellViewModel)
        print(listCellViewModel)
    }
    
    
    //MARK: - Binding
    private func inputBinding() {
        guard let viewModel =  self.viewModel else {
            print("viewModel이 초기화 되지 않았습니다.")
            return
        }
        viewModel.titleLabelInfo.accept((titleLabel.font,titleLabel.textColor))
        viewModel.textViewInfo.accept((contentsTextView.font,contentsTextView.textColor))
        backButton.rx.tap.bind(to: viewModel.tapBackButton).disposed(by: disposeBag)
        moveButton.rx.tap.bind(to: viewModel.tapMoveButton).disposed(by:disposeBag)
    }
    
    
    private func outputBinding() {
        guard let viewModel =  self.viewModel else {
            print("viewModel이 초기화 되지 않았습니다.")
            return
        }
        if  let  navigationController = self.navigationController, let topItem  = navigationController.navigationBar.topItem {
            viewModel.naviTitleText.bind(to: topItem.rx.title).disposed(by: disposeBag)
        }
        viewModel.nameText.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.titleText.bind(to: titleLabel.rx.attributedText).disposed(by: disposeBag)
        viewModel.contentsText.bind(to: contentsTextView.rx.attributedText).disposed(by: disposeBag)
        viewModel.dateText.bind(to: dateLabel.rx.text).disposed(by: disposeBag)
        viewModel.urlText.bind(to:urlLabel.rx.text).disposed(by: disposeBag)
        viewModel.thumbnailImage.bind(to:imageView.rx.image).disposed(by: disposeBag)
        viewModel.closeDetail.subscribe(onNext:{[weak self] listViewModel in
            self?.navigationController?.dismiss(animated: true, completion: {
                self?.closeAction(listViewModel)
            })
        }).disposed(by: disposeBag)
        viewModel.showWebPage.subscribe(onNext:{[weak self] listViewModel in
            self?.performSegue(withIdentifier: "showWebPage", sender: listViewModel)
        }).disposed(by: disposeBag)
    }
}

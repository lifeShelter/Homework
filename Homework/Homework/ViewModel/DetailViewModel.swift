//
//  DetailViewModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/25.
//

import Foundation
import RxSwift
import RxCocoa


class DetailViewModel {
    //private
    private var listViewModel:ListCellViewModel
    private var disposeBag  = DisposeBag()
    
    // input
    let titleLabelInfo = PublishRelay<(UIFont,UIColor)>()
    let textViewInfo = PublishRelay<(UIFont?,UIColor?)>()
    let tapBackButton = PublishRelay<Void>()
    let tapMoveButton = PublishRelay<Void>()
    
    // output
    let naviTitleText = BehaviorRelay<String>(value:"")
    let nameText = BehaviorRelay<String>(value: "")
    let titleText = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
    let contentsText = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
    let dateText  = BehaviorRelay<String>(value:"")
    let urlText = BehaviorRelay<String>(value:"")
    let thumbnailImage  = BehaviorRelay<UIImage?>(value: nil)
    let showWebPage  = PublishRelay<ListCellViewModel>()
    let closeDetail = PublishRelay<ListCellViewModel>()
    
    
    init(_ listViewModel:ListCellViewModel) {
        self.listViewModel =  listViewModel
        naviTitleText.accept((listViewModel.typeLabel == "B") ? "Blog" : "Cafe")
        
        nameText.accept(listViewModel.name)
        
        titleLabelInfo.withLatestFrom(Observable.just(listViewModel.title),resultSelector:attributedStringWithFont).bind(to: titleText).disposed(by: disposeBag)
        
        textViewInfo.filter {$0.0 != nil && $0.1 != nil}.map { ($0.0!,$0.1!)}.withLatestFrom(Observable.just(listViewModel.contents),resultSelector:attributedStringWithFont).bind(to: contentsText).disposed(by: disposeBag)
        
        dateText.accept(Constants.dateToDateString(listViewModel.date, dateFormat: "yyyy년 MM월 dd일 a hh시 mm분"))
        
        urlText.accept(listViewModel.url)
        
        Observable.just(listViewModel.thunmbnail)
            .filter { $0 !=  "" }
            .flatMap(LoadImageService.loadImage(from:))
            .bind(to: thumbnailImage).disposed(by: disposeBag)
        
        tapBackButton.map { [weak self] in
            self?.listViewModel
        }.filter {$0 != nil}.map{$0!}.bind(to: closeDetail).disposed(by: disposeBag)
        
        tapMoveButton.map { [weak self] in
            self?.listViewModel
        }.filter {$0 != nil}.map{$0!}.bind(to: showWebPage).disposed(by: disposeBag)
    }
    
    
    private func attributedStringWithFont(_ info:(UIFont,UIColor), str:String) -> NSAttributedString {
        let titleFont  = info.0
        let titleColor =  info.1.hexDescription()
        return str.htmlEscaped(font: titleFont , colorHex: titleColor, lineSpacing: 1.0,  textAlignment: .center)
    }
    
    
    func updateListCellViewModel(_ viewModel:ListCellViewModel) {
        self.listViewModel =  viewModel
    }
}

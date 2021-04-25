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
    
    // output
    let naviTitleText = BehaviorRelay<String>(value:"")
    let nameText = BehaviorRelay<String>(value: "")
    let titleText = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
    let contentsText = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
    let dateText  = BehaviorRelay<String>(value:"")
    let urlText = BehaviorRelay<String>(value:"")
    let thumbnailImage  = BehaviorRelay<UIImage?>(value: nil)
    
    
    init(_ listViewModel:ListCellViewModel) {
        self.listViewModel =  listViewModel
        naviTitleText.accept((listViewModel.typeLabel == "B") ? "Blog" : "Cafe")
        nameText.accept(listViewModel.name)
        titleLabelInfo.map (attributedStringWithFont).bind(to: titleText).disposed(by: disposeBag)
        textViewInfo.filter {$0.0 != nil && $0.1 != nil}.map { ($0.0!,$0.1!)}.map(attributedStringWithFont).bind(to: contentsText).disposed(by: disposeBag)
        dateText.accept(Constants.dateToDateString(listViewModel.date, dateFormat: "yyyy년 MM월 dd일 a hh시 mm분"))
        urlText.accept(listViewModel.url)
        Observable.just(listViewModel.thunmbnail)
            .filter { $0 !=  "" }
            .flatMap(LoadImageService.loadImage(from:))
            .bind(to: thumbnailImage).disposed(by: disposeBag)
    }
    
    
    private func attributedStringWithFont(_ font:UIFont, color:UIColor) -> NSAttributedString {
        let titleFont  = font
        let titleColor =  color.hexDescription()
        return listViewModel.title.htmlEscaped(font: titleFont , colorHex: titleColor, lineSpacing: 1.0,  textAlignment: .center)
    }
}

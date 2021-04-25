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
    
    //private
    private var disposeBag = DisposeBag()
    
    // IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    
    private func setupDefaults() {
        guard let listCellViewModel = self.listCellViewModel else {
            print("cell 정보가 전달되지 않았습니다.")
            return
        }
        print(listCellViewModel)
        navigationController?.navigationBar.topItem?.title = (listCellViewModel.typeLabel == "B") ? "Blog" : "Cafe"
        nameLabel.text =  listCellViewModel.name
        
        let titleFont  = titleLabel.font
        let titleColor =  titleLabel.textColor.hexDescription()
        titleLabel.attributedText = listCellViewModel.title.htmlEscaped(font: titleFont ?? UIFont.systemFont(ofSize: 17), colorHex: titleColor, lineSpacing: 1.0,  textAlignment: .center)
        
        let contentsFont = contentsTextView.font
        var contentsColor:String
        if let textViewTextColor = contentsTextView.textColor {
            contentsColor = textViewTextColor.hexDescription()
        } else {
            if #available(iOS 13.0, *) {
                contentsColor =  UIColor.label.hexDescription()
            } else {
                contentsColor = UIColor.black.hexDescription()
            }
        }
        contentsTextView.attributedText =  listCellViewModel.contents.htmlEscaped(font: contentsFont ?? UIFont.systemFont(ofSize: 15), colorHex: contentsColor, lineSpacing: 1.0, textAlignment: .center)
        dateLabel.text  = Constants.dateToDateString(listCellViewModel.date, dateFormat: "yyyy년 MM월 dd일 a hh시 mm분")
        urlLabel.text = listCellViewModel.url
        if listCellViewModel.thunmbnail != "" {
            LoadImageService.loadImage(from: listCellViewModel.thunmbnail)
                .observe(on: MainScheduler.instance)
                .bind(to: imageView.rx.image)
                .disposed(by: disposeBag)
        } else {
            imageView.image = nil
        }
    }
    

    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  ListTableViewCell.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import UIKit
import RxSwift
import RxCocoa

class ListTableViewCell: UITableViewCell {
    private var disposeBag = DisposeBag()
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var thumnailView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    func setDatas(_ item:ListCellViewModel) {
        typeLabel.text = item.label
        nameLabel.text = item.name
        let font = titleLabel.font
        let color = titleLabel.textColor.hexDescription()
        titleLabel.attributedText = item.title.htmlEscaped(font: font ?? UIFont.systemFont(ofSize: 17), colorHex: color, lineSpacing: 1.0)
        dateTimeLabel.text = item.dateString
        if item.thunmbnail != "" {
            LoadImageService.loadImage(from: item.thunmbnail)
                .observe(on: MainScheduler.instance)
                .bind(to: thumnailView.rx.image)
                .disposed(by: disposeBag)
        } else {
            thumnailView.image = nil
        }
    }
}

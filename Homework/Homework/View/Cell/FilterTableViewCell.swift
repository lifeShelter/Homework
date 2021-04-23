//
//  FilterTableViewCell.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import UIKit
import DropDown

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    var sortAction:()->Void = { }
    var filterAction:()->Void = {}
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func sortButtonAction(_ sender: Any) {
        sortAction()
    }
    
    
    @IBAction func filterButtonAction(_ sender: Any) {
        filterAction()
    }
}

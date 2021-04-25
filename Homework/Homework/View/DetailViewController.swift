//
//  DetailViewController.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import UIKit

class DetailViewController: UIViewController {
    var listCellViewModel:ListCellViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("listcell = \(String(describing: listCellViewModel))")
    }
    

    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

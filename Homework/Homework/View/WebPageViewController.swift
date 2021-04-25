//
//  WebPageViewController.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    var listCellViewModel:ListCellViewModel?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("web = \(String(describing: listCellViewModel))")
        let link = URL(string:"https://developer.apple.com/videos/play/wwdc2019/239/")!
        let request = URLRequest(url: link)
        webView.load(request)
        // Do any additional setup after loading the view.
    }

}

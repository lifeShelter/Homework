//
//  BlogSearchRequestModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct SearchRequestModel {
    var query:String
    var sort:String?
    var page:Int?
    var size:Int?
    
    var parameters:[String:Any] {
        var dic:[String:Any] = ["query": query]
        if let sort = self.sort {
            dic.updateValue(sort, forKey: "sort")
        }
        if let page = self.page {
            dic.updateValue(page, forKey: "page")
        }
        if let size = self.size {
            dic.updateValue(size, forKey: "size")
        }
        return dic
    }
}

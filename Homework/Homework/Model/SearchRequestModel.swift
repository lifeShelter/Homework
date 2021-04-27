//
//  BlogSearchRequestModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct SearchRequestModel:Hashable {
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
    
    
    init(_ query:String) {
        self.query = query
        self.sort = "accuracy"
        page = 1
        size = 25
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(query)
    }
}


extension SearchRequestModel:Equatable {
    static func == (lhs:SearchRequestModel, rhs:SearchRequestModel) -> Bool {
        return lhs.query == rhs.query && lhs.sort == rhs.sort && lhs.page == rhs.page && lhs.size == rhs.size
    }
}


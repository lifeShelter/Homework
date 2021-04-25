//
//  ListCellViewModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct ListCellViewModel: Hashable {
    let thunmbnail:String
    let typeLabel:String
    let name:String
    let title:String
    let dateString:String
    let url:String
    let contents:String
    let date:Date
    var isOpenWebPage:Bool = false
    
    init(_ resultModel:BlogSearchResultModel) {
        self.thunmbnail = resultModel.thumbnail
        self.typeLabel = "B"
        self.name = resultModel.blogName
        self.title = resultModel.title
        self.url = resultModel.url
        self.contents = resultModel.contents
        guard let date = Constants.ISO8601StringToDate(resultModel.dateTime) else  {
            self.dateString = ""
            self.date = Date()
            return
        }
        self.date = date
        self.dateString = Constants.dateToDateString(date)
    }
    
    
    init(_ resultModel:CafeSearchResultModel) {
        self.thunmbnail = resultModel.thumbnail
        self.typeLabel = "C"
        self.name = resultModel.cafeName
        self.title = resultModel.title
        self.url = resultModel.url
        self.contents = resultModel.contents
        guard let date = Constants.ISO8601StringToDate(resultModel.dateTime) else  {
            self.dateString = ""
            self.date = Date()
            return
        }
        self.date = date
        self.dateString = Constants.dateToDateString(date)
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
}


extension ListCellViewModel:Equatable {
    static func == (lhs:ListCellViewModel, rhs:ListCellViewModel) -> Bool {
        return lhs.url == rhs.url
    }
}

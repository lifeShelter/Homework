//
//  ListCellViewModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct ListCellViewModel {
    let thunmbnail:String
    let label:String
    let name:String
    let title:String
    let dateString:String
    
    init(_ resultModel:BlogSearchResultModel) {
        self.thunmbnail = resultModel.thumbnail
        self.label = "B"
        self.name = resultModel.blogName
        self.title = resultModel.title
        guard let date = Constants.ISO8601StringToDate(resultModel.dateTime) else  {
            self.dateString = ""
            return
        }
        var dateString = ""
        if Constants.isToday(date) {
            dateString = "오늘"
        } else if Constants.isYesterday(date) {
            dateString = "어제"
        } else {
            dateString = Constants.dateToYYYYMMDDString(date)
        }
//        print("\(Constants.dateToYYYYMMDDString(date)),\(dateString)")
        self.dateString = dateString
    }
    
    
    init(_ resultModel:CafeSearchResultModel) {
        self.thunmbnail = resultModel.thumbnail
        self.label = "C"
        self.name = resultModel.cafeName
        self.title = resultModel.title
        guard let date = Constants.ISO8601StringToDate(resultModel.dateTime) else  {
            self.dateString = ""
            return
        }
        self.dateString = Constants.dateToYYYYMMDDString(date)
    }
}

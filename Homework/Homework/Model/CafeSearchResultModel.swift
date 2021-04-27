//
//  CafeSearchResultModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct CafeSearchResultModel : Codable, Hashable {
    let cafeName:String
    let contents:String
    let dateTime:String
    let thumbnail:String
    let title:String
    let url:String
    
    
    private enum CodingKeys:String, CodingKey {
        case cafeName = "cafename"
        case contents
        case dateTime = "datetime"
        case thumbnail
        case title
        case url
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
}


extension CafeSearchResultModel:Equatable {
    static func == (lhs:CafeSearchResultModel, rhs:CafeSearchResultModel) -> Bool {
        return lhs.cafeName == rhs.cafeName && lhs.contents == rhs.contents && lhs.dateTime == rhs.dateTime && lhs.thumbnail == rhs.thumbnail && lhs.title == rhs.title && lhs.url == rhs.url
    }
}

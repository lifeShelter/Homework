//
//  BlogSearchResultModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct BlogSearchResultModel : Codable, Hashable {
    let blogName:String
    let contents:String
    let dateTime:String
    let thumbnail:String
    let title:String
    let url:String
    
    
    private enum CodingKeys:String, CodingKey {
        case blogName = "blogname"
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


extension BlogSearchResultModel:Equatable {
    static func == (lhs:BlogSearchResultModel, rhs:BlogSearchResultModel) -> Bool {
        return lhs.blogName == rhs.blogName && lhs.contents == rhs.contents && lhs.dateTime == rhs.dateTime && lhs.thumbnail == rhs.thumbnail && lhs.title == rhs.title && lhs.url == rhs.url
    }
}

//
//  CafeSearchResultModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct CafeSearchResultModel : Codable {
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
}

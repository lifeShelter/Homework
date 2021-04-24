//
//  ServiceAPI.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


enum ServiceAPI : String {
    static let baseURL = "https://dapi.kakao.com"
    
    case blog = "/v2/search/blog"
    case cafe = "/v2/search/cafe"
    
    var urlString: String {
        return ServiceAPI.baseURL.appending(self.rawValue)
    }
}

//
//  MetaModel.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


struct MetaModel : Codable {
    let isEnd:Bool
    let pageableCount:Int
    let totalCount:Int
    
    
    private enum CodingKeys:String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

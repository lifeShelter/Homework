//
//  FilterEnum.swift
//  Homework
//
//  Created by 허원재 on 2021/04/23.
//

import Foundation


enum FilterEnum:String {
    case all
    case blog
    case cafe
    
    init?(rawValue:String) {
        switch rawValue {
        case "All" :
            self = .all
        case "Blog":
            self = .blog
        case "Cafe":
            self = .cafe
        default:
            self = .all
        }
    }
}

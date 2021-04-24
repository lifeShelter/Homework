//
//  Constants.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


class Constants {
    static let daumRestAPIKey = "9260f3dbe866ff9b5b79dbc84befa732"
    
    
    static func ISO8601StringToDate(_ str:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.date(from: str)
    }
    
    
    static func dateToYYYYMMDDString(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko")
        return dateFormatter.string(from: date)
    }
}

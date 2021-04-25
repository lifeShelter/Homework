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
    
    
    static func dateToDateString(_ date:Date, dateFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ko")
        return dateFormatter.string(from: date)
    }
    
    
    static func isToday(_ date:Date) -> Bool {
        let calendar =  Calendar.current
        return calendar.isDateInToday(date)
    }
    
    
    static func isYesterday(_ date:Date) -> Bool {
        let calendar =  Calendar.current
        return calendar.isDateInYesterday(date)
    }
    
    
    static func dateToDateString(_ date:Date) -> String {
        if isToday(date) {
           return "오늘"
        } else if isYesterday(date) {
            return "어제"
        } else {
            return dateToDateString(date,dateFormat: "yyyy년 MM월 dd일")
        }
    }
}

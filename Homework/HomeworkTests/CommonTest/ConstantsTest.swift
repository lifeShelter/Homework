//
//  ConstantsTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/26.
//

import XCTest

class ConstantsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsToday() throws {
        let today = Date()
        
        let isToday = Constants.isToday(today)
        let dateString = Constants.dateToDateString(today)
        
        XCTAssertEqual(isToday, true)
        XCTAssertEqual(dateString, "오늘")
    }
    
    
    func testIsYesterday() throws {
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to:Date())!
        
        let isToday = Constants.isToday(yesterDay)
        let isYesterday = Constants.isYesterday(yesterDay)
        let dateString = Constants.dateToDateString(yesterDay)
        
        XCTAssertEqual(isToday, false)
        XCTAssertEqual(isYesterday, true)
        XCTAssertEqual(dateString, "어제")
        XCTAssertNotEqual(dateString, "오늘")
    }
    
    
    func testDateToString() throws {
        let dateString = "2021년 04월 22일"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let date = formatter.date(from: dateString)!
        
        let compareString = Constants.dateToDateString(date)
        
        XCTAssertEqual(dateString, compareString)
        XCTAssertNotEqual("오늘",compareString)
        XCTAssertNotEqual("어제",compareString)
    }
    
    
    func testDateDisplayString() throws {
        let dateString = "2021-04-26 18:03"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = formatter.date(from: dateString)!
        
        let cellString = Constants.dateToDateString(date,dateFormat: "yyyy년 MM월 dd일")
        let detailString = Constants.dateToDateString(date, dateFormat: "yyyy년 MM월 dd일 a hh시 mm분")
        
        XCTAssertEqual(cellString, "2021년 04월 26일")
        XCTAssertEqual(detailString, "2021년 04월 26일 오후 06시 03분")
    }
    
    
    func testISOConvert() throws {
        let string =  "2021-04-25T19:18:55.000+09:00"
        let date = Constants.ISO8601StringToDate(string)
        let dateString = "2021-04-25 19:18:55"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let compareDate = formatter.date(from: dateString)!
        
        XCTAssertEqual(date, compareDate)
    }
}

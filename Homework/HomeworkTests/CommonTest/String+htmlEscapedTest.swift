//
//  String+htmlEscapedTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest

class String_htmlEscapedTest: XCTestCase {
    private let systemFont = UIFont.systemFont(ofSize: 15)
    private let colorHex = UIColor.black.hexDescription()

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    
    func testHtmlEscaped() throws {
        let expectedString = "02/21(일)한탄강<b>맛집</b>탐방-숙지사항,배차현황".htmlEscaped(font: systemFont, colorHex: colorHex, lineSpacing: 1.0, textAlignment: .center)
        let expectedString2 = "02/21(일)한탄강맛집탐방-숙지사항,배차현황".htmlEscaped(font: systemFont, colorHex: colorHex, lineSpacing: 1.0, textAlignment: .center)
        let expectedString3 =  "02/21(일)한탄강<b>맛집</b>탐방-숙지사항,배차현황".htmlEscaped(font: systemFont, colorHex: colorHex, lineSpacing: 1.0, textAlignment: .left)
        let string = "02/21(일)한탄강<b>맛집</b>탐방-숙지사항,배차현황"
        
        let attributedString = string.htmlEscaped(font: systemFont , colorHex: colorHex, lineSpacing: 1.0,  textAlignment: .center)
        
        XCTAssertEqual(attributedString, expectedString)
        XCTAssertNotEqual(attributedString, expectedString2)
        XCTAssertNotEqual(attributedString, expectedString3)
    }
    
    
    func testEmptyHtmlEscaped() throws {
        let expect = "\n".htmlEscaped(font: systemFont, colorHex: colorHex, lineSpacing: 1.0, textAlignment: .center)

        let result = "\0".htmlEscaped(font: systemFont, colorHex: colorHex, lineSpacing: 1.0, textAlignment: .center)
        let result2 = "".htmlEscaped(font: systemFont, colorHex: colorHex, lineSpacing: 1.0, textAlignment: .center)
                
        XCTAssertEqual(result, expect)
        XCTAssertEqual(result2, expect)
    }
}

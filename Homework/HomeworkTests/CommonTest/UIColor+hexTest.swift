//
//  UIColor+hexTest.swift
//  HomeworkTests
//
//  Created by 허원재 on 2021/04/27.
//

import XCTest

class UIColor_hexTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    
    func testHexDescryption() throws {
        let expactRedHex = "ff0000"
        let expactRedHexWithAlpha = "ff0000ff"
        let expactGreenHex = "00ff00"
        let expactGreenHexWithAlpha = "00ff00ff"
        
        let redHex = UIColor.red.hexDescription()
        let redHexWithAlpha = UIColor.red.hexDescription(true)
        let greenHex = UIColor.green.hexDescription()
        let greenHexWithAlpha = UIColor.green.hexDescription(true)
        
        
        XCTAssertEqual(redHex, expactRedHex)
        XCTAssertEqual(redHexWithAlpha, expactRedHexWithAlpha)
        XCTAssertEqual(greenHex, expactGreenHex)
        XCTAssertEqual(greenHexWithAlpha, expactGreenHexWithAlpha)
    }
    
    
    func testGrayScale() {
        let expectBlackHex = "000000"
        let expectBlackHexWithAlpha = "000000ff"
        let expectWhiteHex = "ffffff"
        let expectWhiteHexWithAlpha = "ffffffff"
        
        let blackHex = UIColor.black.hexDescription()
        let blackHexWithAlpha = UIColor.black.hexDescription(true)
        let whiteHex = UIColor.white.hexDescription()
        let whiteHexWithAlpha = UIColor.white.hexDescription(true)
        
        XCTAssertEqual(blackHex, expectBlackHex)
        XCTAssertEqual(blackHexWithAlpha, expectBlackHexWithAlpha)
        XCTAssertEqual(whiteHex, expectWhiteHex)
        XCTAssertEqual(whiteHexWithAlpha, expectWhiteHexWithAlpha)
    }
    
    
//    // light mode일때만 성공
//    func testLightModeLabelColor() throws {
//        let labelColor =  UIColor.label
//
//        let labelHex = labelColor.hexDescription()
//        let labelHexWithAlpha = labelColor.hexDescription(true)
//
//        XCTAssertEqual(labelHex, "000000")
//        XCTAssertEqual(labelHexWithAlpha, "000000ff")
//    }
//
//
//    // dark mode일때만 성공
//    func  testDarkModeLabelColor() throws {
//        let labelColor =  UIColor.label
//
//        let labelHex = labelColor.hexDescription()
//        let labelHexWithAlpha = labelColor.hexDescription(true)
//
//        XCTAssertEqual(labelHex, "ffffff")
//        XCTAssertEqual(labelHexWithAlpha, "ffffffff")
//    }
    
    
    func testNotRGBOrGrayHex() throws {
        let expectString = "Color not RGB or Gray."
        let notRGBOrGray = UIColor.init(cgColor: CGColor(genericCMYKCyan: 1.0, magenta: 1.0, yellow: 1.0, black: 1.0, alpha: 1.0))
        
        let notRGBOrGrayHex = notRGBOrGray.hexDescription()
        
        XCTAssertEqual(notRGBOrGrayHex, expectString)
    }
}

//
//  iOSAppTests.swift
//  iOSAppTests
//
//  Created by Munseok Park on 2020/08/15.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import XCTest

@testable import iOSApp
struct Year {
    let calendarYear:Int
    var isLeapYear:Bool{
        get {
            return calendarYear%4 == 0 && ( calendarYear%100 != 0 || calendarYear%400 == 0)
        }
    }
}

class iOSAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testVanillaLeapYear() {
        let year = Year(calendarYear: 1996)
        XCTAssertTrue(year.isLeapYear)
    }
    
    func testAnyOldYear() {
        let year = Year(calendarYear: 1997)
        XCTAssertTrue(!year.isLeapYear)
    }
    func testCentury() {
        let year = Year(calendarYear: 1900)
        XCTAssertTrue(!year.isLeapYear)
    }
    func testExceptionalCentury() {
        let year = Year(calendarYear: 2400)
        XCTAssertTrue(year.isLeapYear)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

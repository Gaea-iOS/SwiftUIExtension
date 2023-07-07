//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/7/7.
//

@testable import SwiftUIExtension
import XCTest

final class CalendarExtensionTests: XCTestCase {
    func testExample() throws {
        let calendar: Calendar = .init(identifier: .gregorian)
        let days = calendar.daysInWeekOfMonth(1, month: 7, year: 2023)
        
        XCTAssertEqual(days[0], .init(year: 2023, month: 6, day: 25))
        XCTAssertEqual(days[1], .init(year: 2023, month: 6, day: 26))
        XCTAssertEqual(days[2], .init(year: 2023, month: 6, day: 27))
        XCTAssertEqual(days[3], .init(year: 2023, month: 6, day: 28))
        XCTAssertEqual(days[4], .init(year: 2023, month: 6, day: 29))
        XCTAssertEqual(days[5], .init(year: 2023, month: 6, day: 30))
        XCTAssertEqual(days[6], .init(year: 2023, month: 7, day: 1))
    }
}

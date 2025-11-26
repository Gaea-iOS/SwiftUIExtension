//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/7/7.
//

@testable import SwiftUIExtension
@testable import MobileCore
import XCTest

final class CalendarExtensionTests: XCTestCase {
    func testExample() throws {
        let calendar: Calendar = .init(identifier: .gregorian)
        let days = calendar.datesInWeekOfMonth(1, month: 7, year: 2023)
        
        XCTAssertEqual(days[0], CalendarX.Day(year: 2023, month: 6, day: 25).date())
        XCTAssertEqual(days[1], CalendarX.Day(year: 2023, month: 6, day: 26).date())
        XCTAssertEqual(days[2], CalendarX.Day(year: 2023, month: 6, day: 27).date())
        XCTAssertEqual(days[3], CalendarX.Day(year: 2023, month: 6, day: 28).date())
        XCTAssertEqual(days[4], CalendarX.Day(year: 2023, month: 6, day: 29).date())
        XCTAssertEqual(days[5], CalendarX.Day(year: 2023, month: 6, day: 30).date())
        XCTAssertEqual(days[6], CalendarX.Day(year: 2023, month: 7, day: 1).date())
    }
}

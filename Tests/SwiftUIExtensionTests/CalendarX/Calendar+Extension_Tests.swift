//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/7/7.
//

@testable import SwiftUIExtension
import XCTest

struct Day: Equatable {
    let year: Int
    let month: Int
    let day: Int
}

final class CalendarExtensionTests: XCTestCase {
    func testExample() throws {
        let calendar = Calendar.autoupdatingCurrent
        let dates = calendar.datesInWeekOfMonth(1, month: 7, year: 2023)
        
        let day1 = calendar.day(of: dates[0])
        XCTAssertEqual(day1, .init(year: 2023, month: 6, day: 25))
        
        let day2 = calendar.day(of: dates[1])
        XCTAssertEqual(day2, .init(year: 2023, month: 6, day: 26))

        let day3 = calendar.day(of: dates[2])
        XCTAssertEqual(day3, .init(year: 2023, month: 6, day: 27))

        let day4 = calendar.day(of: dates[3])
        XCTAssertEqual(day4, .init(year: 2023, month: 6, day: 28))

        let day5 = calendar.day(of: dates[4])
        XCTAssertEqual(day5, .init(year: 2023, month: 6, day: 29))

        let day6 = calendar.day(of: dates[5])
        XCTAssertEqual(day6, .init(year: 2023, month: 6, day: 30))
        
        let day7 = calendar.day(of: dates[6])
        XCTAssertEqual(day7, .init(year: 2023, month: 7, day: 1))
    }
    

}


extension Calendar {
    func day(of date: Date) -> Day {
        let year = component(.year, from: date)
        let month = component(.month, from: date)
        let day = component(.day, from: date)
        return .init(year: year, month: month, day: day)
    }
}

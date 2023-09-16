// CalendarX+Month.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension CalendarX {
    public struct Month: Hashable, Equatable, Sendable, Codable {
        public let year: Int
        public let month: Int
        
        public let weeks: [Week]
        public let days: [Day]
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.year == rhs.year
            && lhs.month == rhs.month
        }

        public init(year: Int, month: Int) {
            self.year = year
            self.month = month
            
            weeks = Month.weeksInMonth(month, year: year)
            days = Month.daysInMonth(month, year: year)
        }
        
        public func next() -> Self {
            if month == 12 {
                return .init(year: year + 1, month: 1)
            } else {
                return .init(year: year, month: month + 1)
            }
        }
        
        public func previous() -> Self {
            if month == 1 {
                return .init(year: year - 1, month: 12)
            } else {
                return .init(year: year, month: month - 1)
            }
        }
    }
}

private extension CalendarX.Month {
    static func weeksInMonth(_ month: Int, year: Int) -> [CalendarX.Week] {
        let calendar = CalendarX.calendar
        let numberOfWeeks = calendar.numberOfWeeksInMonth(month, year: year)!
        let weeks: [CalendarX.Week] = (1 ... numberOfWeeks).map {
            .init(year: year, month: month, weekOfMonth: $0)
        }
        return weeks
    }
    
    static func daysInMonth(_ month: Int, year: Int) -> [CalendarX.Day] {
        let calendar = CalendarX.calendar
        let dates = calendar
            .datesInMonth(month, year: year)
        let days = dates.map(CalendarX.Day.init(date:))
        return days
    }
}

//extension CalendarX.Month: Comparable {
//    public static func < (lhs: Self, rhs: Self) -> Bool {
//        lhs.year < rhs.year
//            || (lhs.year == rhs.year && lhs.month < rhs.month)
//    }
//}

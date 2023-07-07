// CalendarX+Month.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension CalendarX {
    public struct Month: Hashable, Equatable, Sendable, Codable {
        public let year: Int
        public let month: Int

        public func weeks() -> [CalendarX.Week] {
            let calendar = CalendarX.calendar
            let numberOfWeeks = calendar.numberOfWeeksInYear(year, month: month)!
            let weeks: [Week] = (1 ... numberOfWeeks).map {
                .init(year: year, month: month, weekOfMonth: $0)
            }
            return weeks
        }
        
        public func days() -> [CalendarX.Day] {
            let calendar = CalendarX.calendar
            return calendar
                .datesInMonth(month, year: year)
                .map(Day.init(date:))
        }

        public init(year: Int, month: Int) {
            self.year = year
            self.month = month
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

extension CalendarX.Month: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.year < rhs.year
            || (lhs.year == rhs.year && lhs.month < rhs.month)
    }
}

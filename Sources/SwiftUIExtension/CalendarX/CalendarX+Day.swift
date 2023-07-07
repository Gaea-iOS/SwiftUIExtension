// CalendarX+Day.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

public struct CalendarX {
    static let calendar: Calendar = .autoupdatingCurrent
}

extension CalendarX {
    public  struct Day: Hashable, Equatable, Sendable, Codable {
        public let year: Int
        public let month: Int
        public let weekOfMonth: Int
        public let weekday: Int
        public let day: Int

        public var calendarWeek: CalendarX.Week {
            .init(year: year, month: month, weekOfMonth: weekOfMonth)
        }

        public var calendarMonth: CalendarX.Month {
            .init(year: year, month: month)
        }

        public var calendarYear: CalendarX.Year {
            .init(year: year)
        }

        private init(
            year: Int,
            month: Int,
            weekOfMonth: Int,
            weekday: Int,
            day: Int
        ) {
            self.year = year
            self.month = month
            self.weekOfMonth = weekOfMonth
            self.weekday = weekday
            self.day = day
        }

        public init(date: Date) {
            let calendar = CalendarX.calendar
            year = calendar.component(.year, from: date)
            month = calendar.component(.month, from: date)
            weekOfMonth = calendar.component(.weekOfMonth, from: date)
            weekday = calendar.component(.weekday, from: date)
            day = calendar.component(.day, from: date)
        }

        public func date() -> Date {
            let calendar = CalendarX.calendar
            return calendar.date(Ofyear: year, month: month, day: day)!
        }
    }
}

extension CalendarX.Day: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.year < rhs.year
            || (lhs.year == rhs.year && lhs.month < rhs.month)
            || (lhs.year == rhs.year && lhs.month == rhs.month && lhs.day < rhs.day)
    }
}

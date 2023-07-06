// CalendarX+Day.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

public struct CalendarX {}

extension CalendarX {
    public  struct Day: Hashable, Equatable, Codable {
        public let year: Int
        public let month: Int
        public let weekOfMonth: Int
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
            day: Int
        ) {
            self.year = year
            self.month = month
            self.weekOfMonth = weekOfMonth
            self.day = day
        }

        public init(date: Date) {
            let calendar = Calendar.current
            year = calendar.component(.year, from: date)
            month = calendar.component(.month, from: date)
            weekOfMonth = calendar.component(.weekOfMonth, from: date)
            day = calendar.component(.day, from: date)
        }

        public func date(in calendar: Calendar = .current) -> Date {
            .init(year: year, month: month, day: day, in: calendar)!
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

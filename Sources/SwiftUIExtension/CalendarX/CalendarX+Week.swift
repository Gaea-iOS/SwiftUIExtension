// CalendarX+Week.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension CalendarX {
    public struct Week: Hashable, Equatable, Sendable, Codable {
        public let year: Int
        public let month: Int
        public let weekOfMonth: Int
        public let days: [Day]

        public init(year: Int, month: Int, weekOfMonth: Int) {
            self.year = year
            self.month = month
            self.weekOfMonth = weekOfMonth
            
            let calendar = CalendarX.calendar
            self.days = calendar.daysInWeekOfMonth(
                weekOfMonth,
                month: month,
                year: year
            )
        }
    }
}

private extension CalendarX.Week {
    static func daysInWeekOfMonth(
        _ weekOfMonth: Int,
        month: Int,
        year: Int
    ) -> [CalendarX.Day] {
        let calendar = CalendarX.calendar
        let days = calendar.daysInWeekOfMonth(
            weekOfMonth,
            month: month,
            year: year
        )
        return days
    }
}

extension CalendarX.Week: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.year < rhs.year
            || (lhs.year == rhs.year && lhs.month < rhs.month)
            || (lhs.year == rhs.year && lhs.month == rhs.month && lhs.weekOfMonth < rhs.weekOfMonth)
    }
}

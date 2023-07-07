// CalendarX+Day.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

public struct CalendarX {
    public static let calendar: Calendar = .init(identifier: .gregorian)
}

extension CalendarX {
    public  struct Day: Hashable, Equatable, Sendable, Codable {
        public let year: Int
        public let month: Int
        public let weekOfMonth: Int
        public let weekday: Int
        public let day: Int
        
        init(year: Int, month: Int, day: Int) {
            var components: DateComponents = .init()
            components.year = year
            components.month = month
            components.day = day
            
            let calendar = CalendarX.calendar
            let date = calendar.date(from: components)!
            self.init(date: date)
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
        
        public func dayWithSameday(in month: CalendarX.Month) -> Self {
            let calendar = CalendarX.calendar
            let monthsDiff = month.month - self.month
            let date = calendar.date(date: date(), byAddingMonths: monthsDiff)
            return .init(date: date)
        }
        
        public func dayWithSameWeekday(in week: CalendarX.Week) -> Self {
            week.days.first { $0.weekday == weekday }!
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

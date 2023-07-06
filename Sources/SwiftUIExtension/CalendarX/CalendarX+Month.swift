// CalendarX+Month.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

public extension CalendarX {
    struct Month: Hashable, Equatable, Codable {
        public let year: Int
        public let month: Int

        public func weeks(in calendar: Calendar = .current) -> [Week] {
            let numberOfWeeks = calendar.numberOfWeeksInYear(year, month: month)!
            let weeks: [Week] = (1 ... numberOfWeeks).map {
                .init(year: year, month: month, weekOfMonth: $0)
            }
            return weeks
        }

        public init(year: Int, month: Int) {
            self.year = year
            self.month = month
        }
    }
}

extension CalendarX.Month: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.year < rhs.year
            || (lhs.year == rhs.year && lhs.month < rhs.month)
    }
}

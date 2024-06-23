// CalendarX+Year.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension CalendarX {
    public struct Year: Hashable, Equatable, Sendable, Codable {
        public let year: Int

        public let months: [Month]
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.year == rhs.year
        }

        public init(year: Int) {
            self.year = year
            
            months = Year.monthsInYear(year)
        }
    }
}

private extension CalendarX.Year {
    private static func monthsInYear(_ year: Int) -> [CalendarX.Month] {
        let months: [CalendarX.Month] = (1 ... 12).map {
            .init(year: year, month: $0)
        }
        return months
    }
}

//extension CalendarX.Year: Comparable {
//    public static func < (lhs: Self, rhs: Self) -> Bool {
//        lhs.year < rhs.year
//    }
//}

// CalendarX+Year.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension CalendarX {
    public struct Year: Hashable, Equatable, Sendable, Codable {
        public let year: Int

        public init(year: Int) {
            self.year = year
        }
        
        public func months() -> [Month] {
            let months: [CalendarX.Month] = (0 ... 12).map {
                .init(year: year, month: $0)
            }
            return months
        }
    }
}

extension CalendarX.Year: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.year < rhs.year
    }
}

// Date+Extension.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension Date {
    init?(year: Int, month: Int, day: Int, in calendar: Calendar = .current) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        if let date = calendar.date(from: dateComponents) {
            self = date
        } else {
            return nil
        }
    }
}

extension Date {
    func yearAndMonthInPastNYears(_ nYears: Int, in calendar: Calendar = .current) -> [(year: Int, month: Int)] {
        let currentYear = calendar.component(.year, from: self)
        let currentMonth = calendar.component(.month, from: self)

        var result: [(year: Int, month: Int)] = []

        for yearOffset in 0 ..< nYears {
            for monthOffset in 0 ..< 12 {
                let targetDate = calendar.date(byAdding: .month, value: -monthOffset, to: self)!
                let targetYear = calendar.component(.year, from: targetDate)
                let targetMonth = calendar.component(.month, from: targetDate)
                if targetYear == currentYear - yearOffset, targetYear < currentYear || (targetYear == currentYear && targetMonth <= currentMonth) {
                    result.append((targetYear, targetMonth))
                }
            }
        }

        return result
    }
}

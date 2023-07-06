// Calendar+Extension.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension Calendar {
    func datesInMonth(_ month: Int, year: Int) -> [Date] {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1

        guard let startDate = date(from: components),
              let endDate = date(byAdding: DateComponents(month: 1, day: -1), to: startDate)
        else {
            return []
        }

        var dates: [Date] = []
        var date = startDate
        while date <= endDate {
            dates.append(date)
            date = self.date(byAdding: .day, value: 1, to: date)!
        }

        return dates
    }

    func datesInWeekOfMonth(_ weekOfMonth: Int, month: Int, year: Int) -> [Date] {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.weekOfMonth = weekOfMonth
        components.weekday = firstWeekday

        guard let startDate = date(from: components) else {
            return []
        }

        var dates: [Date] = []
        var date = startDate
        for _ in 1 ... 7 {
            dates.append(date)
            date = self.date(byAdding: .day, value: 1, to: date)!
        }

        return dates
    }
}

extension Calendar {
    func numberOfWeeksInYear(_ year: Int, month: Int) -> Int? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = 1
        guard let date = date(from: dateComponents) else { return nil }
        let rangeOfWeeks = range(of: .weekOfMonth, in: .month, for: date)
        return rangeOfWeeks?.count
    }
}

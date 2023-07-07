// Calendar+Extension.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import Foundation

extension Calendar {
    func daysInMonth(_ month: Int, year: Int) -> [CalendarX.Day] {
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

        let days = dates.map(CalendarX.Day.init(date:))
        return days
    }
    
    func daysInWeekOfMonth(_ weekOfMonth: Int, month: Int, year: Int) -> [CalendarX.Day] {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.weekOfMonth = weekOfMonth
        dateComponents.weekday = firstWeekday
        
        guard let firstDayOfWeek = date(from: dateComponents) else {
            return []
        }
        
        let lastDayOfWeek = date(byAdding: .day, value: 6, to: firstDayOfWeek)!
        
        var dates = [Date]()
        var currentDate = firstDayOfWeek
        while currentDate <= lastDayOfWeek {
            dates.append(currentDate)
            currentDate = date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        let days = dates.map(CalendarX.Day.init(date:))
        return days
    }
}

extension Calendar {
    func numberOfWeeksInMonth(_ month: Int, year: Int) -> Int? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = 1

        guard let date = date(from: dateComponents) else { return nil }
        let rangeOfWeeks = range(of: .weekOfMonth, in: .month, for: date)
        return rangeOfWeeks?.count
    }
}

extension Calendar {
    func date(Ofyear year: Int, month: Int, day: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        if let date = self.date(from: dateComponents) {
            return date
        } else {
            return nil
        }
    }
}

extension Calendar {
    func pastNMonths(_ nMonths: Int, fromDate: Date) -> [CalendarX.Month] {
        let result: [CalendarX.Month] = (0 ..< nMonths).reversed()
            .map { monthOffset in
                let targetDate = date(byAdding: .month, value: -monthOffset, to: fromDate)!
                let year = component(.year, from: targetDate)
                let month = component(.month, from: targetDate)
                
                return .init(year: year, month: month)
            }

        return result
    }
}


extension Calendar {
    func date(date: Date, byAddingMonths months: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = months
        let date = self.date(byAdding: dateComponents, to: date)!
        return date
    }
}

// MonthCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI
import MobileCore

public struct MonthCalendarView<WeekView>: View where WeekView: View {
    public let month: CalendarX.Month
    public let calendar: Calendar
    public let spacing: CGFloat

    @ViewBuilder public let weekView: (CalendarX.Week, Calendar) -> WeekView
    
    public init(
        month: CalendarX.Month,
        in calendar: Calendar,
        spacing: CGFloat,
        @ViewBuilder weekView: @escaping (CalendarX.Week, Calendar) -> WeekView
    ) {
        self.month = month
        self.calendar = calendar
        self.spacing = spacing
        self.weekView = weekView
    }

    public var body: some View {
        let weeks = month.weeks(in: calendar)
        
        VStack(spacing: spacing) {
            ForEach(weeks.indices, id: \.self) { index in
                let week = weeks[index]
                weekView(week, calendar)
            }
        }
    }
}

struct MonthCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView(
            month: .init(year: 2023, month: 7),
            in: .init(identifier: .gregorian),
            spacing: 2
        ) { week, calendar in
            WeekCalendarView(
                week: week,
                in: calendar,
                spacing: 2,
                dayView: { day, _ in
                    DayView(day: day)
                }
            )
            .background(Color.yellow)
        }
        .background(Color.red)
    }
}

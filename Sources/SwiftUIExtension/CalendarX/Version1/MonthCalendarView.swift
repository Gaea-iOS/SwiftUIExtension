// MonthCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI
import MobileCore

public struct MonthCalendarView<WeekView>: View where WeekView: View {
    public let month: CalendarX.Month
    public let spacing: CGFloat

    @ViewBuilder public let weekView: (CalendarX.Week) -> WeekView
    
    public init(
        month: CalendarX.Month,
        spacing: CGFloat,
        @ViewBuilder weekView: @escaping (CalendarX.Week) -> WeekView
    ) {
        self.month = month
        self.spacing = spacing
        self.weekView = weekView
    }

    public var body: some View {
        let weeks = month.weeks
        
        VStack(spacing: spacing) {
            ForEach(weeks.indices, id: \.self) { index in
                let week = weeks[index]
                weekView(week)
            }
        }
    }
}

struct MonthCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView(
            month: .init(year: 2023, month: 7),
            spacing: 2
        ) { week in
            WeekCalendarView(
                week: week,
                spacing: 2,
                dayView: DayView.init(day:)
            )
            .background(Color.yellow)
        }
        .background(Color.red)
    }
}

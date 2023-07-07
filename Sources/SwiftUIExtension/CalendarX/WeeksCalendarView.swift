// WeeksCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI

public struct WeeksCalendarView<WeekView>: View where WeekView: View {
    public let weeks: [CalendarX.Week]

    @Binding public var currentWeek: CalendarX.Week

    @ViewBuilder public let weekView: (CalendarX.Week) -> WeekView
    
    public init(
        weeks: [CalendarX.Week],
        currentWeek: Binding<CalendarX.Week>,
        @ViewBuilder weekView: @escaping (CalendarX.Week) -> WeekView
    ) {
        self.weeks = weeks
        _currentWeek = currentWeek
        self.weekView = weekView
    }

    public var body: some View {
        TabView(selection: $currentWeek) {
            ForEach(weeks.indices, id: \.self) { index in
                let week = weeks[index]
                Color.clear.overlay(
                    alignment: .top
                ) {
                    weekView(
                        week
                    )
                    .tag(week)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct WeeksCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeeksCalendarView(
            weeks: [
                .init(year: 2023, month: 7, weekOfMonth: 2),
                .init(year: 2023, month: 3, weekOfMonth: 1),
                .init(year: 2022, month: 5, weekOfMonth: 3),
                .init(year: 2025, month: 7, weekOfMonth: 4),
            ],
            currentWeek: .constant(.init(year: 2023, month: 3, weekOfMonth: 1))
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

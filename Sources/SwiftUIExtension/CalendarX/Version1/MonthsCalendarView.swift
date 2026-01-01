// MonthsCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI
import MobileCore

public struct MonthsCalendarView<MonthView>: View where MonthView: View {
    public let months: [CalendarX.Month]
    public let calendar: Calendar
    @Binding public var currentMonth: CalendarX.Month

    @ViewBuilder public let monthView: (CalendarX.Month, Calendar) -> MonthView
    
    public init(
        months: [CalendarX.Month],
        in calendar: Calendar,
        currentMonth: Binding<CalendarX.Month>,
        @ViewBuilder monthView: @escaping (CalendarX.Month, Calendar) -> MonthView
    ) {
        self.months = months
        self.calendar = calendar
        _currentMonth = currentMonth
        self.monthView = monthView
    }

    public var body: some View {
        TabView(selection: $currentMonth) {
            ForEach(months, id: \.self) { month in
                Color.clear.overlay(
                    alignment: .top
                ) {
                    monthView(
                        month, calendar
                    )
                }
                .tag(month)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct MonthsCalendarView_Previews: PreviewProvider {
    static let months: [CalendarX.Month] = [
        .init(year: 2023, month: 7),
        .init(year: 2023, month: 5),
        .init(year: 2023, month: 1),
        .init(year: 2022, month: 8),
    ]
    @State static var currentMonth: CalendarX.Month = .init(year: 2022, month: 8)
    
    static var previews: some View {
        MonthsCalendarView(
            months: [
                .init(year: 2023, month: 7),
                .init(year: 2023, month: 6),
                .init(year: 2023, month: 7),
                .init(year: 2023, month: 4),
            ],
            in: .init(identifier: .gregorian),
            currentMonth: $currentMonth
        ) { month, calendar in
            MonthCalendarView(
                month: month,
                in: calendar,
                spacing: 2,
                weekView: { week, calendar in
                    WeekCalendarView(
                        week: week,
                        in: calendar,
                        spacing: 2,
                        dayView: { day, _ in
                            DayView(day: day)
                        }
                    )
                }
            )            
            .background(Color.yellow)
        }
        .background(Color.red)
    }
}

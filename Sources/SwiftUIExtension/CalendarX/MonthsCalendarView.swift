// MonthsCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI

public struct MonthsCalendarView<MonthView>: View where MonthView: View {
    public let months: [CalendarX.Month]

    @Binding public var currentMonth: CalendarX.Month

    @ViewBuilder public let monthView: (CalendarX.Month) -> MonthView
    
    public init(
        months: [CalendarX.Month],
        currentMonth: Binding<CalendarX.Month>,
        @ViewBuilder monthView: @escaping (CalendarX.Month) -> MonthView
    ) {
        self.months = months
        _currentMonth = currentMonth
        self.monthView = monthView
    }

    public var body: some View {
        TabView(selection: $currentMonth) {
            ForEach(months.indices, id: \.self) { index in
                let month = months[index]
                Color.clear.overlay(
                    alignment: .top
                ) {
                    monthView(
                        month
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
            currentMonth: $currentMonth
        ) { month in
            MonthCalendarView(
                month: month,
                spacing: 2,
                weekView: { week in
                    WeekCalendarView(
                        week: week,
                        spacing: 2,
                        dayView: DayView.init(day:)
                    )
                }
            )            
            .background(Color.yellow)
        }
        .background(Color.red)
    }
}

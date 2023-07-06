// MonthsCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI

public struct MonthsCalendarView<MonthView>: View where MonthView: View {
    public let months: [CalendarX.Month]
    public let spacing: CGFloat

    @Binding public var currentMonth: CalendarX.Month

    @ViewBuilder public let monthView: (CalendarX.Month) -> MonthView
    
    public init(
        months: [CalendarX.Month],
        spacing: CGFloat,
        currentMonth: Binding<CalendarX.Month>,
        monthView: @escaping (CalendarX.Month) -> MonthView
    ) {
        self.months = months
        self.spacing = spacing
        _currentMonth = currentMonth
        self.monthView = monthView
    }

    public var body: some View {
        PagingView(
            config: .init(margin: 0, spacing: spacing),
            page: Binding(
                get: {
                    months.firstIndex(of: currentMonth)!
                }, set: {
                    let currentIndex = months.firstIndex { $0 == currentMonth }
                    if $0 != currentIndex {
                        currentMonth = months[$0]
                    }
                }
            )
        ) {
            ForEach(months.indices, id: \.self) { index in
                let month = months[index]
                Color.clear.overlay(
                    alignment: .top
                ) {
                    monthView(
                        month
                    )
                    .tag(month)
                }
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
                .init(year: 2023, month: 5),
                .init(year: 2023, month: 1),
                .init(year: 2022, month: 8),
            ],
            spacing: 2,
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

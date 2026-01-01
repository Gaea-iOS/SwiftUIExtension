//
//  WeekView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/28.
//

import SwiftUI
import MobileCore

public struct WeekView<DayView>: View where DayView: View {
    public let week: CalendarX.Week
    public let calendar: Calendar
    public let spacing: CGFloat?

    @ViewBuilder private let dayView: (CalendarX.Day, Calendar) -> DayView
    
    public init(
        week: CalendarX.Week,
        in calendar: Calendar,
        spacing: CGFloat? = nil,
        @ViewBuilder dayView: @escaping (CalendarX.Day, Calendar) -> DayView
    ) {
        self.week = week
        self.calendar = calendar
        self.spacing = spacing
        self.dayView = dayView
    }

    public var body: some View {
        Grid(
            horizontalSpacing: nil,
            verticalSpacing: spacing
        ) {
            GridRow {
                let days = week.days(in: calendar)
                ForEach(days, id: \.self) { day in
                    dayView(day, calendar)
                }
            }
        }
    }
}

#Preview {
    WeekView(
        week: .init(
            year: 2023,
            month: 7,
            weekOfMonth: 1
        ),
        in: .init(identifier: .gregorian),
        spacing: 2,
        dayView: { day, _ in
            DayView(day: day)
        }
    )
    .background(Color.yellow)
}

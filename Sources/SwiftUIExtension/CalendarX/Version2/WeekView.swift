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
    let spacing: CGFloat?

    @ViewBuilder let dayView: (CalendarX.Day) -> DayView
    
    public init(
        week: CalendarX.Week,
        spacing: CGFloat? = nil,
        @ViewBuilder dayView: @escaping (CalendarX.Day) -> DayView
    ) {
        self.week = week
        self.spacing = spacing
        self.dayView = dayView
    }

    public var body: some View {
        Grid(
            horizontalSpacing: nil,
            verticalSpacing: spacing
        ) {
            GridRow {
                ForEach(week.days, id: \.self) { day in
                    dayView(day)
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
        spacing: 2,
        dayView: DayView.init(day:)
    )
    .background(Color.yellow)
}

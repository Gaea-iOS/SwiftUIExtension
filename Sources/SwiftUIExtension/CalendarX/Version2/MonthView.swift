//
//  MonthView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/26.
//

import SwiftUI
import MobileCore

public struct MonthView<DayView>: View where DayView: View {
    public let month: CalendarX.Month
    public let alignment: Alignment
    public let horizontalSpacing: CGFloat?
    public let verticalSpacing: CGFloat?
    
    @ViewBuilder public let dayView: (CalendarX.Day) -> DayView

    public init(
        month: CalendarX.Month,
        alignment: Alignment = .center,
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        @ViewBuilder dayView: @escaping (CalendarX.Day) -> DayView
    ) {
        self.month = month
        self.alignment = alignment
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.dayView = dayView
    }
        
    public var body: some View {
        Grid(
            alignment: alignment,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing
        ) {
            ForEach(month.weeks, id: \.self) { week in
                GridRow {
                    ForEach(week.days, id: \.self) { day in
                        dayView(day)
                    }
                }
            }
        }
    }
}


#Preview {
    MonthView(
        month: .init(year: 2023, month: 7),
        horizontalSpacing: 2,
        verticalSpacing: 2
    ) { day in
        DayView(day: day)
            .background(Color.yellow)
    }
    .background(Color.red)
}

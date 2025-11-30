//
//  CalendarView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/28.
//

import SwiftUI
import MobileCore

struct CalendarView<MonthView>: View where MonthView: View  {
    @State var months: [CalendarX.Month]
    @State var currentMonth: CalendarX.Month?

    let spacing: CGFloat?
    @ViewBuilder let monthView: (CalendarX.Month) -> MonthView

    public init(
        spacing: CGFloat? = nil,
        @ViewBuilder monthView: @escaping (CalendarX.Month) -> MonthView
    ) {
        let currentMonth: CalendarX.Month = .init(day: .today)
        self.currentMonth = currentMonth
        months = CalendarX.Month.nMonths(around: currentMonth)
        self.spacing = spacing
        self.monthView = monthView
    }

    public var body: some View {
        MonthsView(
            months: months,
            currentMonth: $currentMonth,
            spacing: spacing,
            monthView: monthView
        )
    }
}

extension CalendarX.Month {
    static func nMonths(around month: CalendarX.Month) -> [CalendarX.Month] {
        let months = ((month.year - 30)...(month.year + 20))
            .map(CalendarX.Year.init(year:))
            .map { $0.months }
            .flatten()
        
        return months
    }
}

#Preview {
    CalendarView(
        spacing: 8,
        monthView: { month in
            VStack {
                Text("\(month.year)年 \(month.month)月")
                MonthView(
                    month: month,
                    horizontalSpacing: 8,
                    verticalSpacing: 8
                ) { day in
                    Text("\(day.day)")
                        .foregroundStyle(month.month == day.month ? Color.black : Color.clear)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.green)
                }
                .background(Color.yellow)
            }
        }
    )
    .containerRelativeFrame([.horizontal], { length, _ in
        length * 0.9
    })
    .background(Color.red)
}

//
//  CalendarView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/28.
//

import SwiftUI
import MobileCore

public struct HCalendarView<MonthView>: View where MonthView: View  {
    @State private var months: [CalendarX.Month]
    @Binding private var selectedMonth: CalendarX.Month?

    public let spacing: CGFloat?
    @ViewBuilder private let monthView: (CalendarX.Month) -> MonthView

    public init(
        selectedMonth: Binding<CalendarX.Month?>,
        spacing: CGFloat? = nil,
        @ViewBuilder monthView: @escaping (CalendarX.Month) -> MonthView
    ) {
        _selectedMonth = selectedMonth
        months = CalendarX.Month.nMonths()
        self.spacing = spacing
        self.monthView = monthView
    }

    public var body: some View {
        HMonthsView(
            months: months,
            selectedMonth: $selectedMonth,
            spacing: spacing,
            monthView: monthView
        )
    }
}

extension CalendarX.Month {
    static func nMonths() -> [CalendarX.Month] {
        let currentMonth: CalendarX.Month = .current()
        let months = ((currentMonth.year - 100)...(currentMonth.year + 50))
            .map(CalendarX.Year.init(year:))
            .map { $0.months }
            .flatten()
        
        return months
    }
}

#Preview {
    @Previewable @State var selectedMonth: CalendarX.Month? = .init(year: 2023, month: 4)

    HCalendarView(
        selectedMonth: $selectedMonth,
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

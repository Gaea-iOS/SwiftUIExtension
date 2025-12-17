//
//  VMonthsView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/30.
//

import SwiftUI
import MobileCore

public struct VMonthsView<MonthView>: View where MonthView: View {
    public let months: [CalendarX.Month]
    @Binding private var selectedMonth: CalendarX.Month?
    public let horizontalSpacing: CGFloat?
    public let verticalSpacing: CGFloat?
    @ViewBuilder private let monthView: (CalendarX.Month) -> MonthView
        
    public init(
        months: [CalendarX.Month],
        selectedMonth: Binding<CalendarX.Month?>,
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        @ViewBuilder monthView: @escaping (CalendarX.Month) -> MonthView
    ) {
        self.months = months
        _selectedMonth = selectedMonth
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.monthView = monthView
    }

    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.vertical, showsIndicators: false) {
                let columns = [
                    GridItem(spacing: horizontalSpacing, alignment: .top),
                    GridItem(spacing: horizontalSpacing, alignment: .top)
                ]
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: verticalSpacing
                ) {
                    ForEach(months, id: \.self) { month in
                        monthView(
                            month
                        )
                        .containerRelativeFrame([.horizontal], { length, _ in
                            (length - (horizontalSpacing ?? 0)) / 2
                        })
                        .id(month)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $selectedMonth)
            .animation(.easeInOut, value: selectedMonth)
            .scrollTargetBehavior(.viewAligned)
            .task {
                scrollViewProxy.scrollTo(selectedMonth, anchor: .top)
            }
        }
    }
}

#Preview {
    @Previewable @State var currentMonth: CalendarX.Month? = .init(year: 2023, month: 6)
    
    VMonthsView(
        months: [
            .init(year: 2023, month: 3),
            .init(year: 2023, month: 4),
            .init(year: 2023, month: 5),
            .init(year: 2023, month: 6),
            .init(year: 2023, month: 7),
            .init(year: 2023, month: 8),
            .init(year: 2023, month: 9),
            .init(year: 2023, month: 10),
            .init(year: 2023, month: 11),
            .init(year: 2023, month: 12),
            .init(year: 2024, month: 1),
            .init(year: 2024, month: 2),
            .init(year: 2024, month: 3),
            .init(year: 2024, month: 4),
            .init(year: 2024, month: 5),
            .init(year: 2024, month: 6),
            
        ],
        selectedMonth: $currentMonth,
        horizontalSpacing: 12,
        verticalSpacing: 32
    ) { month in
        VStack {
            Text("\(month.year)年 \(month.month)月")
            MonthView(
                month: month,
                horizontalSpacing: 2,
                verticalSpacing: 2
            ) { day in
                    Text("\(day.day)")
                        .foregroundStyle(month.month == day.month ? Color.black : Color.clear)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(Color.green)
            }
            .background(Color.yellow)
            .frame(height: 200)
        }
    }
//    .containerRelativeFrame([.horizontal], { length, _ in
//        length * 0.9
//    })
    .background(Color.red)
}

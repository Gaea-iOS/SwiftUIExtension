//
//  MonthsView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/28.
//

import SwiftUI
import MobileCore

public struct HMonthsView<MonthView>: View where MonthView: View {
    public let months: [CalendarX.Month]
    @Binding private var currentMonth: CalendarX.Month?
    public let spacing: CGFloat?
    @ViewBuilder private let monthView: (CalendarX.Month) -> MonthView
    
    @State private var monthViewHeights: [CalendarX.Month : CGFloat] = [:]
    
    public init(
        months: [CalendarX.Month],
        currentMonth: Binding<CalendarX.Month?>,
        spacing: CGFloat? = nil,
        @ViewBuilder monthView: @escaping (CalendarX.Month) -> MonthView
    ) {
        self.months = months
        _currentMonth = currentMonth
        self.spacing = spacing
        self.monthView = monthView
    }

    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(
                    alignment: .top,
                    spacing: spacing
                ) {
                    ForEach(months, id: \.self) { month in
                        monthView(
                            month
                        )
                        .containerRelativeFrame([.horizontal], { length, _ in
                            length
                        })
                        .id(month)
                        .onGeometryChange(for: CGSize.self) { proxy in
                            proxy.size
                        } action: { newValue in
                            monthViewHeights[month] = newValue.height
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: monthViewHeights[currentMonth ?? months.first!])
            .scrollPosition(id: $currentMonth)
            .animation(.easeInOut, value: currentMonth)
            .scrollTargetBehavior(.viewAligned)
            .task {
                scrollViewProxy.scrollTo(currentMonth, anchor: .center)
            }
        }
    }
}

#Preview {
    @Previewable @State var currentMonth: CalendarX.Month? = .init(year: 2023, month: 4)
    
    HMonthsView(
        months: [
            .init(year: 2023, month: 3),
            .init(year: 2023, month: 4),
            .init(year: 2023, month: 5),
            .init(year: 2023, month: 6),
        ],
        currentMonth: $currentMonth,
        spacing: 8
    ) { month in
        VStack {
            Text("\(month.year)年 \(month.month)月")
            MonthView(
                month: month,
                horizontalSpacing: 16,
                verticalSpacing: 16
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
//    .containerRelativeFrame([.horizontal], { length, _ in
//        length * 0.9
//    })
    .background(Color.red)
}

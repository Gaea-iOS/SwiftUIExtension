//
//  MonthsView.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/11/28.
//

import SwiftUI
import MobileCore
import Collections

public struct HMonthsView<MonthView>: View where MonthView: View {
    public let months: OrderedSet<CalendarX.Month>
    public let calendar: Calendar
    @Binding private var selectedMonth: CalendarX.Month?
    public let spacing: CGFloat?
    @ViewBuilder private let monthView: (CalendarX.Month, Calendar) -> MonthView
    
    @State private var monthViewHeights: [CalendarX.Month : CGFloat] = [:]
    
    public init(
        months: OrderedSet<CalendarX.Month>,
        selectedMonth: Binding<CalendarX.Month?>,
        in calendar: Calendar,
        spacing: CGFloat? = nil,
        @ViewBuilder monthView: @escaping (CalendarX.Month, Calendar) -> MonthView
    ) {
        self.months = months
        _selectedMonth = selectedMonth
        self.calendar = calendar
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
                            month, calendar
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
            .frame(height: monthViewHeights[selectedMonth ?? months.first!])
            .scrollPosition(id: $selectedMonth)
            .animation(.easeInOut, value: selectedMonth)
            .scrollTargetBehavior(.viewAligned)
            .task {
                scrollViewProxy.scrollTo(selectedMonth, anchor: .center)
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedMonth: CalendarX.Month? = .init(year: 2023, month: 4)
    
    HMonthsView(
        months: [
            .init(year: 2023, month: 3),
            .init(year: 2023, month: 4),
            .init(year: 2023, month: 5),
            .init(year: 2023, month: 6),
        ],
        selectedMonth: $selectedMonth,
        in: .init(identifier: .gregorian),
        spacing: 8
    ) { month, calenar  in
        VStack {
            Text("\(month.year)年 \(month.month)月")
            MonthView(
                month: month,
                in: calenar,
                horizontalSpacing: 16,
                verticalSpacing: 16
            ) { day, _ in
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

// WeekCalendarView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/6.

import SwiftUI

public struct WeekCalendarView<DayView>: View where DayView: View {
    public let week: CalendarX.Week
    public let spacing: CGFloat

    @ViewBuilder public let dayView: (CalendarX.Day) -> DayView
    
    public init(
        week: CalendarX.Week,
        spacing: CGFloat,
        @ViewBuilder dayView: @escaping (CalendarX.Day) -> DayView
    ) {
        self.week = week
        self.spacing = spacing
        self.dayView = dayView
    }

    public var body: some View {
        let days = week.days()
        
        HStack(spacing: spacing) {
            ForEach(days.indices, id: \.self) { index in
                let day = days[index]
                dayView(day)
            }
        }
    }
}

struct WeekCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalendarView(
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
}

struct DayView: View {
    let height = 128.0
    let day: CalendarX.Day
    
    var body: some View {
        Color.clear
            .overlay(alignment: .bottom) {
                let random = Int(arc4random_uniform(100)) + 1
                let ratio = Double(random) / 100.0
                
                Color.blue
                    .frame(height: height * ratio)
                    .overlay(alignment: .bottom) {
                        Text("\(day.month).\(day.day)")
                            .foregroundColor(.white)
                            .padding(.bottom, 6)
                    }
            }
            .frame(height: height)
    }
}

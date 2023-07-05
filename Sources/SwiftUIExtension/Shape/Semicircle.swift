// Semicircle.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/5.

import SwiftUI

public struct Semicircle: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool

    public init(
        startAngle: Angle,
        clockwise: Bool = false
    ) {
        self.startAngle = startAngle
        endAngle = startAngle + Angle(degrees: 180)
        self.clockwise = clockwise
    }

    public func path(in rect: CGRect) -> Path {
        let radius: CGFloat = rect.width / 2

        var path = Path()
        path.addArc(
            center: CGPoint(
                x: rect.midX,
                y: rect.midY
            ),
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        return path
    }
}

struct Semicircle_Previews: PreviewProvider {
    static var previews: some View {
        Semicircle(
            startAngle: Angle(degrees: 180)
        )
        .background(Color.blue)
    }
}

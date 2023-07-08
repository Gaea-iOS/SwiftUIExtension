// Semicircle.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/7/5.

import SwiftUI

public func pointOnClosewiseCircle(
    withCenter center: CGPoint,
    radius: CGFloat,
    angle: Angle
) -> CGPoint {
    let x = center.x + radius * cos(angle.radians)
    let y = center.y + radius * sin(angle.radians)
    return .init(x: x, y: y)
}

public struct ClockwiseArc {
    public let startAngle: Angle
    public let endAngle: Angle
    let closewise: Bool = false
    
    init(
        startAngle: Angle,
        angle: Angle
    ) {
        self.startAngle = startAngle
        self.endAngle = startAngle + angle
    }
}

public struct Semicircle: Shape {
    public static let arc: ClockwiseArc = .init(
        startAngle: .init(degrees: 180),
        angle: .init(degrees: 180)
    )

    public func path(in rect: CGRect) -> Path {
        let radius: CGFloat = rect.width / 2
        let center: CGPoint = .init(
            x: rect.midX,
            y: rect.maxY
        )

        var path = Path()
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: Semicircle.arc.startAngle,
            endAngle: Semicircle.arc.endAngle,
            clockwise: Semicircle.arc.closewise
        )
        return path
    }
}

struct Semicircle_Previews: PreviewProvider {
    static let lineWidth: CGFloat = 26
    static var previews: some View {
        Semicircle(

        )
//        .fill(Color.red)
        .stroke(
            .linearGradient(
                colors: [
                    Color.red,
                    Color.green
                ],
                startPoint: .leading,
                endPoint: .trailing
            ),
            style: StrokeStyle(
                lineWidth: lineWidth,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .overlay(
            GeometryReader { geometry in
                let radius = geometry.size.width / 2
                let centerX = geometry.size.width / 2
                let centerY = geometry.size.height

                let point = pointOnClosewiseCircle(
                    withCenter: CGPoint(x: centerX, y: centerY),
                    radius: radius,
                    angle: Semicircle.arc.startAngle + Angle(degrees: 50)
                )

                Image(
                    systemName: "circle.hexagonpath"
                )
                .foregroundColor(Color.red)
                .background(Color.red)
                .frame(width: 13, height: 13)
                .position(point)
            }
        )
        .frame(width: 300, height: 150, alignment: .bottom)
        .background(Color.purple)
        .padding(lineWidth/2)
        .background(Color.blue)
    }
}

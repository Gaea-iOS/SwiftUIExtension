//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/5/3.
//

import Foundation
import SwiftUI

public struct Shake: GeometryEffect {
    let amount: CGFloat
    let shakesPerUnit: Int
    public var animatableData: CGFloat
    
    public init(
        amount: CGFloat = 10,
        shakesPerUnit: Int = 3,
        animatableData: CGFloat
    ) {
        self.amount = amount
        self.shakesPerUnit = shakesPerUnit
        self.animatableData = animatableData
    }

    public func effectValue(size _: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

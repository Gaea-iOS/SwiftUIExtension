//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/5/3.
//

import Foundation
import SwiftUI

public struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    public var animatableData: CGFloat

    public func effectValue(size _: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

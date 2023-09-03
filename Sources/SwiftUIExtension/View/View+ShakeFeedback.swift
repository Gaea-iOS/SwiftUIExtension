//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/9/3.
//

import UIKit
import SwiftUI

struct ShakeFeedbackModifier: ViewModifier {
    let feedback: ShakeFeedback

    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded {
                    feedback.action()
                }
            )
    }
}

public extension View {
    func shakeFeedbackOnTapGesture(feedback: ShakeFeedback) -> some View {
        modifier(ShakeFeedbackModifier(feedback: feedback))
    }
}


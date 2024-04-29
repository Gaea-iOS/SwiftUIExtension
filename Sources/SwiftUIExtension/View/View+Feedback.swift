//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/9/3.
//

import UIKit
import SwiftUI

struct FeedbackStyleModifier: ViewModifier {
    let feedback: FeedbackStyle

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
    func feedbackOnTapGesture(feedback: FeedbackStyle) -> some View {
        modifier(FeedbackStyleModifier(feedback: feedback))
    }
}


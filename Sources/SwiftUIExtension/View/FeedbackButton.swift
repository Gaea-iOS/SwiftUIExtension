//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/9/3.
//

import SwiftUI

public struct FeedbackButton<Label>: View where Label: View {
    let feedback: FeedbackStyle
    let action: () -> Void

    @ViewBuilder let label: () -> Label

    public init(
        feedback: FeedbackStyle = .selection,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.feedback = feedback
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(
            action: {
                action()
                feedback.action()
            },
            label: { label().contentShape(Rectangle()) }
        )
        .buttonStyle(ScaleFeedbackButtonStyle())
    }
}

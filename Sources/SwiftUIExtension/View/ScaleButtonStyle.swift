//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/6/30.
//

import SwiftUI

public struct ScaleFeedbackButtonStyle: ButtonStyle {
    private let scaleOnTap: Double
    
    @State private var scale = 1.0
    private let anchor: UnitPoint
    @State private var animation: Animation?
    
    public init(
        scale: Double = 0.95,
        anchor: UnitPoint = .center
    ) {
        scaleOnTap = scale
        self.anchor = anchor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(scale, anchor: anchor)
            .animation(animation, value: scale)
            .onChange(of: configuration.isPressed) { newValue in
                let animationDuration = 0.1
                if newValue {
                    scale = scaleOnTap
                    animation = .easeIn(duration: animationDuration)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        scale = 1.0
                        animation = .default
                    }
                }
            }
    }
}

struct ScaleFeedbackButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            print("fuck")
        } label: {
            Text("Start")
                .frame(height: 60)
                .frame(width: 100)
                .background(Color.red)
                .cornerRadius(12)
        }
        .padding()
        .buttonStyle(ScaleFeedbackButtonStyle(scale: 0.95))
    }
}

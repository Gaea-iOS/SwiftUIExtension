//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/6/30.
//

import SwiftUI

public struct ScaleFeedbackButtonStyle: ButtonStyle {
    public let scaleOnTap: Double
    
    @State private var scale = 1.0
    private let animationDuration = 0.1
    
    public init(scaleOnTap: Double = 0.98) {
        self.scaleOnTap = scaleOnTap
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(scale)
            .animation(.easeInOut(duration: animationDuration), value: scale)
            .onChange(of: configuration.isPressed) { newValue in
                if newValue {
                    scale = scaleOnTap
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        scale = 1.0
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
        .buttonStyle(ScaleFeedbackButtonStyle(scaleOnTap: 0.98))
    }
}

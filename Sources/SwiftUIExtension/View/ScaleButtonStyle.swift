//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/6/30.
//

import SwiftUI

public struct ScaleFeedbackButtonStyle: ButtonStyle {
    public let scaleOnTap: Double
    
    public init(scaleOnTap: Double = 0.95) {
        self.scaleOnTap = scaleOnTap
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleOnTap : 1.0 )
            .animation(.easeInOut, value: configuration.isPressed)
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
        .buttonStyle(ScaleFeedbackButtonStyle(scaleOnTap: 0.95))
    }
}

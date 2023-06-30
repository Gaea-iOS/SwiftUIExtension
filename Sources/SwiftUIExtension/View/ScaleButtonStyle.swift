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
    
    @State private var isTouching = false
    @State private var scale: Double = 1.0

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        // TouchDown detected
                        self.isTouching = true
                    }
                    .onEnded { _ in
                        // TouchUp detected
                        self.isTouching = false
                    }
            )
            .onChange(of: isTouching) { newValue in
                scale = newValue ? scaleOnTap : 1.0
            }
            .scaleEffect(scale)
            .animation(.easeInOut, value: scale)
    }
}

struct ScaleFeedbackButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            
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

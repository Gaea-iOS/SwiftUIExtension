//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/6/30.
//

import SwiftUI

public struct NoFeedbackButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct NoFeedbackButtonStyle_Previews: PreviewProvider {
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
        .buttonStyle(NoFeedbackButtonStyle())
    }
}

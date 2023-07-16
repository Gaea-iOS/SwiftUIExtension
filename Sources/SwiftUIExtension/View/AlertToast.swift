//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/7/16.
//

import SwiftUI

struct ToastModifier<Toast>: ViewModifier where Toast: View {
    @Binding var isPresenting: Bool
    
    @State var duration: Double = 2
    
    @State var tapToDismiss: Bool = true
    
    @ViewBuilder
    var toastView: () -> Toast
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            if isPresenting {
                toastView()
                    .animation(.spring(), value: isPresenting)
                    .transition(
                        .move(edge: .top)
                        .combined(with: .opacity)
                    )
            }
        }
    }
}

public extension View {
    func toast(
        isPresenting: Binding<Bool>,
        @ViewBuilder toastView: @escaping () -> some View
    ) -> some View{
        modifier(
            ToastModifier(
                isPresenting: isPresenting,
                toastView: toastView
            )
        )
    }
}

struct ToastModifier_Previews: PreviewProvider {
    
    @State private static var isPresented: Bool = false
    
    static var previews: some View {
        Color.red.toast(
            isPresenting: $isPresented,
            toastView: {
                Text("Fuck you")
                    .frame(width: 100, height: 50)
                    .background(Color.white)
                    .cornerRadius(12)
            }
        )
        .onAppear {
            isPresented = true
        }
    }
}

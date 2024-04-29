//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/4/29.
//

import SwiftUI

struct CustomBackBuggonModifier<BackButton: View>: ViewModifier {
    @ViewBuilder let backButton: () -> BackButton

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton())
    }
}

public extension View {
    func backButton(
        _ button: some View
    ) -> some View {
        modifier(
            CustomBackBuggonModifier(backButton: { button })
        )
    }

    func backButton(
        @ViewBuilder _ button: @escaping () -> some View
    ) -> some View {
        modifier(
            CustomBackBuggonModifier(backButton: button)
        )
    }
}

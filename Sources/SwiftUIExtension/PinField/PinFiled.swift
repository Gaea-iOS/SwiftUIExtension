// PinFiled.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/5/30.

import SwiftUI
import MobileCore

public struct PinField<Content: View>: View {
    @Binding var pin: Pin
    @ViewBuilder var content: () -> Content

    public init(
        pin: Binding<Pin>,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        _pin = pin
        self.content = content
    }

    public var body: some View {
        content()
            .background(
                inputField
            )
    }

    @ViewBuilder
    var inputField: some View {
        let text = Binding<String>(
            get: {
                pin.value
            },
            set: { newValue in
                guard newValue != pin.value else { return }
                pin.value = newValue
            }
        )

        SecureField("", text: text)
            .keyboardType(.numberPad)
            .foregroundColor(.clear)
            .accentColor(.clear)
            .textContentType(.password)
    }
}

struct PinField_Previews: PreviewProvider {
    @State static var pin: Pin = .init(length: .four)

    static var previews: some View {
        PinField(
            pin: $pin
        ) {
            Text("fuck")
        }
        .background(Color.red)
    }
}

//
//  PinSettingsField.swift
//  SwiftUICarousel
//
//  Created by Jerrywang on 2023/3/31.
//

import SwiftUI
import Combine

extension Double {
    static let verySamll = 1E-10
}

enum PinSetupFieldPhase {
    case pin1
    case pin2
}

public struct PinSetupField<Phase1: View, Phase2: View>: View {
    @State private var pin1: Pin
    @State private var pin2: Pin
    
    @Binding private var pin: Pin

    @State private var currentField: PinSetupFieldPhase = .pin1
    @FocusState private var focusedField: PinSetupFieldPhase?

    @ViewBuilder var phase1: (Pin) -> Phase1
    @ViewBuilder var phase2: (Pin) -> Phase2
        
    public init(
        pin: Binding<Pin>,
        @ViewBuilder phase1: @escaping (Pin) -> Phase1,
        @ViewBuilder phase2: @escaping (Pin) -> Phase2
    ) {
        self.pin1 = .init(length: pin.wrappedValue.length)
        self.pin2 = .init(length: pin.wrappedValue.length)
        _pin = pin
        self.phase1 = phase1
        self.phase2 = phase2
    }
    
    public var body: some View {
            TabView(selection: $currentField) {
                pinField1
                    .onChange(of: pin1.isDone) { isDone in
                        if isDone {
                            currentField = .pin2
                        }
                    }
                    .tag(PinSetupFieldPhase.pin1)
                    .background(Color.yellow)
                    .focused($focusedField, equals: .pin1)
                    .onChange(of: pin1) { _ in
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                
                pinField2
                    .onChange(of: pin2.isDone) { isDone in
                        guard isDone else { return }
                        if pin1.value == pin2.value {
                            pin = pin2
                        } else {
                            reset()
                        }
                    }
                    .tag(PinSetupFieldPhase.pin2)
                    .background(Color.green)
                    .focused($focusedField, equals: .pin2)
                    .onChange(of: pin2) { _ in
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
            }
            .onReceive(Just(currentField)) { newValue in
                focusedField = newValue
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeOut, value: currentField)
            .overlay(Color.white.opacity(.verySamll).onTapGesture {
                focusedField = currentField
            })
    }
    
    private func reset() {
        pin.reset()
        pin1.reset()
        pin2.reset()
        currentField = .pin1
    }
    
    @ViewBuilder var pinField1: some View {
        PinField(
            pin: $pin1,
            { phase1(pin1) }
        )
    }
    
    @ViewBuilder var pinField2: some View {
        PinField(
            pin: $pin2,
            { phase2(pin2) }
        )
    }
}


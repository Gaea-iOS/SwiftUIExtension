// AnimationCompletionObserverModifier.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/2/3.

import SwiftUI

struct AnimationObserverModifier<Value>: AnimatableModifier where Value: Equatable {
    // this is the view property that drives the animation - offset, opacity, etc.
    private let targetValue: Value
    private let onChanged: ((Value) -> Void)?
    private let onCompleted: ((Value) -> Void)?

    // SwiftUI implicity sets this value as the animation progresses
    var animatableData: Value {
        didSet {
            notifyProgress()
        }
    }

    init(
        for observedValue: Value,
        onChanged: ((Value) -> Void)?,
        onCompleted: ((Value) -> Void)?
    ) {
        animatableData = observedValue
        targetValue = observedValue
        self.onChanged = onChanged
        self.onCompleted = onCompleted
    }

    func body(content: Content) -> some View {
        content
    }

    private func notifyProgress() {
        DispatchQueue.main.async {
            onChanged?(animatableData)
            if animatableData == targetValue {
                onCompleted?(targetValue)
            }
        }
    }
}

extension View {
    func animationObserver<Value>(
        for value: Value,
        onChanged: ((Value) -> Void)? = nil,
        onCompleted: ((Value) -> Void)? = nil
    ) -> some View where Value: Equatable {
        modifier(
            AnimationObserverModifier(
                for: value,
                onChanged: onChanged,
                onCompleted: onCompleted
            )
        )
    }
}

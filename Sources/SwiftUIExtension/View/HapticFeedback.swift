// HapticFeedback.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/5/30.

import SwiftUI

struct HapticFeedback: ViewModifier {
    private let generator: UIImpactFeedbackGenerator

    init(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        generator = UIImpactFeedbackGenerator(style: style)
    }

    func body(content: Content) -> some View {
        content
            .onTapGesture(perform: generator.impactOccurred)
    }
}

public extension View {
    func hapticFeedbackOnTapGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) -> some View {
        modifier(HapticFeedback(style: style))
    }
}

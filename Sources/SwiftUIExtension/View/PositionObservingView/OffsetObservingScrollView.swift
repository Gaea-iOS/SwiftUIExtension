// OffsetObservingScrollView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/5/30.

import SwiftUI

/// Specialized scroll view that observes its content offset (scroll position)
/// and assigns it to the specified Binding.
public struct OffsetObservingScrollView<Content: View>: View {
    public var axes: Axis.Set = [.vertical]
    public var showsIndicators = true
    @Binding public var offset: CGPoint
    @ViewBuilder public var content: () -> Content

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()

    public init(
        axes: Axis.Set = [.vertical],
        showsIndicators: Bool = true,
        offset: Binding<CGPoint>,
        content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        _offset = offset
        self.content = content
    }

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

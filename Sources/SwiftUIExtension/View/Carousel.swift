
// Carousel.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/3/30.

import SwiftUI

public struct Carousel<Content: View>: View {
    public struct Config: Equatable {
        public let margin: CGFloat
        public let spacing: CGFloat

        public init(margin: CGFloat, spacing: CGFloat) {
            self.margin = margin
            self.spacing = spacing
        }
    }

    @State private var dragOffset: CGFloat = 0

    let config: Config
    let numberOfItems: Int
    let content: () -> Content

    @Binding private var currentIndex: Int
    
    private let animation: Animation? = .easeOut
    
    @GestureState private var isPressed: Bool = false

    public init(
        config: Config = .init(margin: 0, spacing: 0),
        numberOfItems: Int,
        currentIndex: Binding<Int>,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.config = config
        self.numberOfItems = numberOfItems
        _currentIndex = currentIndex
        self.content = content
    }

    private func cardLayout(ofIndex index: Int, in containerSize: CGSize, dragOffset: CGFloat) -> (size: CGSize, offset: CGFloat) {

        let containerWidth = containerSize.width

        let itemWidth = containerWidth - 2 * config.margin

        let cardMovement = itemWidth + config.spacing
        
        let cardSize = CGSize(width: itemWidth, height: containerSize.height)

        func offset(ofIndex index: Int, dragOffset: CGFloat) -> CGFloat {
            let offset = config.margin - cardMovement * CGFloat(index) + dragOffset
            return offset
        }
        
        var currentOffset = offset(ofIndex: index, dragOffset: dragOffset)
        let firstIndexOffset = offset(ofIndex: 0, dragOffset: 0)
        let lastIndexOffset = offset(ofIndex: numberOfItems - 1, dragOffset: 0)

        if currentOffset > firstIndexOffset {
            let deltaMove = currentOffset - firstIndexOffset
            let deltaMoveMax = containerWidth
            let factor = (deltaMoveMax * 2 - deltaMove) / (deltaMoveMax * 2)
            currentOffset = firstIndexOffset + deltaMove * max(0.5, factor)
        }
        if currentOffset < lastIndexOffset {
            let deltaMove = lastIndexOffset - currentOffset
            let deltaMoveMax = containerWidth
            let factor = (deltaMoveMax * 2 - deltaMove) / (deltaMoveMax * 2)
            currentOffset = lastIndexOffset - deltaMove * max(0.5, factor)
        }
        
        return (size: cardSize, offset: currentOffset)
    }

    public var body: some View {
        GeometryReader { proxy in
            let containerSize = proxy.frame(in: .global).size
            let cardLayout = self.cardLayout(ofIndex: currentIndex, in: containerSize, dragOffset: dragOffset)

            HStack(spacing: config.spacing) {
                content()
                .transition(AnyTransition.slide)
                .frame(
                    width: cardLayout.size.width,
                    height: cardLayout.size.height,
                    alignment: .center
                )
            }
            .offset(x: cardLayout.offset)
            .animation(animation, value: currentIndex)
            .animation(animation, value: cardLayout.offset)
            .animation(animation, value: config)
            .simultaneousGesture(
                DragGesture(
                    minimumDistance: 0
                )
                .updating($isPressed, body: { value, state, transaction in
                    state = true
                })
                .onChanged { state in
                    dragOffset = state.translation.width
                }
                .onEnded { state in
                    dragOffset = 0
                    let throld: CGFloat = 60
                    if state.translation.width < -throld, currentIndex < numberOfItems - 1 {
                        currentIndex += 1
                    } else if state.translation.width > throld, currentIndex > 0 {
                        currentIndex -= 1
                    }
                }
            )
            .onChange(of: isPressed) { newValue in
                if !newValue { dragOffset = 0 }
            }
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    struct Item {
        let color: Color
        let emoji: String
    }

    static var items: [Item] = [
        .init(color: .orange, emoji: "👻"),
        .init(color: .green, emoji: "🐱"),
        .init(color: .yellow, emoji: "🦊"),
        .init(color: .pink, emoji: "👺"),
        .init(color: .purple, emoji: "🎃")
    ]

    @State static var currentIndex: Int = 0

    static var previews: some View {
        Carousel(
            numberOfItems: items.count,
            currentIndex: $currentIndex
        ) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                let scale = index == currentIndex ? 1 : 0.7
                Text(item.emoji)
                    .font(.system(size: 150))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250)
                    .background(item.color)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding()
                    .background(Color.red)
                    .scaleEffect(y: scale)
            }
        }
        .frame(maxWidth: .infinity)
        .onChange(of: currentIndex) { _ in
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }
    }
}



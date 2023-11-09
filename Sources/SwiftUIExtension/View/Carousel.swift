// Carousel.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/5/30.

import SwiftUI

public struct Carousel<Content: View>: View {
    public struct Config: Equatable {
        enum MarginOrItemWidth: Equatable {
            case margin(CGFloat)
            case itemWidth(CGFloat)
            
            func itemWidth(containerWidth: CGFloat) -> CGFloat {
                switch self {
                case let .margin(margin):
                    containerWidth - 2 * margin
                case let .itemWidth(itemWidth):
                    itemWidth
                }
            }
            
            func margin(containerWidth: CGFloat) -> CGFloat {
                switch self {
                case let .margin(margin):
                    margin
                case let .itemWidth(itemWidth):
                    (containerWidth - itemWidth) / 2
                }
            }
        }
        
        let marginOrItemWidth: MarginOrItemWidth
        let spacing: CGFloat

        public init(margin: CGFloat, spacing: CGFloat) {
            self.marginOrItemWidth = .margin(margin)
            self.spacing = spacing
        }
        
        public init(itemWidth: CGFloat, spacing: CGFloat) {
            self.marginOrItemWidth = .itemWidth(itemWidth)
            self.spacing = spacing
        }
    }

    @State private var dragOffset: CGFloat = 0

    let config: Config
    let numberOfItems: Int
    let content: () -> Content

    @Binding private var currentIndex: CGFloat

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
        _currentIndex = .init(
            get: {
                CGFloat(currentIndex.wrappedValue)
            },
            set: { value in
                currentIndex.wrappedValue = Int(value)
            }
        )
        self.content = content
    }

    private func itemLayout(ofIndex index: CGFloat, in containerSize: CGSize, dragOffset: CGFloat) -> (size: CGSize, offset: CGFloat) {
        let containerWidth = containerSize.width

        let margin = config.marginOrItemWidth.margin(containerWidth: containerWidth)
        let itemWidth = config.marginOrItemWidth.itemWidth(containerWidth: containerWidth)

        let cardMovement = itemWidth + config.spacing

        let cardSize = CGSize(width: itemWidth, height: containerSize.height)

        func offset(ofIndex index: CGFloat, dragOffset: CGFloat) -> CGFloat {
            let offset = margin - cardMovement * index + dragOffset
            return offset
        }

        var currentOffset = offset(ofIndex: index, dragOffset: dragOffset)
        let firstIndexOffset = offset(ofIndex: 0, dragOffset: 0)
        let lastIndexOffset = offset(ofIndex: CGFloat(numberOfItems - 1), dragOffset: 0)

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
            let itemLayout = itemLayout(
                ofIndex: CGFloat(currentIndex),
                in: containerSize,
                dragOffset: dragOffset
            )

            HStack(spacing: config.spacing) {
                content()
                    .transition(AnyTransition.slide)
                    .frame(
                        width: itemLayout.size.width,
                        height: itemLayout.size.height,
                        alignment: .center
                    )
                    .clipped()
            }
            .offset(x: itemLayout.offset)
            .animation(animation, value: currentIndex)
            .animation(animation, value: itemLayout.offset)
            .animation(animation, value: config)
            .contentShape(Rectangle())
            .simultaneousGesture(
                DragGesture(
                    minimumDistance: 0
                )
                .updating($isPressed, body: { _, state, _ in
                    state = true
                })
                .onChanged { state in
                    dragOffset = state.translation.width
                    
                    let pageMoved = pageMoved(
                        movedDistance: state.translation.width,
                        itemWidth: itemLayout.size.width,
                        spacing: config.spacing
                    )

                    let newIndex = -pageMoved
                    if newIndex < 0 {
                        currentIndex = 0
                    } else if newIndex > CGFloat(numberOfItems - 1) {
                        currentIndex = CGFloat(numberOfItems - 1)
                    } else {
                        currentIndex = newIndex
                    }
                }
                .onEnded { state in
                    dragOffset = 0
//                    currentIndex = round(currentIndex)
                }
            )
            .onChange(of: isPressed) { newValue in
                if !newValue { dragOffset = 0 }
            }
        }
    }
    
    func pageMoved(
        movedDistance: CGFloat,
        itemWidth: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let pageWidth = itemWidth + spacing
        let pageMoved = movedDistance / pageWidth
        return pageMoved
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
            config: .init(itemWidth: 120, spacing: 2),
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
        .frame(width: 300)
        .background(Color.blue)
        .onChange(of: currentIndex) { _ in
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }
    }
}

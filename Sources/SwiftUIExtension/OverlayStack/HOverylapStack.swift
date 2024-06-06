//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/5/12.
//

import Foundation
import SwiftUI

public struct HOverylapStack: Layout {
    let overlapping: CGFloat
    
    public init(overlapping: CGFloat) {
        self.overlapping = overlapping
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        // Calculate and return the size of the layout container.
        let subviewSizes = subviews.map { proxy in
            proxy.sizeThatFits(proposal)
        }

        let combinedWidth = subviewSizes.map(\.width).reduce(0, +)
        let combineHeight = subviewSizes.map(\.height).max() ?? 0
        let realWidth = combinedWidth - overlapping * CGFloat(subviewSizes.count - 1)
        return .init(width: realWidth, height: combineHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        // Tell each subview where to appear.
        let subviewSizes = subviews.map { proxy in
            proxy.sizeThatFits(proposal)
        }

        var x = bounds.minX
        var y = 0.0
        for index in subviews.indices {
            let subviewSize = subviewSizes[index]
            let sizeProposal = ProposedViewSize(
                width: subviewSize.width,
                height: subviewSize.height
            )

            y = bounds.minY + (bounds.height - subviewSize.height) / 2
            subviews[index]
                .place(
                    at: .init(x: x, y: y),
                    anchor: .topLeading,
                    proposal: sizeProposal
                )

            x += subviewSize.width - overlapping
        }
    }
}

#Preview {
    HOverylapStack(overlapping: 10) {
        Color.red.frame(width: 100, height: 100)
        Color.yellow.frame(width: 30, height: 30)
        Color.blue.frame(width: 40, height: 40)
    }
    .background(Color.black)
}

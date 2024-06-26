//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/5/12.
//

import Foundation
import SwiftUI

public struct VOverylapStack: Layout {
    let overlapping: CGFloat
    
    public init(overlapping: CGFloat) {
        self.overlapping = overlapping
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        // Calculate and return the size of the layout container.
        let subviewSizes = subviews.map { proxy in
            proxy.sizeThatFits(proposal)
        }

        let combinedHeight = subviewSizes.map(\.height).reduce(0, +)
        let maxWidth = subviewSizes.map(\.width).max() ?? 0
        let realHeight = combinedHeight - overlapping * CGFloat(subviewSizes.count - 1)
        return .init(width: maxWidth, height: realHeight)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        // Tell each subview where to appear.
        let subviewSizes = subviews.map { proxy in
            proxy.sizeThatFits(proposal)
        }

        var x = 0.0
        var y = bounds.minY
        for index in subviews.indices {
            let subviewSize = subviewSizes[index]
            let sizeProposal = ProposedViewSize(
                width: subviewSize.width,
                height: subviewSize.height
            )

            let subview = subviews[index]
            
            x = bounds.minX + (bounds.width - subviewSize.width) / 2
            
            subview.place(
                    at: .init(x: x, y: y),
                    anchor: .topLeading,
                    proposal: sizeProposal
                )

            y += subviewSize.height - overlapping
        }
    }
}

#Preview {
    VOverylapStack(overlapping: 10) {
        Color.red.frame(width: 100, height: 100)
        Color.yellow.frame(width: 30, height: 30)
        Color.blue.frame(width: 40, height: 40)
    }
}

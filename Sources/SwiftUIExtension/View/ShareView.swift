//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/8/28.
//

import SwiftUI

public struct ShareView: UIViewControllerRepresentable {
    public typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    public let activityItems: [Any]
    public let applicationActivities: [UIActivity]? = nil
    public let excludedActivityTypes: [UIActivity.ActivityType]? = {
        var types: [UIActivity.ActivityType] = [
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .airDrop,
            .openInIBooks,
            .markupAsPDF
        ]
        
        
        if #available(iOS 15.4, *) {
            types.append(.sharePlay)
        }
        
        if #available(iOS 16.0, *) {
            types.append(
                contentsOf: [.collaborationInviteWithLink, .collaborationCopyLink]
            )
        }
        
        return types
    }()

    public let callback: Callback? = nil
    
    public init(activityItems: [Any]) {
        self.activityItems = activityItems
    }

    public func makeUIViewController(context _: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    public func updateUIViewController(_: UIActivityViewController, context _: Context) {
        // nothing to do here
    }
}

//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/5/3.
//

import SwiftUI

public struct ShareSheetView: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = {
        [
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .airDrop,
            .openInIBooks,
            .markupAsPDF,
            .sharePlay,
            .collaborationInviteWithLink,
            .collaborationCopyLink
        ]
    }()

    let callback: Callback? = nil
    
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

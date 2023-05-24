// ActivityView.swift
// Copyright (c) 2023 Nostudio
// Created by Jerry X T Wang on 2023/3/30.

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = {
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
            types.append(.collaborationInviteWithLink)
            types.append(.collaborationCopyLink)
        }

        return types
    }()

    let callback: Callback? = nil

    func makeUIViewController(context _: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_: UIActivityViewController, context _: Context) {
        // nothing to do here
    }
}

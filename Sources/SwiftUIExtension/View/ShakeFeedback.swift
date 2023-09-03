//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/9/3.
//

import UIKit

public enum ShakeFeedback {
    case selection

    case light
    case medium
    case heavy

    case success
    case error
    case warning

    var action: () -> Void {
        switch self {
        case .selection:
            return { UISelectionFeedbackGenerator().selectionChanged() }
        case .light:
            return { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        case .medium:
            return { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
        case .heavy:
            return { UIImpactFeedbackGenerator(style: .heavy).impactOccurred() }

        case .success:
            return { UINotificationFeedbackGenerator().notificationOccurred(.success) }
        case .error:
            return { UINotificationFeedbackGenerator().notificationOccurred(.error) }
        case .warning:
            return { UINotificationFeedbackGenerator().notificationOccurred(.warning) }
        }
    }
}

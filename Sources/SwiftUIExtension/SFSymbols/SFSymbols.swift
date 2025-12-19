//
//  SFSymbols.swift
//  SwiftUIExtension
//
//  Created by 王小涛 on 2025/12/17.
//


import Foundation
import SwiftUI

enum SFSymbols: String {
    case plusSquareDashed
    case checkmarkCircle
    case lockFill
    case lockOpenFill

    case hourglass
    case trashSlashFill
    case creditcard
    case keyViewfinder
    case handRaisedFill

    case giftFill
    case chevronForward

    case questionmarkCircle
    case lockSquareStackFill

    case pauseFill
    case checkmarkCircleFill
    case circle

    case laurelLeading
    case laurelTrailing

    case checkmarkSealFill

    case arrowCounterclockwise
    case listBulletRectanglePortraitFill
    case shieldLefthalfFilled

    case xmark
    case plus

    case appsIphone
    case iphoneGen2
    case plusCircleFill

    case arrowClockwise

    private var ignoreNumber: Bool {
        self == .iphoneGen2
    }

    var name: String {
        var result = ""
        rawValue.forEach { char in
            let string = String(char)
            if char.isLetter, char.isUppercase {
                result += "."
                result += string.lowercased()
            } else if char.isNumber, !ignoreNumber {
                let last = result.last!
                if last.isNumber {
                    result += string
                } else {
                    result += "."
                    result += string.lowercased()
                }
            } else {
                result += string
            }
        }
        return result
    }
}

extension Image {
    init(symbol: SFSymbols) {
        self = .init(systemName: symbol.name)
    }
}

extension Button where Label == SwiftUI.Label<Text, Image> {
    init(
        titleKey: LocalizedStringKey,
        symbol: SFSymbols,
        action: @escaping () -> Void
    ) {
        self = .init(titleKey, systemImage: symbol.name, action: action)
    }

    init(
        titleKey: LocalizedStringKey,
        symbol: SFSymbols,
        role: ButtonRole?,
        action: @escaping () -> Void
    ) {
        self = .init(titleKey, systemImage: symbol.name, role: role, action: action)
    }
}

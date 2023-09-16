//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/9/15.
//

import SwiftUI

public struct AdaptiveView<T: View, U: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let light: T
    let dark: U

    public init(light: T, dark: U) {
        self.light = light
        self.dark = dark
    }

    public init(light: () -> T, dark: () -> U) {
        self.light = light()
        self.dark = dark()
    }

    public var body: some View {
        if colorScheme == .light {
            light
        } else {
            dark
        }
    }
}

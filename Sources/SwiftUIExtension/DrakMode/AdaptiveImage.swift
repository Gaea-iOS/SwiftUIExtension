//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/9/15.
//

import SwiftUI

public struct AdaptiveImage: View {
    @Environment(\.colorScheme) var colorScheme
    let light: Image
    let dark: Image
    
    public init(light: Image, dark: Image) {
        self.light = light
        self.dark = dark
    }

    public var body: some View {
        if colorScheme == .light {
            light
        } else {
            dark
        }
    }
}

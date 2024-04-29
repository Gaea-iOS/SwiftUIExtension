//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/4/29.
//

import SwiftUI

public struct SplashScreen<SplashView, MainView>: View where SplashView: View, MainView: View {
    @State private var isActive: Bool = false

    private let splashViewShowDuration: CGFloat = 1.5

    @ViewBuilder let splashView: () -> SplashView
    @ViewBuilder let mainView: () -> MainView
    
    public init(
        splashView: @escaping () -> SplashView,
        mainView: @escaping () -> MainView
    ) {
        self.splashView = splashView
        self.mainView = mainView
    }

    public var body: some View {
        ZStack {
            if isActive {
                mainView()
            } else {
                splashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + splashViewShowDuration) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

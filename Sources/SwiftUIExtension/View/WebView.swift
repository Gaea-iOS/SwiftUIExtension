//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/8/29.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }

    public func makeUIView(context _: Context) -> some UIView {
        let webView = WKWebView(frame: .zero)

        webView.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        webView.scrollView.contentInset = .zero
        webView.scrollView.contentInsetAdjustmentBehavior = .never
//        webView.scrollView.showsVerticalScrollIndicator = false

        webView.load(URLRequest(url: url))
        return webView
    }

    public func updateUIView(_: UIViewType, context _: Context) {}
}

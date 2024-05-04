//
//  File.swift
//  
//
//  Created by 王小涛 on 2023/8/29.
//

import SwiftUI
import WebKit

import SwiftUI
import WebKit

public struct WebView: View {
    let webView = UIKitWebView()
    
    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public var body: some View {
        webView.onAppear {
            webView.loadURL(url)
        }
    }
}


struct UIKitWebView: UIViewRepresentable {
    let webView: WKWebView
    
    init() {
        self.webView = WKWebView()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func goBack(){
        webView.goBack()
    }
    
    func goForward(){
        webView.goForward()
    }
    
    
    func loadURL(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
}

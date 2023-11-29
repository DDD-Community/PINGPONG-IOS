//
//  WebView.swift
//  DesignSystem
//
//  Created by 서원지 on 11/27/23.
//  Copyright © 2023 Wonji Suh. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    
    //MARK: - 링크할 url
    var urlToLoad: String
    
    public init(urlToLoad: String) {
        self.urlToLoad = urlToLoad
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        
        //웹뷰 인스턴스 생성
        let configuration = WKWebViewConfiguration()
        let websiteDataStore = WKWebsiteDataStore.default()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
//        webView.scrollView.setZoomScale(0.3, animated: false)
        //웹뷰를 로드한다
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            let configuration = webView.configuration
            if let cookie = HTTPCookie(properties: [.domain: url.host!,
                                                    .path: "/",
                                                    .name: "CookieName",
                                                    .value: "CookieValue"]) {
                configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
            // Set power-saving preferences
            configuration.preferences.minimumFontSize = 16
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                webView.load(request)
            }
            
        }
        print("\(webView)")
        return webView
    }
    
    //업데이트 ui view
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}



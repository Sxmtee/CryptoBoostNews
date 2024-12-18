//
//  NewsDetail.swift
//  CryptoBoost
//
//  Created by mac on 18/12/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct NewsDetail: View {
    let article: Article
    
    private var abbreviatedTitle: String {
        let maxLength = 10
        return String(article.title.prefix(maxLength)) + (article.title.count > maxLength ? "..." : "")
    }
    
    var body: some View {
        WebView(urlString: article.link)
            .navigationTitle(abbreviatedTitle)
            .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NewsDetail()
//}

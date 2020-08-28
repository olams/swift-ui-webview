//
//  MyWebView.swift
//  WebViewTest
//
//  Created by Ola Marius Sagli on 28/07/2020.
//  Copyright © 2020 Ola Marius Sagli. All rights reserved.
//

import Foundation

import SwiftUI
import WebKit

struct DynamicWebView : View {
  
  @State private var webViewHeight: CGFloat = .zero
  var fileName:String
  
  var body: some View {

    VStack {
      WebViewUI(fileName: fileName, dynamicHeight: $webViewHeight)
    }.frame(height: CGFloat(webViewHeight))
      .onAppear {
    }
  }
}

// View holding article
struct WebViewUI : UIViewRepresentable {
    
    var fileName:String
    let webConfiguration = WKWebViewConfiguration()
    let contentController = WKUserContentController()
    @Binding var dynamicHeight: CGFloat
          
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.panGestureRecognizer.isEnabled = false;
        webView.scrollView.bounces = false;
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {

        uiView.navigationDelegate = context.coordinator
        let path = Bundle.main.path(forResource: fileName, ofType: "html")
        let request = URLRequest(url: URL(fileURLWithPath: path!))
      
        if uiView.url == nil {
          uiView.load(request)
        }
    }

    class Coordinator : NSObject, WKNavigationDelegate {
        
        var parent: WebViewUI
        
        init(_ parent: WebViewUI) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                     if complete != nil {
                         webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                          self.parent.dynamicHeight = webView.scrollView.contentSize.height
                         })
                     }
                 })
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

struct MyWebView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World asdf!")
    }
}

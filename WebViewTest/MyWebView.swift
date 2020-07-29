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

// Resizable list https://stackoverflow.com/questions/58060530/swiftui-resizable-list-height-that-dependent-on-an-element-count
struct WebViewRow : View {
  
  @State private var webViewHeight: CGFloat = .zero
  var fileName:String
  
  var body: some View {

    VStack {
      MyWebView(fileName: fileName, dynamicHeight: $webViewHeight)
    }.frame(height: CGFloat(webViewHeight))
  }
  
}

// View holding article
struct MyWebView : UIViewRepresentable {
    
  
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
        //let request = URLRequest(url: URL(string: article.HTMLcollapsedURL)!)
        uiView.load(request)
    }

    class Coordinator : NSObject, WKNavigationDelegate {
        
        var parent: MyWebView
        
        init(_ parent: MyWebView) {
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

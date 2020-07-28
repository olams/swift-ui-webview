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


// View holding article
struct MyWebView : UIViewRepresentable {
    
    let webConfiguration = WKWebViewConfiguration()
    let contentController = WKUserContentController()
    
    /*
    func createCssScript(cssFile:String) -> WKUserScript {
        
        let cssPath = Bundle.main.path(forResource: cssFile, ofType: "css")!
        let cssScriptString = """
            var link = document.createElement('link');
            link.href = '\(cssPath)';
            link.rel = 'stylesheet';
            document.head.appendChild(link);
        """
        
        return WKUserScript(source: cssScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
     */
    
    func makeUIView(context: Context) -> WKWebView {
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        /*
        let dictCssScript = createCssScript(cssFile: "dictionaries-v2")
        let accessibilityCss = createCssScript(cssFile: "accessibility")
        */
        // webConfiguration.userContentController.addUserScript(dictCssScript)
        // ebConfiguration.userContentController.addUserScript(accessibilityCss)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        // uiView.navigationDelegate = context.coordinator
        
        let path = Bundle.main.path(forResource: "test", ofType: "html")
        let request = URLRequest(url: URL(fileURLWithPath: path!))
        //let request = URLRequest(url: URL(string: article.HTMLcollapsedURL)!)
        uiView.load(request)
    }

    /*
    class Coordinator : NSObject, WKNavigationDelegate {
        
        var parent: ArticleView
        
        init(_ parent: ArticleView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    */
}

struct MyWebView_Previews: PreviewProvider {
    static var previews: some View {
        
        Text("Hello, World asdf!")
    }
}

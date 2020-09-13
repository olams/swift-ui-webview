//
//  ContentView.swift
//  WebViewTest
//
//  Created by Ola Marius Sagli on 28/07/2020.
//  Copyright © 2020 Ola Marius Sagli. All rights reserved.
//
//  https://useyourloaf.com/blog/using-dynamic-type-with-web-views/

import SwiftUI

struct ContentView: View {

  // URLs to fetch.
  var urls = [
    "https://jf-ne.clarify.no/api/articles/16364635-collapsed.html?preferredLocale=en&hostapp=ios",
    "https://jf-ne.clarify.no/api/articles/20060277-collapsed.html?preferredLocale=no&hostapp=ios",
    "https://jf-ne.clarify.no/api/articles/16255576-expanded.html?preferredLocale=no&hostapp=ios",
    "https://jf-ne.clarify.no/api/articles/16234076-collapsed.html?preferredLocale=no&hostapp=ios"
  ]
    
  var body: some View {
    
    GeometryReader { geometry in
      VStack {
        ScrollView {
          ForEach (self.urls, id:\.self) { u in
            HTMLView(htmlFetcher: HTMLFetcher(u), width: geometry.size.width).padding(0.4)
          }
        }
      }.background(Color.yellow)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

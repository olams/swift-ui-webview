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
  
  var urls = [
    "https://jf-ne.clarify.no/api/articles/16364635-collapsed.html?preferredLocale=en",
    "https://jf-ne.clarify.no/api/articles/16364635-expanded.html?preferredLocale=en",
    "https://jf-ne.clarify.no/api/articles/16364635-collapsed.html?preferredLocale=en",
    "https://jf-ne.clarify.no/api/articles/16364635-collapsed.html?preferredLocale=en"
  ]
  
  @State var labelHeight: CGFloat = .zero
  
  var body: some View {
    
    GeometryReader { geometry in

      ScrollView {
          HTMLView(urlString: "https://jf-ne.clarify.no/api/articles/16364635-expanded.html?preferredLocale=en")
          }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

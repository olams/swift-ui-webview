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
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack {
          Text ( "Webview in SwiftUI").font(.headline)
          DynamicWebView(fileName: "dynamictype").background(Color.red)
          
          Text ("UILabel with HTML").font(.headline)
          AsyncHTMLabel(urlString: "dynamictype", width: geometry.size.width)
        }
      }.background(Color.blue)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

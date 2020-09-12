//
//  HTMLFetcher.swift
//  WebViewTest
//
//  Created by Ola Marius Sagli on 12/09/2020.
//  Copyright © 2020 Ola Marius Sagli. All rights reserved.
//

import Foundation


public class HTMLFetcher : ObservableObject {

  var urlString:String = ""
  @Published var htmlContent:String?
  @Published var isFetched:Bool = false
  
  init(_ urlString:String) {
    self.urlString = urlString
    self.fetch()
  }
  
  
  func fetch() {

    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number
      self.htmlContent = "<h1>Hello world</h1> <ul> <li> one </li> <li> two </li> </ul>"
      self.isFetched = true
    }
  }
}

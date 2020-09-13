//
//  TemplateReader.swift
//  WebViewTest
//
//  Created by Ola Marius Sagli on 11/09/2020.
//  Copyright © 2020 Ola Marius Sagli. All rights reserved.
//

import Foundation

class TemplateReader {
  
  func readTemplate() -> String {
    let path = Bundle.main.path(forResource: "template", ofType: "html") // file path for file "data.txt"
    let string = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
    return string;
  }
  
  func format(html:String) -> String {
    
    let cssPath = Bundle.main.path(forResource: "dynamictype", ofType: "css")!
    var template = readTemplate()
    template = template.replacingOccurrences(of: "$body", with: html)
    template = template.replacingOccurrences(of: "$css", with: "file://\(cssPath)")
    return template
  }
}


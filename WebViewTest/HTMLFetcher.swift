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
  var attrString:NSAttributedString?
  
  init(_ urlString:String) {
    self.urlString = urlString
    self.fetch()
  }
  
  
  func fetch() {
    
     let url = URL(string: urlString)!
     
    print("Loading \(url)")
     let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
          guard let data = data else {
            
            print("ERROR \(error)")
            return
            
            
      }
       
      DispatchQueue.main.async {
           
          let htmlString = String(data: data, encoding: .utf8)!
          self.htmlContent = htmlString
          let templateReader = TemplateReader()
          let stringReplaced = templateReader.format(html: self.htmlContent!)
          self.attrString = try! NSAttributedString(data: stringReplaced.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
          self.isFetched = true
      }
     }
    task.resume()
  }
}

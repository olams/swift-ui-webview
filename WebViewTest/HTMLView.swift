//
//  AsyncHTMLLabel.swift
//  WebViewTest
//
//  Created by Ola Marius Sagli on 28/08/2020.
//  Copyright © 2020 Ola Marius Sagli. All rights reserved.
//

import Foundation
import SwiftUI

struct HTMLView : View {
  
  
  // var urlString:String
  @ObservedObject var htmlFetcher:HTMLFetcher
  var width:CGFloat

  var body : some View {
      
    VStack {
      if self.htmlFetcher.isFetched == false {
        Text("Loading...")
      }
      else {
        HTML(htmlContent: self.htmlFetcher.htmlContent!, width: width).frame(height: 400)
      }
    }
    .frame(width: width)
  }
}


struct HTML: UIViewRepresentable {

let htmlContent: String
var width: CGFloat

  func makeUIView(context: Context) -> UILabel {
  let label = UILabel()
  label.numberOfLines = 0
  label.lineBreakMode = .byWordWrapping
  label.autoresizesSubviews = true
  label.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
  label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  label.preferredMaxLayoutWidth = width
  return label
}

func updateUIView(_ uiView: UILabel, context: Context) {
  let templateReader = TemplateReader()
  let stringReplaced = templateReader.format(html: htmlContent)
  let attributedString = try! NSAttributedString(data: stringReplaced.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)

  uiView.attributedText = attributedString
  uiView.sizeToFit()
}
  
/*
func updateUIView(_ uiView: UILabel, context: Context) {
  
  let templateReader = TemplateReader()
  let url = URL(string: urlString)!
  
  let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
       guard let data = data else { return }
    
   
    DispatchQueue.main.async {
      
      let stringData = String(data: data, encoding: .utf8)!
      let stringReplaced = templateReader.format(html: htmlString)
       
      let attributedString = try! NSAttributedString(data: stringReplaced.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
      
      let height = attributedString.heightWithConstrainedWidth(width: self.width)

      uiView.attributedText = attributedString
      uiView.sizeToFit()
      self.height = height

    }
  }
  task.resume()
  }
 */
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.height
    }
}


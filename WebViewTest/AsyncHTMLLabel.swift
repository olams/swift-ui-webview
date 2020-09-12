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
  
  var urlString:String
  @State private var height: CGFloat = .zero

  var body : some View {
    GeometryReader { geometry in
      HTML(urlString: self.urlString, width: geometry.size.width, height: self.$height)
    }
  }
}


struct HTML: UIViewRepresentable {

let urlString: String
var width: CGFloat
@Binding var height: CGFloat

  
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
  let url = URL(string: urlString)!
  
  let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
       guard let data = data else { return }
    
   
    DispatchQueue.main.async {
      
      let stringData = String(data: data, encoding: .utf8)!
        let stringReplaced = templateReader.format(html: stringData)
       
      let attributedString = try! NSAttributedString(data: stringReplaced.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
      
      let height = attributedString.heightWithConstrainedWidth(width: self.width)
      print("Calculated height \(height)")
      uiView.attributedText = attributedString
      uiView.sizeToFit()
      self.height = height

    }
  }
  task.resume()
  }
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.height
    }
}


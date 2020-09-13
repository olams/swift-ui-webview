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
  
  @ObservedObject var htmlFetcher:HTMLFetcher
  var width:CGFloat

  var body : some View {
      
    VStack {
      if self.htmlFetcher.isFetched == false {
        HStack {
          Text("Loading...").padding(10)
        }.frame(width: width)
      }
      else {
        HTML(htmlContent: self.htmlFetcher.htmlContent!, width: width, attrString: self.htmlFetcher.attrString!)
      }
    }
    .background(Color.white)
    .frame(width: width)
  }
}


struct HTML: UIViewRepresentable {

  let htmlContent: String
  var width: CGFloat
  var attrString:NSAttributedString
  
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
    uiView.attributedText = attrString
  }
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.height
    }
}


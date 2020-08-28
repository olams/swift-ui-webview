//
//  AsyncHTMLLabel.swift
//  WebViewTest
//
//  Created by Ola Marius Sagli on 28/08/2020.
//  Copyright © 2020 Ola Marius Sagli. All rights reserved.
//

import Foundation
import SwiftUI

struct AsyncHTMLabel: UIViewRepresentable {

let urlString: String
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
  
  let path = Bundle.main.path(forResource: urlString, ofType: "html")
  let url = URL(fileURLWithPath: path!)
  
  DispatchQueue.main.async {
    let attributedString = try! NSAttributedString(url: url, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    uiView.attributedText = attributedString
    uiView.sizeToFit()
    }
  }
}

//
//  UIView+Extension.swift
//  TayasuiRecipes
//
//  Created by steph on 3/20/23.
//

import UIKit

extension UIView {
  var frameHeight: CGFloat {
    return frame.size.height
  }

  func roundCorners(_ radius: CGFloat? = nil) {
    guard let radius = radius else {
      layer.cornerRadius = frameHeight / 2
      return
    }
    layer.cornerRadius = radius
  }

  func configureBorder(_ color: UIColor, width: CGFloat = 1) {
    layer.borderWidth = width
    layer.borderColor = color.cgColor
  }
}

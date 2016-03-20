//
//  PushButtonView.swift
//  Flo
//
//  Created by Sendy Halim on 3/20/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import Chameleon

@IBDesignable
class PushButtonView: UIButton {
  @IBInspectable var isAddButton: Bool = true
  @IBInspectable var fillColor: UIColor = UIColor.flatGreenColor()

  override func drawRect(rect: CGRect) {
    let path = UIBezierPath(ovalInRect: rect)
    fillColor.setFill()
    path.fill()
    drawPlus()
  }

  func drawPlus() {
    let plusHeight: CGFloat = 3.0
    let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.4
    let plusPath = UIBezierPath()
    let middleX = bounds.width / 2
    let middleY = bounds.height / 2

    plusPath.lineWidth = plusHeight

    /// If you have oddly sized straight lines, you’ll need to position them at
    /// plus or minus 0.5 points to prevent anti-aliasing.
    /// If you look at the diagrams above, you’ll see that a half point on
    /// the iPad 2 will move the line up half a pixel, on the iPhone 6,
    /// up one whole pixel, and on the iPhone 6 Plus, up one and a half pixels.

    /// Draw the horizontal line
    plusPath.moveToPoint(CGPoint(
      x: middleX - (plusWidth / 2) + 0.5,
      y: middleY + 0.5
    ))

    plusPath.addLineToPoint(CGPoint(
      x: middleX + plusWidth / 2 + 0.5,
      y: middleY + 0.5
    ))

    if isAddButton {
      ///  Draw the vertical line
      plusPath.moveToPoint(CGPoint(
        x: middleX + 0.5,
        y: middleY - (plusWidth / 2) + 0.5
      ))

      plusPath.addLineToPoint(CGPoint(
        x: middleX + 0.5,
        y: middleY + (plusWidth / 2) + 0.5
      ))
    }

    UIColor.whiteColor().setStroke()
    plusPath.stroke()
  }
}

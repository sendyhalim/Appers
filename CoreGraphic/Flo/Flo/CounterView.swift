//
//  CounterView.swift
//  Flo
//
//  Created by Sendy Halim on 3/20/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import Chameleon
import RxSwift

let π = CGFloat(M_PI)
let NO_OF_GLASSES = 8

@IBDesignable
class CounterView: UIView {
  @IBInspectable var outlineColor: UIColor = UIColor.flatSkyBlueColor()
  @IBInspectable var counterColor: UIColor = UIColor.flatOrangeColor()

  var counter: Variable<Int> = Variable(5)

  override func drawRect(rect: CGRect) {
    let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    let radius = min(bounds.width, bounds.height) / 2
    let arcWidth = CGFloat(76)
    let startAngle = 3 * π / 4
    let endAngle = π / 4
    let angleDifference = 2 * π - startAngle + endAngle
    let arcLengthPerGlass = angleDifference / CGFloat(NO_OF_GLASSES)
    let outlineEndAngle = (arcLengthPerGlass * CGFloat(counter.value)) + startAngle

    let path = UIBezierPath(
      arcCenter: center,
      radius: radius - arcWidth / 2,
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: true
    )
    path.lineWidth = arcWidth
    counterColor.setStroke()
    path.stroke()


    // Outer arc
    let outlinePath = UIBezierPath(
      arcCenter: center,
      radius: radius - 2.5,
      startAngle: startAngle,
      endAngle: outlineEndAngle,
      clockwise: true
    )

    // Inner arc
    outlinePath.addArcWithCenter(
      center,
      radius: radius - arcWidth + 2.5,
      startAngle: outlineEndAngle,
      endAngle: startAngle,
      clockwise: false
    )
    outlinePath.closePath()

    outlineColor.setStroke()
    outlinePath.lineWidth = 5.0
    outlinePath.stroke()

    let context = UIGraphicsGetCurrentContext()
    CGContextSaveGState(context)
    outlineColor.setFill()

    let markerWidth: CGFloat = 5.0
    let markerHeight: CGFloat = 10.0
    let markerPath = UIBezierPath(rect: CGRect(
      x: (-markerWidth / 2),
      y: 0,
      width: markerWidth,
      height: markerHeight
    ))

    CGContextTranslateCTM(context, rect.width / 2, rect.height / 2)
    // The drawn rectangle has angle equals to 90 degrees, 
    // we're reducing it by 90 degrees (half radian), 
    // because 0 degree is located at 3 o'clock
    let zeroDegree = -(π / 2)

    for i in 1...NO_OF_GLASSES {
      CGContextSaveGState(context)
      let angle = zeroDegree + startAngle + (arcLengthPerGlass * CGFloat(i))
      CGContextRotateCTM(context, angle)
      CGContextTranslateCTM(context, 0, (rect.height / 2) - markerHeight)
      markerPath.fill()
      CGContextRestoreGState(context)
    }


    // Restore the original state in case of more painting
    CGContextRestoreGState(context)
  }
}

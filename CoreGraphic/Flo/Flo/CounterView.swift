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
  }
}

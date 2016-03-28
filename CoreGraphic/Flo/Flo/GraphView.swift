//
//  GraphView.swift
//  Flo
//
//  Created by Sendy Halim on 3/21/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import Chameleon

@IBDesignable
class GraphView: UIView {

  @IBInspectable var startColor: UIColor = UIColor.flatBlueColor()
  @IBInspectable var endColor: UIColor = UIColor.flatSkyBlueColor()

  let graphPoints = [4, 2, 6, 4, 5, 8, 3]

  override func drawRect(rect: CGRect) {
    let width = rect.width
    let height = rect.height
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: UIRectCorner.AllCorners,
      cornerRadii: CGSize(width: 8.0, height: 8.0)
    )
    path.addClip()

    let context = UIGraphicsGetCurrentContext()
    let colors = [startColor.CGColor, endColor.CGColor]
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let colorLocations: [CGFloat] = [0.0, 1.0]
    let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)


    // Draw the gradient
    let startPoint = CGPoint.zero
    let endPoint = CGPoint(x: 0, y: bounds.height)
    CGContextDrawLinearGradient(
      context,
      gradient,
      startPoint,
      endPoint,
      CGGradientDrawingOptions.DrawsBeforeStartLocation
    )

    let margin: CGFloat = 20.0
    let totalPoints = graphPoints.count
    let spacer = (width - margin * 2) / CGFloat(totalPoints - 1)
    let columnXPoint = {
      (column: Int) -> CGFloat in
      let x: CGFloat = CGFloat(column) * spacer

      return x + margin
    }

    let topBorder: CGFloat = 60
    let bottomBorder: CGFloat = 50
    let graphHeight = height - topBorder - bottomBorder
    let maxValue = CGFloat(graphPoints.maxElement()!)
    let rangePerPointY = graphHeight / maxValue
    let columnYPoint = {
      (graphPoint: Int) -> CGFloat in
      let y: CGFloat = CGFloat(graphPoint) * rangePerPointY
      return graphHeight + topBorder - y // Flip the graph
    }

    UIColor.whiteColor().setFill()
    UIColor.whiteColor().setStroke()

    let graphPath = UIBezierPath()

    graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints.first!)))

    for i in 1..<graphPoints.count {
      let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
      graphPath.addLineToPoint(nextPoint)
    }

    graphPath.stroke()
  }
}

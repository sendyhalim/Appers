//
//  ViewController.swift
//  Gradient Background
//
//  Created by Sendy Halim on 3/19/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import Chameleon

/// Reference http://blog.apoorvmote.com/gradient-background-uiview-ios-9-swift
class ViewController: UIViewController {
  let gradientLayer = CAGradientLayer()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.flatLimeColor()

    gradientLayer.frame = view.bounds
    let color1 = UIColor.flatSkyBlueColor().CGColor as CGColorRef
    let color2 = UIColor.flatMintColor().CGColor as CGColorRef
    let color3 = UIColor.flatMagentaColor().CGColor as CGColorRef
    gradientLayer.colors = [color1, color2, color3]

    view.layer.addSublayer(gradientLayer)
    animate()
  }

  func animate() {
    let fromColors = gradientLayer.colors
    let toColors = [
      UIColor.flatMintColor().CGColor as CGColorRef,
      UIColor.flatMagentaColor().CGColor as CGColorRef,
      UIColor.flatSkyBlueColor().CGColor as CGColorRef,
    ]

    let animation: CABasicAnimation = CABasicAnimation(keyPath: "colors")
    animation.fromValue = fromColors
    animation.toValue = toColors
    animation.duration = 3.00
    animation.removedOnCompletion = false
    animation.autoreverses = true
    animation.fillMode = kCAFillModeForwards
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.repeatCount = Float.infinity
    animation.delegate = self
    gradientLayer.addAnimation(animation, forKey: "animateGradient")

    // let radiansToRotate = CGFloat(90 * M_PI / 180)
    // let transform = CATransform3DMakeRotation(radiansToRotate, 0, 0, 1.0)
    // gradientLayer.transform = transform
  }
}

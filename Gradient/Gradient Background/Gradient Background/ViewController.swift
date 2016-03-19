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
    let color4 = UIColor.flatRedColor().CGColor as CGColorRef
    gradientLayer.colors = [color1, color2, color3, color4]

    view.layer.addSublayer(gradientLayer)
  }
}

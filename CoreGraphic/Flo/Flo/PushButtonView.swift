//
//  PushButtonView.swift
//  Flo
//
//  Created by Sendy Halim on 3/20/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit

class PushButtonView: UIButton {
  override func drawRect(rect: CGRect) {
    let path = UIBezierPath(ovalInRect: rect)
    UIColor.greenColor().setFill()
    path.fill()
  }
}

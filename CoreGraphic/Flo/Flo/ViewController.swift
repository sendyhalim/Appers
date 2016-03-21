//
//  ViewController.swift
//  Flo
//
//  Created by Sendy Halim on 3/20/16.
//  Copyright © 2016 Sendy Halim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var graphView: GraphView!
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var counterView: CounterView!
  @IBOutlet weak var decrementButton: PushButtonView!
  @IBOutlet weak var incrementButton: PushButtonView!

  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    counterView
      .counter
      .asDriver()
      .filter {
        $0 < NO_OF_GLASSES && $0 > 0
      }
      .driveNext { [unowned self] in
        self.counterView.setNeedsDisplay()
        self.counterLabel.text = "\($0)"
      }.addDisposableTo(disposeBag)

    incrementButton
      .rx_tap
      .subscribeNext { [unowned self] in
        self.counterView?.counter.value++
      }
      .addDisposableTo(disposeBag)


    decrementButton
      .rx_tap
      .subscribeNext { [unowned self] in
        self.counterView?.counter.value--
      }
      .addDisposableTo(disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

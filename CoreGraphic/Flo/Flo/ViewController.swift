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

  var isGraphShowing = false

  override func viewDidLoad() {
    super.viewDidLoad()

    prepareGestureRecognizers()

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
      .subscribeNext { [weak self] in
        guard let strongSelf = self else {
          return
        }

        strongSelf.counterView.counter.value = strongSelf.counterView.counter.value + 1
        strongSelf.onContainerViewTapped(nil)
      }
      .addDisposableTo(disposeBag)


    decrementButton
      .rx_tap
      .subscribeNext { [weak self] in
        guard let strongSelf = self else {
          return
        }

        strongSelf.counterView.counter.value = strongSelf.counterView.counter.value - 1
        strongSelf.onContainerViewTapped(nil)
      }
      .addDisposableTo(disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func prepareGestureRecognizers() {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(ViewController.onContainerViewTapped(_:))
    )
    containerView.addGestureRecognizer(tap)
  }

  func onContainerViewTapped(sender: UITapGestureRecognizer?) {
    if isGraphShowing {
      let options = UIViewAnimationOptions.TransitionFlipFromLeft.union(.ShowHideTransitionViews)
      UIView.transitionFromView(
        graphView,
        toView: counterView,
        duration: 1.0,
        options: options,
        completion: nil
      )
    } else {
      let options = UIViewAnimationOptions.TransitionFlipFromRight.union(.ShowHideTransitionViews)
      UIView.transitionFromView(
        counterView,
        toView: graphView,
        duration: 1.0,
        options: options,
        completion: nil
      )
    }

    isGraphShowing = !isGraphShowing
  }
}

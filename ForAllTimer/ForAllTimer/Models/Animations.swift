//
//  Animations.swift
//  ForAllTimer
//
//  Created by Logan Melton on 21/7/25.
//

import Foundation
import UIKit

struct Animations {
  var object = CAShapeLayer()
  
  func animate(totalTime: Int) {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = (Double(totalTime) + 0.9)
    animation.isRemovedOnCompletion = false
    animation.fillMode = .forwards
    object.add(animation, forKey: "animation")
  }
  
  func pulsate(totalTime: Int) {
    let pulsation = CABasicAnimation(keyPath: "lineWidth")
    pulsation.fromValue = 10
    pulsation.toValue = 30
    pulsation.duration = Double(totalTime) / 2
    pulsation.autoreverses = true
    object.add(pulsation, forKey: "pulsate")
  }
}

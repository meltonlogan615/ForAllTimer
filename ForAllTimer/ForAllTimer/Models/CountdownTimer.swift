//
//  CountdownTimer.swift
//  ForAllTimer
//
//  Created by Logan Melton on 21/7/25.
//

import Foundation
import UIKit


class CountdownTimer: UIViewController {
  var totalTime: Float = 0
  var timerLabel = UILabel()
  var animations = Animations()
  var timer = Timer()
  let viewSetup = ViewController()
    
  init(totalTime: Float, timerLabel: UILabel, animations: Animations) {
    super.init(nibName: nil, bundle: nil)
    self.totalTime = totalTime
    self.timerLabel = timerLabel
    self.animations = animations
  }

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startTimer(time: Int) {
    totalTime = Float(time)
    var timeRemaining: Float = 0
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) {
      timer in
      if timeRemaining < self.totalTime {
        timeRemaining += 0.02
        let tickTock = self.totalTime - timeRemaining
        self.timerLabel.text = String(format: "%.2f", tickTock)
        
      } else {
        self.timerLabel.text = "0.00"
        self.endTimer()
      }
    }
  }
  
  func endTimer() {
    let alert = UIAlertController(title: "Timer Complete", message: "", preferredStyle: .alert)
    let closeAlert = UIAlertAction(title: "Dismiss", style: .default)
    alert.addAction(closeAlert)
    
    let repeatTimer = UIAlertAction(title: "Repeat", style: .default) {_ in
      self.startTimer(time: Int(self.totalTime))
      self.animations.pulsate(totalTime: Int(self.totalTime))
      self.animations.animate(totalTime: Int(self.totalTime))
      
    }
    alert.addAction(repeatTimer)
    self.present(alert, animated: true)
    timer.invalidate()
  }
}

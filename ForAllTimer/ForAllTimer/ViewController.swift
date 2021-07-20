//
//  ViewController.swift
//  ForAllTimer
//
//  Created by Logan Melton on 21/7/18.
//

import UIKit

class ViewController: UIViewController {
  
  var totalTime: Float = 0
  
  var timer = Timer()
  
  @IBOutlet var timerLabel: UILabel!
  @IBOutlet var timerInput: UITextField!
  @IBOutlet var startStopButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    timerLabel.text = "0.00"
    
  }
  
  @IBAction func startTimerButtonPressed(_ sender: Any) {
    if let countdown = timerInput.text {
      if Int(countdown) == nil {
        print("oops")
        
      } else {
        timerLabel.text = "\(countdown).00"
        startTimer(time: Int(countdown)!)
      }
    }
    timerInput.text = ""
  }
  
  func startTimer(time: Int) {
    totalTime = Float(time)
    var timeRemaining: Float = 0
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
      timer in
      if timeRemaining < self.totalTime {
        timeRemaining += 0.01
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
    
    let repeatTimer = UIAlertAction(title: "Repeat?", style: .default) {_ in
      self.startTimer(time: Int(self.totalTime))
    }
    alert.addAction(repeatTimer)
    present(alert, animated: true, completion: nil)
    timer.invalidate()
  }
  
}


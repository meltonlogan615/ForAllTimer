//
//  ViewController.swift
//  ForAllTimer
//
//  Created by Logan Melton on 21/7/18.
//

import UIKit

class ViewController: UIViewController {
  
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
    let totalTime: Float = Float(time)
    var timeRemaining: Float = 0
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
      timer in
      if timeRemaining < totalTime {
        timeRemaining += 0.01
        let tickTock = totalTime - timeRemaining
        self.timerLabel.text = String(format: "%.2f", tickTock)
      } else {
        self.timerLabel.text = "0.00"
        self.endTimer()
      }
    }
  }
  
  func endTimer() {
    let alert = UIAlertController(title: "Timer Complete", message: "", preferredStyle: .alert)
    let closeAlert = UIAlertAction(title: "OK", style: .default)
    alert.addAction(closeAlert)
    present(alert, animated: true, completion: nil)
    timer.invalidate()
  }
  
}


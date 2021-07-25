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
  var timerInput = UITextField()
  let shape = CAShapeLayer()
  let pulseRing = CAShapeLayer()
  
  private let timerLabel: UILabel = {
    let label = UILabel()
    label.text = "0.00"
    label.textAlignment = .center
    label.allowsDefaultTighteningForTruncation = true
    label.font = .systemFont(ofSize: 36, weight: .light)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.width / 2,
                                                     y: view.frame.height / 4),
                                  radius: 100,
                                  startAngle: -(.pi / 2),
                                  endAngle: .pi * 2,
                                  clockwise: true)
    
    let trackShape = CAShapeLayer()
    trackShape.path = circlePath.cgPath
    trackShape.fillColor = UIColor.clear.cgColor
    trackShape.lineWidth = 10
    trackShape.strokeColor = UIColor.lightGray.cgColor
    trackShape.zPosition = 1
    view.layer.addSublayer(trackShape)
    
    shape.path = circlePath.cgPath
    shape.lineWidth = 10
    shape.strokeColor = UIColor.systemBlue.cgColor
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeEnd = 0
    shape.zPosition = 2
    view.layer.addSublayer(shape)
    
    pulseRing.path = circlePath.cgPath
    pulseRing.lineWidth = 10
    pulseRing.strokeColor = UIColor.systemTeal.cgColor
    pulseRing.fillColor = UIColor.clear.cgColor
    pulseRing.zPosition = 0
    view.layer.addSublayer(pulseRing)
    
    // TIMER LABEL
    timerLabel.sizeToFit()
    timerLabel.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 4)
    view.addSubview(timerLabel)
    
    // TIMER INPUT
    timerInput = UITextField(frame: CGRect(x: 30,
                                           y: view.frame.height / 2,
                                           width: view.frame.width - 60,
                                           height: 30))
    view.addSubview(timerInput)
    timerInput.placeholder = "Enter Time in Seconds"
    timerInput.keyboardType = .numberPad
    timerInput.keyboardAppearance = .alert
    
    
    // START BUTTON
    let button = UIButton(frame: CGRect(x: 20,
                                        y: timerInput.frame.minY + 70,
                                        width: view.frame.size.width - 60,
                                        height: 50))
    view.addSubview(button)
    button.setTitle("Start", for: .normal)
    button.backgroundColor = .systemGreen
    button.addTarget(self, action: #selector(startTimerButtonPressed), for: .touchUpInside)
  }
  
  @objc func startTimerButtonPressed(_ sender: Any) {
    if let countdown = timerInput.text {
      if Double(countdown) == nil {
        print("oops")
      } else {
        print("\(timerInput.text ?? "000")")
        timerLabel.text = "\(countdown).00"
        startTimer(time: Int(countdown)!)
        // Animation
        pulsate(totalTime: Int(countdown)!)
        animate(totalTime: Int(countdown)!)
      }
    }
    timerInput.text = ""
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
      self.pulsate(totalTime: Int(self.totalTime))
      self.animate(totalTime: Int(self.totalTime))
      
    }
    alert.addAction(repeatTimer)
    present(alert, animated: true, completion: nil)
    timer.invalidate()
  }
  
  func animate(totalTime: Int) {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = (Double(totalTime) + 0.9)
    animation.isRemovedOnCompletion = false
    animation.fillMode = .forwards
    shape.add(animation, forKey: "animation")
  }
  
  func pulsate(totalTime: Int) {
    let pulsation = CABasicAnimation(keyPath: "lineWidth")
    pulsation.fromValue = 10
    pulsation.toValue = 30
    pulsation.duration = Double(totalTime) / 2
    pulsation.autoreverses = true
    pulseRing.add(pulsation, forKey: "pulsate")
  }
}


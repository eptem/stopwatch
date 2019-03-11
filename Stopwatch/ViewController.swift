//
//  ViewController.swift
//  Stopwatch
//
//  Created by Артем Жорницкий on 07/03/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import UIKit
import CoreFoundation

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    var fractions = 0
    var seconds = 0
    var minutes = 0
    var hours = 0
    var timer = Timer()
    
    
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: UIFont.Weight.regular)
        }
    }
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var startAndStopButton: UIButton!
    
    fileprivate func stopTheTimer() {
        timer.invalidate()
        startAndStopButton.setTitle("Start", for: .normal)
        startAndStopButton.setTitleColor(.green, for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.isEnabled = true
    }
    
    fileprivate func startTheTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        startAndStopButton.setTitle("Stop", for: .normal)
        startAndStopButton.setTitleColor(.red, for: .normal)
        resetButton.setTitleColor(.gray, for: .normal)
        resetButton.isEnabled = false
    }
    
    fileprivate func configureView() {
        // Do any additional setup after loading the view, typically from a nib.
        resetButton.isEnabled = false
        resetButton.setTitleColor(.white, for: .normal)
        startAndStopButton.setTitleColor(.green, for: .normal)
    }
    
    @objc func updateTimer(){
        
        fractions += 1
        if fractions == 100{
            seconds += 1
            fractions = 0
        }
        if seconds == 60{
            minutes += 1
            seconds = 0
        }
        if minutes == 60{
            hours += 1
            minutes = 0
        }
        
        timeLabel.text = String(format: "%02d:%02d:%02d:%02d", hours, minutes, seconds, fractions)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if timer.isValid{
            stopTheTimer()
        }
        else {
            startTheTimer()
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        timeLabel.text = "00:00:00:00"
        fractions = 0
        seconds = 0
        minutes = 0
    }
}


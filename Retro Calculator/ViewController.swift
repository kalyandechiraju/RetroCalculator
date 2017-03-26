//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Kalyan Dechiraju on 20/03/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    var runningNumber = ""
    var btnSound: AVAudioPlayer!
    var currentOperation = Operation.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if (btnSound.isPlaying) {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation)  {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                
                leftValString = result
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }


}


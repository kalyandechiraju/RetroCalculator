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
    
    var btnSound: AVAudioPlayer!

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
    }
    
    func playSound() {
        if (btnSound.isPlaying) {
            btnSound.stop()
        }
        btnSound.play()
    }


}


//
//  ViewController.swift
//  retroCalculator
//
//  Created by Marc Bollon on 6/5/16.
//  Copyright © 2016 Marc Bollon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputlbl: UILabel!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var btnSound: AVAudioPlayer!
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        
        playSound()
        runningNumber += "\(btn.tag)"
        outputlbl.text = runningNumber
        
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }
    
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        runningNumber = ""
        rightValStr = ""
        leftValStr = ""
        currentOperation = Operation.Empty
        outputlbl.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
            
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputlbl.text = result
            }
            currentOperation = op
            
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


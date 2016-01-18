//
//  ViewController.swift
//  Calculadora
//
//  Created by Cruz Martin Vera on 1/14/16.
//  Copyright © 2016 Cruz Martin Vera. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum operation: String {
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case equal = "="
        case empty = "empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: operation = operation.empty
    var nextOperation: operation = operation.empty
    var result = ""
    
    var btnSound: AVAudioPlayer!

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
        outputLabel.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation.divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation.multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation.subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation.add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: operation) {
        playSound()
        if currentOperation != operation.empty {
            //do some math
            if runningNumber != "" {
                    rightValStr = runningNumber
                    runningNumber = ""
                    if currentOperation == operation.multiply {
                        result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    } else if currentOperation == operation.divide {
                        result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    } else if currentOperation == operation.add {
                        result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    } else if currentOperation == operation.subtract {
                        result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    } 
                
                leftValStr = result
                outputLabel.text = result

            }
                currentOperation = op
            

            
        } else {
            //this is the first opeator
           leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        } else {
            btnSound.play()
        }
    }
    
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}


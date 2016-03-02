//
//  ViewController.swift
//  retro-calculator
//
//  Created by Zu Yao on 1/3/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outpulLbl: UILabel!

    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    func clearCalc() {
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        outpulLbl.text = "0"
    }
    
    override func viewDidLoad() {
        outpulLbl.text = "0"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outpulLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        print("first..",currentOperation)
        print("hmmm...", currentOperation != Operation.Empty)
        if currentOperation != Operation.Empty {
            print("grrrr", runningNumber)
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                print("1...",Double(leftValStr))
                print("2...",Double(rightValStr))
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation ==  Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outpulLbl.text = result
            }
            currentOperation = op
        } else {
            print("running Number", runningNumber)
            leftValStr = (runningNumber == "") ? leftValStr : runningNumber
            runningNumber = ""
            currentOperation = op
            print("---", currentOperation != Operation.Empty)
            print("+++...",Double(leftValStr), currentOperation, Operation.Empty, "/n")
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    @IBAction func clearCalcPressed(sender: AnyObject) {
        clearCalc()
    }
}


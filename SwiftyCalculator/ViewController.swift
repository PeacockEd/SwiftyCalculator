//
//  ViewController.swift
//  SwiftyCalculator
//
//  Created by Ed Kelly on 7/14/16.
//  Copyright © 2016 Edward P. Kelly LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var displayText: UILabel!
    
    private var calcBrain = CalculatorBrain()
    private var userIsTyping = false
    private var containsDecimal = false
    
    
    private var displayValue: Double {
        get {
            return Double(displayText.text!)!
        }
        set {
            displayText.text = String(newValue)
        }
    }
    
    private func checkForDecimalValue()
    {
        if displayText.text!.rangeOfString(".") != nil {
            containsDecimal = true
        } else {
            containsDecimal = false
        }
    }

    @IBAction private func onTouchDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if digit == "." && containsDecimal {
            return
        }
        if userIsTyping {
            let displayContents = displayText.text!
            displayText.text = displayContents + digit
        } else {
            displayText.text = digit
        }
        checkForDecimalValue()
        userIsTyping = true
    }
    
    @IBAction private func onPerformOperation(sender: UIButton)
    {
        if userIsTyping {
            calcBrain.setOperand(displayValue)
            userIsTyping = false
        }
        if let symbol = sender.currentTitle {
            calcBrain.performOperation(symbol)
        }
        displayValue = calcBrain.result
        checkForDecimalValue()
    }
}


//
//  ViewController.swift
//  Calculadora
//
//  Created by Pedro Henrique on 11/05/17.
//  Copyright © 2017 IESB - Instituto de Educação Superior de Brasília. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    
    var userIsInMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        let currentValue = display.text!
        if userIsInMiddleOfTyping {
            display.text = currentValue + digit
        }else {
            display.text = digit
            userIsInMiddleOfTyping = true
        }
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
   
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        brain.setOperand(displayValue)
        userIsInMiddleOfTyping = false
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
            displayValue = brain.result!
        }
    }

}


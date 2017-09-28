//
//  ViewController.swift
//  Calculadora
//
//  Created by HC5MAC20 on 11/05/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsMiddleOfTyping = false

    @IBOutlet weak var display: UITextField!
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        let currentValue = display.text!
        
        if userIsMiddleOfTyping {
            display.text = currentValue + digit
            
        }else{
            display.text =  digit
            userIsMiddleOfTyping = true
        }
        
    }

    @IBAction func performOperation(_ sender: AnyObject) {
        
        if let mathematicalOperation = sender.currentTitle!{
            userIsMiddleOfTyping = false
            switch mathematicalOperation {
            case "π":
                display.text = String(Double.pi)
            default:
                break
            }



        }
        
    }

}


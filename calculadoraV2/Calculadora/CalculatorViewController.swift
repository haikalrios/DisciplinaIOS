//
//  ViewController.swift
//  Calculadora
//
//  Created by Haikal Rios on 20/07/17.
//  Copyright © 2017 IESB - Instituto de Educação Superior de Brasília. All rights reserved.
//
import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

  
    @IBOutlet weak var history: UITextView!
  
    private var userIsInMiddleOfTyping = false
    
    private var brainModel = CalculatorBrainModel()
    
    private var displayValue: Double {
        
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            userIsInMiddleOfTyping = true
        }
    }
    
   

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "." && display.text!.range(of: ".") != nil {
            return;
        }
        
        let currentValue = display.text!
        
        if userIsInMiddleOfTyping {
            display.text = currentValue + digit
        }else {
            display.text = digit
            userIsInMiddleOfTyping = true
        }
        
        
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
  
        if let symbol = sender.currentTitle {
            brainModel.performOperation(symbol, displayValue)
            displayValue = brainModel.result
            appendHistory()
        }
        userIsInMiddleOfTyping = false
        
    }
    
    private func  appendHistory(){
        history.text.removeAll()
        for i in 0 ..< brainModel.history.count  {
            history.text.append(brainModel.history[i])
            history.text.append("\n")
            let characters = history.text.characters.count
            history.scrollRangeToVisible(NSRange(location: Int(characters), length: 10))
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destionationController = segue.destination
        
        if let destinationNavigationController = destionationController as? UINavigationController{
            destionationController = destinationNavigationController.viewControllers[0]
        }
        
        if let identifier = segue.identifier,
           let graphicViewController = destionationController as? GraphicViewController{
            if identifier == "showGraph"{
                graphicViewController.navigationItem.title = brainModel.getEquacao()
                graphicViewController.calculatorFunctionUnary = brainModel.performMemoryCalc

                
            }
        }

    
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showGraph"{
            if !brainModel.readyForFunctionMode(){
                history.text.append("Calculadora não está em modo função\n")
                history.text.append("Use a tecla M\n")
            }
            return brainModel.readyForFunctionMode()
        }
        return true
    }


}


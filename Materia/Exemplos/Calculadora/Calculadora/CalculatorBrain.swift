//
//  CalculatorBrain.swift
//  Calculadora
//
//  Created by Pedro Henrique on 18/05/17.
//  Copyright © 2017 IESB - Instituto de Educação Superior de Brasília. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unary(sqrt),
        "±": Operation.unary({ -$0 }),
        "×": Operation.binary({ $0 * $1 }),
        "+": Operation.binary({ $0 + $1 }),
        "=": Operation.equals
    ]
    
    private var pbo: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
                case .constant(let constant):
                    accumulator = constant
                case .unary(let function):
                    if accumulator != nil {
                        accumulator = function(accumulator!)
                    }
                case .binary(let function):
                    if accumulator != nil {
                        pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    }
                case .equals:
                    performPendingBinaryOperation()
                default:
                    break
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if accumulator != nil {
            accumulator = pbo?.perform(with: accumulator!)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}

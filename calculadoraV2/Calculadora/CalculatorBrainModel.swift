//
//  CalculatorBrain.swift
//  Calculadora
//
//  Created by Haikal Rios on 20/07/17.
//  Copyright © 2017 IESB - Instituto de Educação Superior de Brasília. All rights reserved.
//
import Foundation

class CalculatorBrainModel {
    
    private var accumulator: Double?
    //private var display: Double = 0
    
    private var historyLocal: [String] = []
    
    private var buffer: [Buffer] = []
    
    private var calculatorMode: CalculatorMode = CalculatorMode.normalMode
    private var pbo: PendingBinaryOperation?
    private var lastOperationInMemoryMode: Operation = .clear
    private var lastOperadIsVariable: Bool = false

    private struct Buffer{
        let operation: String
        let operand: Double?
        let isParam: Bool
    }
    
    private enum CalculatorMode {
        case normalMode
        case memoryMode
        case readyForFunctionCalcMode
        case processMemoryMode

        
    }
    
    func readyForFunctionMode()-> Bool{
        return calculatorMode == .readyForFunctionCalcMode
    }
    
    
    
    var result: Double {
        get {
            if accumulator != nil{
                return accumulator!
            }
            return 0
        }
    }
    
   
    var history: [String] {
        get {
            return historyLocal
        }
    }
    
    
    public enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case process((String))
        case equals
        case memory
        case clear
    }
    
    func performMemoryCalc(_ valueM: Double)->Double?{
        let oldCalculatorMode = calculatorMode
        let oldAccumulator = accumulator
        let oldPbo = pbo
       
        calculatorMode = .processMemoryMode
        accumulator = nil
        pbo = nil
        
        var i :Int = 0

        while i < buffer.count {
            let operation: String = buffer[i].operation
            var operand: Double? = buffer[i].operand
            let isVariable = buffer[i].isParam
            
            
            if operand == nil{
                if isVariable{
                    operand = valueM
                }else{
                    operand = accumulator
                }
            }
            
            performOperation(operation, operand!)
            
            i = i+1
        }
        
        let retorno: Double? = result
        accumulator = oldAccumulator
        pbo = oldPbo
        calculatorMode = oldCalculatorMode
        return retorno
    }
    

    
   
    private func performOperationDefaultMode(_ symbol: String, _ operand: Double){
        
        if let operation = operations[symbol] {
            switch operation {
            case .clear:
                accumulator = nil
                pbo = nil
                clearBufferMemory()
                //pode estar em processMode
                calculatorMode = .normalMode
            case .constant(let constant):
                accumulator = constant
            case .unary(let function):
                accumulator = function(operand)
            case .binary(let function):
                accumulator = operand
                performPendingBinaryOperation()
                pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                
            case .equals:
                accumulator = operand
                performPendingBinaryOperation()
            case .memory:
                clearBufferMemory()
                calculatorMode = .memoryMode
                accumulator = nil
                historyLocal.append("Inicio modo função.")
                historyLocal.append("Use a tecla M para definir a variavel da função")
                historyLocal.append("Use a tecla = para finalizar o modo gravação.")
                historyLocal.append("Use a tecla G para exibir o grafico da função")
                historyLocal.append("Exemplo: C + M + 7 + M sen + π ")
                historyLocal.append("Será calculado o valor para x:")
                historyLocal.append("f(x) = (7 + (x sen) + π )")
                historyLocal.append("")
            default:
               break
            }
            
            appendToHistory( symbol, operand)
            
        
        }
        
    
    }

    private func addBuffer(_ operand: Double?, _ operation: String){
        if lastOperadIsVariable{
            buffer.append(Buffer(operation: operation, operand: nil, isParam: true))
            lastOperadIsVariable = false
        }else{
            buffer.append(Buffer(operation: operation, operand: operand, isParam: false))
        }
    }
    
    public func getEquacao()->String{
        var retorno: String = ""
        for i in 0 ..< buffer.count  {
            if buffer[i].isParam {
                retorno = retorno + "M "
            }else{
                if buffer[i].operand != nil{
                    retorno = retorno + String(format: "%f", buffer[i].operand!) + " "
                }
            }
            retorno = retorno + buffer[i].operation + " "
            
        }
        return retorno
    }
    
    private func performOperationMemoryMode(_ symbol: String, _ operand: Double){
        
        if let operation = operations[symbol] {
            var newOperand: Double? = nil
            switch lastOperationInMemoryMode {
            case .unary:
                newOperand = nil
            case .constant:
                newOperand = nil
            default:
                newOperand = operand
                
            }
            
            
            switch operation {
            case .clear:
                calculatorMode = .normalMode
                accumulator = 0
                clearBufferMemory()
            case .constant:
                newOperand = nil
                addBuffer(newOperand, symbol)
            case .memory:
                lastOperadIsVariable = true
            case .equals:
                addBuffer(newOperand, symbol)
                
                historyLocal.append("Fim do modo gravação. Função definida: ")
                historyLocal.append( getEquacao())
                historyLocal.append("----------------------------")
                calculatorMode = .readyForFunctionCalcMode

                
            default:
                addBuffer(newOperand, symbol)
            }
            lastOperationInMemoryMode = operation
        }
 
    }
    
    func performOperation(_ symbol: String, _ operand: Double) {
        switch calculatorMode {
        case .memoryMode:
           performOperationMemoryMode(symbol, operand)
        default:
           performOperationDefaultMode(symbol, operand)
        }
    }
    
    
    private  func clearBufferMemory(){
        buffer.removeAll()
        
    }
    
    private  func appendToHistory(_ operation: String,_ operand: Double) {
      
        if (operation == "C"){
            historyLocal.removeAll()
            return
        }
        
        if (operation == "M"){
            return
        }
        if calculatorMode != .processMemoryMode{
            historyLocal.append(String(format: "%f", operand))
            historyLocal.append(operation)
        }
    }
   
    private struct PendingBinaryOperation {
        
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
 
    
    
    private func performPendingBinaryOperation() {
        if pbo != nil {
            accumulator = pbo?.perform(with: accumulator!)
            pbo = nil
            
        }
    }
 
    private var operations: Dictionary<String, Operation> = [
        "C": Operation.clear,
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unary(sqrt),
        "±": Operation.unary({ -$0 }),
        "sen": Operation.unary({ sin($0) }),
        "cos": Operation.unary({ cos($0) }),
        "tan": Operation.unary({ tan($0) }),
        "log": Operation.unary({ log($0) }),
        "×": Operation.binary({ $0 * $1 }),
        "÷": Operation.binary({ $0 / $1 }),
        "+": Operation.binary({ $0 + $1 }),
        "−": Operation.binary({ $0 - $1 }),
        "∧": Operation.binary({ pow($0 , $1) }),
        "%": Operation.binary({ ($0 * $1) / 100 }),
        "=": Operation.equals,
        "M": Operation.memory
    ]
    


    
    
}

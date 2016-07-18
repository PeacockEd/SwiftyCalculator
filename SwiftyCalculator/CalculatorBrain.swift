//
//  CalculatorBrain.swift
//  SwiftyCalculator
//
//  Created by Ed Kelly on 7/14/16.
//  Copyright © 2016 Edward P. Kelly LLC. All rights reserved.
//

import Foundation

func multiply(first: Double, second: Double) -> Double
{
    return first * second
}

class CalculatorBrain {
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation(multiply),
        //"−" : Operation
        //"÷" : Operation
        //"+" : Operation
        "=" : Operation.Equals
    ]
    
    func setOperand(operand: Double)
    {
        accumulator = operand
    }
    
    func performOperation(symbol: String)
    {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                    pending = nil
                }
            }
        }
    }
    
}
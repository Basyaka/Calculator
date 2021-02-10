//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Vlad Novik on 8.02.21.
//

import Foundation

class CalculatorBrain {
    let pi = 3.141592653589793
    let e = 2.71828182846
    
    var calculatorStringForLabel = "0"
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var result: Double = 0
    
    var operation: Int?
    
    var stillTyping = false
    var dotIsPlaced = false
    
    var currentInput: Double {
        get {
            return Double(calculatorStringForLabel)!
        }
        set {
            calculatorStringForLabel = stringWithoutZeroFraction(newValue)
        }
    }

    func operationResultWithTwoOperand(operation: (Double, Double) -> Double) {
        result = operation(firstOperand, secondOperand)
        calculatorStringForLabel = stringWithoutZeroFraction(result)
        stillTyping = false
    }
    
    func stringWithoutZeroFraction(_ temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    func factorial(_ n: Double) -> Double{
        if n == 0{
            return 1
        }
        return n * factorial(n-1)
    }
}

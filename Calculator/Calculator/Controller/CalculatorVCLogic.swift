//
//  CalculatorVCLogic.swift
//  Calculator
//
//  Created by Vlad Novik on 9.02.21.
//

import UIKit

extension CalculatorViewController: CustomButtonDelegate {
    func buttonTapped(sender: UIButton) {
       sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) {
            sender.alpha = 1
        }
        switch sender.tag {
        //Buttons 0...9
        case 0...9:
            if let titleText = sender.currentTitle {
                if let resultText = resultLabel.text {
                    if calcBrain.stillTyping {
                        if resultText.count < 20 {
                            calcBrain.calculatorStringForLabel.append(titleText)
                            resultLabel.text = calcBrain.calculatorStringForLabel
                        }
                    } else {
                        if sender.tag == 0 {
                            calcBrain.calculatorStringForLabel = titleText
                            resultLabel.text = titleText
                            break
                        }
                        calcBrain.calculatorStringForLabel = titleText
                        resultLabel.text = titleText
                        calcBrain.stillTyping = true
                    }
                }
            }
            
        //Clear
        case 13:
            calcBrain.firstOperand = 0
            calcBrain.secondOperand = 0
            calcBrain.stillTyping = false
            calcBrain.dotIsPlaced = false
            resultLabel.text = "0"
            calcBrain.calculatorStringForLabel = "0"
            calcBrain.operation = 0
            
        // / * - + x√‎ x^y
        case 15...18, 33, 25:
            calcBrain.operation = sender.tag
            calcBrain.firstOperand = calcBrain.currentInput
            calcBrain.stillTyping = false
            calcBrain.dotIsPlaced = false
            
        // =
        case 19:
            if calcBrain.stillTyping {
                calcBrain.secondOperand = calcBrain.currentInput
            }
            calcBrain.dotIsPlaced = false
            
            if let operation = calcBrain.operation {
                switch operation {
                //Decide
                case 15:
                    calcBrain.operationResultWithTwoOperand {$0 / $1}
                //Mltiplication 
                case 16:
                    calcBrain.operationResultWithTwoOperand {$0 * $1}
                //Difference
                case 17:
                    calcBrain.operationResultWithTwoOperand {$0 - $1}
                //Adding
                case 18:
                    calcBrain.operationResultWithTwoOperand {$0 + $1}
                //Root x
                case 33:
                    calcBrain.operationResultWithTwoOperand {pow($0, 1/$1)}
                //x^y
                case 25:
                    calcBrain.operationResultWithTwoOperand {pow($0, $1)}
                default: break
                }
            }
            resultLabel.text = calcBrain.calculatorStringForLabel
            
        // +/-
        case 14:
            if resultLabel.text != "0" && resultLabel.text != "0." {
                calcBrain.currentInput = -calcBrain.currentInput
                resultLabel.text = calcBrain.calculatorStringForLabel
            }
            
        //Percent
        case 12:
            if calcBrain.firstOperand == 0 {
                calcBrain.currentInput = calcBrain.currentInput / 100
                resultLabel.text = calcBrain.calculatorStringForLabel
            } else {
                calcBrain.secondOperand = calcBrain.firstOperand * calcBrain.currentInput / 100
                resultLabel.text = String(calcBrain.secondOperand)
            }
            
        //Dot
        case 11:
            if calcBrain.stillTyping && !calcBrain.dotIsPlaced {
                calcBrain.calculatorStringForLabel.append(".")
                resultLabel.text! += "."
                calcBrain.dotIsPlaced = true
            } else if !calcBrain.stillTyping && !calcBrain.dotIsPlaced {
                calcBrain.calculatorStringForLabel = "0."
                resultLabel.text = "0."
                calcBrain.stillTyping = true
                calcBrain.dotIsPlaced = true
            }
            
        // 2√‎
        case 32:
            calcBrain.currentInput = sqrt(calcBrain.currentInput)
            resultLabel.text = calcBrain.calculatorStringForLabel
            
        // 20(sin), 21(cos), 22(tan), 23(x^2), 24(x^3), 26(10^x), 27(1/x), 28(x!), 29(log10), 30(Log2), 31(e), 34(pi)
        case 20...24, 26...31, 34:
            var operation = 0.0
            switch sender.tag {
            case 20: operation = sin(calcBrain.currentInput)
            case 21: operation = cos(calcBrain.currentInput)
            case 22: operation = tan(calcBrain.currentInput)
            case 23: operation = pow(calcBrain.currentInput, 2)
            case 24: operation = pow(calcBrain.currentInput, 3)
            case 26: operation = pow(10, calcBrain.currentInput)
            case 27: operation = 1/calcBrain.currentInput
            case 28: operation = calcBrain.factorial(calcBrain.currentInput)
            case 29: operation = log10(calcBrain.currentInput)
            case 30: operation = log2(calcBrain.currentInput)
            case 31: operation = calcBrain.e
            case 34: operation = calcBrain.pi
            default: break
            }
            if calcBrain.firstOperand == 0 {
                calcBrain.currentInput = operation
                resultLabel.text = calcBrain.calculatorStringForLabel
            } else {
                calcBrain.secondOperand = operation
                resultLabel.text = String(calcBrain.pi)
            }
            
        default:
            break
        }
    }
}

//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Vlad Novik on 8.02.21.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    let calcBrain = CalculatorBrain()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = calcBrain.calculatorStringForLabel
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = .right
        return label
    }()
    
    private var zeroButton = CustomButton(title: "0", backgroundColor: .gray, tag: 0)
    private var oneButton = CustomButton(title: "1", backgroundColor: .gray, tag: 1)
    private var twoButton = CustomButton(title: "2", backgroundColor: .gray, tag: 2)
    private var threeButton = CustomButton(title: "3", backgroundColor: .gray, tag: 3)
    private var fourButton = CustomButton(title: "4", backgroundColor: .gray, tag: 4)
    private var fiveButton = CustomButton(title: "5", backgroundColor: .gray, tag: 5)
    private var sixButton = CustomButton(title: "6", backgroundColor: .gray, tag: 6)
    private var sevenButton = CustomButton(title: "7", backgroundColor: .gray, tag: 7)
    private var eightButton = CustomButton(title: "8", backgroundColor: .gray, tag: 8)
    private var nineButton = CustomButton(title: "9", backgroundColor: .gray, tag: 9)
    
    private var dotButton = CustomButton(title: ".", backgroundColor: .gray, tag: 11)
    private var percentButton = CustomButton(title: "%", backgroundColor: .systemGray5, tag: 12)
    private var cButton = CustomButton(title: "C", backgroundColor: .systemGray5, tag: 13)
    private var plusOrMinusButton = CustomButton(title: "+/-", backgroundColor: .systemGray5, tag: 14)
    private var devideButton = CustomButton(title: "÷", backgroundColor: .orange, tag: 15)
    private var multiplyButton = CustomButton(title: "×", backgroundColor: .orange, tag: 16)
    private var minusButton = CustomButton(title: "-", backgroundColor: .orange, tag: 17)
    private var plusButton = CustomButton(title: "+", backgroundColor: .orange, tag: 18)
    private var equalsButton = CustomButton(title: "=", backgroundColor: .orange, tag: 19)
    
    private var sinButton = CustomButton(title: "sin", backgroundColor: .darkGray, tag: 20)
    private var cosButton = CustomButton(title: "cos", backgroundColor: .darkGray, tag: 21)
    private var tanButton = CustomButton(title: "tan", backgroundColor: .darkGray, tag: 22)
    
    private var x2Button = CustomButton(title: "x^2", backgroundColor: .darkGray, tag: 23)
    private var x3Button = CustomButton(title: "x^3", backgroundColor: .darkGray, tag: 24)
    private var xyButton = CustomButton(title: "x^​y", backgroundColor: .darkGray, tag: 25)
    
    private var powerOfTenButton = CustomButton(title: "10^x", backgroundColor: .darkGray, tag: 26)
    private var oneDevideXButton = CustomButton(title: "1/x", backgroundColor: .darkGray, tag: 27)
    private var factorialButton = CustomButton(title: "x!", backgroundColor: .darkGray, tag: 28)
    
    private var logTenButton = CustomButton(title: "Log10", backgroundColor: .darkGray, tag: 29)
    private var logTwoButton = CustomButton(title: "Log2", backgroundColor: .darkGray, tag: 30)
    private var eButton = CustomButton(title: "e", backgroundColor: .darkGray, tag: 31)
    
    private var rootTwoButton = CustomButton(title: "2√‎", backgroundColor: .darkGray, tag: 32)
    private var rootXButton = CustomButton(title: "x√‎", backgroundColor: .darkGray, tag: 33)
    private var piButton = CustomButton(title: "pi", backgroundColor: .darkGray, tag: 34)
    
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var engineeringView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startingSettings()
        setupMainLayout()
        setupEngineeringLayout()
        setupMainStack()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupOrientation()
    }
    
    private func setupOrientation() {
        if UIDevice.current.orientation.isLandscape {
            engineeringView.isHidden = false
        } else if UIDevice.current.orientation.isPortrait {
            engineeringView.isHidden = true
        }
    }
    
    private func startingSettings() {
        view.backgroundColor = .black
        
        zeroButton.delegate = self
        oneButton.delegate = self
        twoButton.delegate = self
        threeButton.delegate = self
        fourButton.delegate = self
        fiveButton.delegate = self
        sixButton.delegate = self
        sevenButton.delegate = self
        eightButton.delegate = self
        nineButton.delegate = self
        
        dotButton.delegate = self
        percentButton.delegate = self
        cButton.delegate = self
        plusOrMinusButton.delegate = self
        devideButton.delegate = self
        multiplyButton.delegate = self
        minusButton.delegate = self
        plusButton.delegate = self
        equalsButton.delegate = self
        
        powerOfTenButton.delegate = self
        x2Button.delegate = self
        x3Button.delegate = self
        piButton.delegate = self
        oneDevideXButton.delegate = self
        sinButton.delegate = self
        cosButton.delegate = self
        tanButton.delegate = self
        xyButton.delegate = self
        factorialButton.delegate = self
        logTenButton.delegate = self
        logTwoButton.delegate = self
        eButton.delegate = self
        rootXButton.delegate = self
        rootTwoButton.delegate = self
    }
    
    private func setupMainStack() {
        //Stack for buttons
        let stackForButtons = UIStackView(arrangedSubviews: [engineeringView, mainView])
        stackForButtons.distribution = .fillEqually
        stackForButtons.spacing = 2
        
        //View for label
        let labelView = UIView()
        labelView.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.leftAnchor.constraint(equalTo: labelView.leftAnchor, constant: 20),
            resultLabel.rightAnchor.constraint(equalTo: labelView.rightAnchor, constant: -10),
            resultLabel.topAnchor.constraint(equalTo: labelView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor),
        ])
        
        //Main Stack
        let mainStack = UIStackView(arrangedSubviews: [labelView, stackForButtons])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.distribution = .fill
        mainStack.axis = .vertical
        view.addSubview(mainStack)
        
        labelView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.2).isActive = true
        
        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func setupMainLayout() {
        //Stack for AC +/- % /
        let firstLvlStack = UIStackView(arrangedSubviews: [cButton, plusOrMinusButton, percentButton, devideButton])
        firstLvlStack.distribution = .fillEqually
        firstLvlStack.spacing = 2
        
        //Stack for 7 8 9 *
        let secondLvlStack = UIStackView(arrangedSubviews: [sevenButton, eightButton, nineButton, multiplyButton])
        secondLvlStack.distribution = .fillEqually
        secondLvlStack.spacing = 2
        
        //Stack for 4 5 6 -
        let thirdLvlStack = UIStackView(arrangedSubviews: [fourButton, fiveButton, sixButton, minusButton])
        thirdLvlStack.distribution = .fillEqually
        thirdLvlStack.spacing = 2
        
        //Stack for 1 2 3 +
        let fourthLvlStack = UIStackView(arrangedSubviews: [oneButton, twoButton, threeButton, plusButton])
        fourthLvlStack.distribution = .fillEqually
        fourthLvlStack.spacing = 2
        
        //Stack for 0 . =
        let fifthLvlStack = UIStackView(arrangedSubviews: [zeroButton, dotButton, equalsButton])
        fifthLvlStack.spacing = 2
        
        zeroButton.widthAnchor.constraint(equalTo: dotButton.widthAnchor, multiplier: 2.0).isActive = true
        equalsButton.widthAnchor.constraint(equalTo: dotButton.widthAnchor).isActive = true
       
        //Main Stack
        let mainStack = UIStackView(arrangedSubviews: [firstLvlStack, secondLvlStack, thirdLvlStack, fourthLvlStack, fifthLvlStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.distribution = .fillEqually
        mainStack.axis = .vertical
        mainStack.spacing = 2
        
        mainView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            mainStack.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
    
    private func setupEngineeringLayout() {
        //Stack for sin cos tan
        let firstLvlStack = UIStackView(arrangedSubviews: [sinButton, cosButton, tanButton])
        firstLvlStack.distribution = .fillEqually
        firstLvlStack.spacing = 2
        
        //Stack for x^2 x^3 x^y
        let secondLvlStack = UIStackView(arrangedSubviews: [x2Button, x3Button, xyButton])
        secondLvlStack.distribution = .fillEqually
        secondLvlStack.spacing = 2
        
        //Stack for 10^x 1/x x!
        let thirdLvlStack = UIStackView(arrangedSubviews: [powerOfTenButton, oneDevideXButton, factorialButton])
        thirdLvlStack.distribution = .fillEqually
        thirdLvlStack.spacing = 2
        
        //Stack for Log Rand e
        let fourthLvlStack = UIStackView(arrangedSubviews: [logTenButton, logTwoButton, eButton])
        fourthLvlStack.distribution = .fillEqually
        fourthLvlStack.spacing = 2
        
        //Stack for 2√‎ x√‎ pi
        let fifthLvlStack = UIStackView(arrangedSubviews: [rootTwoButton, rootXButton, piButton])
        fifthLvlStack.distribution = .fillEqually
        fifthLvlStack.spacing = 2
        
        //Main Stack
        let mainStack = UIStackView(arrangedSubviews: [firstLvlStack, secondLvlStack, thirdLvlStack, fourthLvlStack, fifthLvlStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.distribution = .fillEqually
        mainStack.axis = .vertical
        mainStack.spacing = 2

        engineeringView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(equalTo: engineeringView.leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: engineeringView.rightAnchor),
            mainStack.topAnchor.constraint(equalTo: engineeringView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: engineeringView.bottomAnchor)
        ])
    }
}

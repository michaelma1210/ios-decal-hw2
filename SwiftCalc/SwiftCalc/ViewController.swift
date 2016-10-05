//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
//    var someDataStructure: [String] = [""]
    var numbersAL = [String]()
    var operatorAL = [String]()
    var operatorSwitch = false
    var decimalSwitch = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        print("Update me like one of those PCs")
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        print("Update me like one of those PCs")
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0.0
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        // Fill me in!
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        if numbersAL.isEmpty || operatorSwitch == true {
            numbersAL.append(sender.content)
            operatorSwitch = false

        }
        else {
            if numbersAL[numbersAL.count - 1].characters.count < 7 {
//                if decimalSwitch == true {
//                    numbersAL[numbersAL.count - 1] += "."
//                    decimalSwitch = false
//                    showNewNum()
//                }
                numbersAL[numbersAL.count - 1] += sender.content
            }
        }
        
        showNewNum()
        
    }
    
    func turnToDecimalForm(doubleNum: Double) -> String {
        if doubleNum.truncatingRemainder(dividingBy: 1) == 0 {
            let decimalNum = Int(doubleNum)
            return String(decimalNum)
        }
        return String(doubleNum)
    }
    
    func showNewNum() {
        resultLabel.text = numbersAL[numbersAL.count - 1]
    }
    
    func doCalculate() {
        if numbersAL.count == 1 && !operatorAL.isEmpty {
            let first = Double(numbersAL.removeFirst())
            let second = first
            let op = operatorAL.removeFirst()
            let temp = mathCalculation(firstNum: (first)!, secondNum: (second)!, operation: op)
            let stringNum = turnToDecimalForm(doubleNum: temp)
            numbersAL.append(stringNum)
            showNewNum()
        }
        if numbersAL.count == 2 && !operatorAL.isEmpty {

            let first = Double(numbersAL.removeFirst())
            let second = Double(numbersAL.removeFirst())
            let op = operatorAL.removeFirst()
            let temp = mathCalculation(firstNum: (first)!, secondNum: (second)!, operation: op)
            let stringNum = turnToDecimalForm(doubleNum: temp)
            numbersAL.append(stringNum)
            showNewNum()
        }

    }
    
    func mathCalculation(firstNum: Double, secondNum: Double, operation: String) -> Double {
        if operation == "+" {
            return firstNum + secondNum
        }
        else if operation == "-" {
            return firstNum - secondNum
        }
        else if operation == "*" {
            return firstNum * secondNum
        }
        else if operation == "/" {
            return firstNum / secondNum
        }
        return 0
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        // Fill me in!
        
        //clear the number
        if sender.content == "C" {
            numbersAL.removeAll()
            operatorAL.removeAll()
            resultLabel.text = "0"
        }
        
        //switch between positive and negative
        else if sender.content == "+/-" {
            var currNum = Double(numbersAL.removeLast())!
            currNum = currNum - (2 * currNum)
            let stringNum = turnToDecimalForm(doubleNum: currNum)
            numbersAL.append(stringNum)
            
            showNewNum()
        }
        
        //calculate when equal sign pressed
        else if sender.content == "=" {
            doCalculate()
            showNewNum()
            
        }
            
        else if sender.content == "%" {
            var currNum = Double(numbersAL.removeLast())!
            currNum = currNum / 100
            let stringNum = turnToDecimalForm(doubleNum: currNum)
            numbersAL.append(stringNum)
            
            showNewNum()
        }
            
        else {

            operatorAL.append(sender.content)
            operatorSwitch = true
            
            if operatorAL.count > 1 {
                doCalculate()
            }
        }
        

    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
       // Fill me in!
        if sender.content == "0" {
            numberPressed(sender)
        }
        
        if sender.content == "." {
            if numbersAL.isEmpty {
                numbersAL.append("0")
            }
            numbersAL[numbersAL.count - 1] += "."
            showNewNum()
        }
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}


//
//  ViewController.swift
//  Dentaku.swift
//
//  Created by 平岡 建 on 2018/04/08.
//  Copyright © 2018年 平岡 建. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var formulaLabel :UILabel!
    var isOperation :Bool = false
    var isInput :Bool = false
    var isEqual:Bool = false
    var inputNums:[Double] = []
    var operations:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulaLabel.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func acButtonPush(sender:UIButton){
        formulaLabel.text = "0"
        isOperation = false
        isInput = false
        isEqual = false
        inputNums.removeAll()
        operations.removeAll()
    }
    
    //数字入力
    @IBAction func numbersButtonInput(sender:UIButton){
        if formulaLabel.text!=="0" {
            formulaLabel.text = ""
            formulaLabel.text = sender.titleLabel!.text
        }else if formulaLabel.text!=="-0"{
            formulaLabel.text = ""
            formulaLabel.text = "-" + sender.titleLabel!.text!
        }else{
            if isOperation || isEqual{//演算子を選んだ直後
                formulaLabel.text = ""
                isOperation = false
                isEqual = false
            }
            formulaLabel.text = formulaLabel.text! + sender.titleLabel!.text!
        }
        isInput = true
    }
    
    @IBAction func dotButtonInput(sender:UIButton){
        let dot = "."
        if isOperation || isEqual{//演算子を選んだ直後
            formulaLabel.text = "0"
            isOperation = false
            isEqual = false
        }
        //formulaLabelの中に小数点がなかったら入力できる
        guard formulaLabel.text!.contains(dot) else {
            formulaLabel.text! = formulaLabel.text! + dot
            return
        }
    }
    
    //+と-を入れ替える
    @IBAction func plusOrMinusButtonChange(sender:UIButton){
        if formulaLabel.text!.hasPrefix("-") {
            formulaLabel.text!=String(formulaLabel.text![formulaLabel.text!.index(formulaLabel.text!.startIndex, offsetBy: 1)..<formulaLabel.text!.endIndex])
        }else{
            formulaLabel.text!="-"+formulaLabel.text!
        }
    }
    
    //+,-,×,÷,%,ボタン
    @IBAction func operationButtonSelect(sender:UIButton){
        var result:Double = NSString(string: formulaLabel.text!).doubleValue
        if isEqual || isInput == false {
            //operationsの最後の要素をsender.titleLabel?.text!に入れ替える
            operations[operations.count-1] = (sender.titleLabel?.text!)!
            isEqual = false
            isOperation = true
            print("演算子訂正")
        }else if isInput {//数字が入力された直後
            isInput = false
            isOperation = true
            //選択した演算子のボタンのタイトルラベル文字列が入る
            operations.append((sender.titleLabel?.text)!)
            //現在、表示されている数字をDoubleにして配列に追加
            inputNums.append(result)
            print("数字が入力された直後")
        }
        result = caluculate(operation: self.operations, inputNum: self.inputNums)
        formulaLabel.text = String(format: "%g", result)
    }
    
    //=ボタン
    @IBAction func equalButtonAnswer(sender:UIButton){
        var result:Double = NSString(string: formulaLabel.text!).doubleValue
        //1回以上演算子が選択されている
        if inputNums.count >= 1 {
            if !isEqual {
                inputNums.append(NSString(string: formulaLabel.text!).doubleValue)
            }
            isEqual = true
            result = caluculate(operation: self.operations, inputNum: self.inputNums)
            let str = operations.last!
            operations.removeAll()
            operations.append(str)
            let i = inputNums.last!
            inputNums.removeAll()
            inputNums.append(result)
            inputNums.append(i)
        }
        formulaLabel.text = String(format: "%g", result)
    }
    
    func caluculate(operation: [String], inputNum: [Double]) -> Double {
        var returnVal: Double = NSString(string: formulaLabel.text!).doubleValue
        //var inputNum = inputNum
        var opr:[String] = []
        var index:[Int] = []
        var numArray:[Double] = []
        var isContinuous1:Bool = true
        var isContinuous2:Bool = true
        if isEqual {
            //operationをソートする
            for i in 0..<operation.count {
                switch operation[i] {
                case "×","÷":
                    //operationが+,×の場合×が先にoprにappendされる
                    opr.append(operation[i])
                    if isContinuous1{
                        //1+2×3の場合2,3が入る
                        index.append(operation.index(after: i-1))
                        index.append(operation.index(after: i))
                        isContinuous1 = false
                    }else {//×,÷が連続の場合(××+とか)
                        index.append(operation.index(after: i))
                    }
                default:
                    break
                }
            }
            for i in 0..<operation.count {
                switch operation[i] {
                case "+","-":
                    opr.append(operation[i])
                    if isContinuous2{
                        index.append(operation.index(after: i-1))
                        index.append(operation.index(after: i))
                        isContinuous2 = false
                    }else {
                        index.append(operation.index(after: i))
                    }
                default:
                    break
                }
            }
            for i in 0..<index.count {
                numArray.append(inputNum[index[i]])
            }
            print(opr,index,inputNum,numArray)
            for i in 0..<opr.count {
                returnVal = calc4Ways(num1: numArray[i], num2: numArray[i+1], opr: opr[i])
                numArray[i+1] = returnVal
            }
        }else if operation.count == 2 {
            //1+2*
            if (operation[0] == "+" || operation[0] == "-") && (operation[1] == "×" || operation[1] == "÷") {
                returnVal = inputNum[1]
            }else {//1+2+
                returnVal = calc4Ways(num1: inputNum[0], num2: inputNum[1], opr: operation[0])
            }
            print("operation.count == 2")
        }else if operation.count >= 3 {
//            //operationをソートする
//            for i in 0..<operation.count {
//                switch operation[i] {
//                case "×","÷":
//                    //operationが+,×の場合×が先にoprにappendされる
//                    opr.append(operation[i])
//                    if isContinuous1{
//                        //1+2×3の場合2,3が入る
//                        index.append(operation.index(after: i-1))
//                        index.append(operation.index(after: i))
//                        isContinuous1 = false
//                    }else {//×,÷が連続の場合(××+とか)
//                        index.append(operation.index(after: i))
//                    }
//                default:
//                    break
//                }
//            }
//            for i in 0..<operation.count {
//                switch operation[i] {
//                case "+","-":
//                    opr.append(operation[i])
//                    if isContinuous2{
//                        index.append(operation.index(after: i-1))
//                        index.append(operation.index(after: i))
//                        isContinuous2 = false
//                    }else {
//                        index.append(operation.index(after: i))
//                    }
//                default:
//                    break
//                }
//            }
//            print(opr,index,inputNum,numArray)
//            for i in 0..<inputNum.count {
//                numArray.append(inputNum[index[i]])
//            }
//            print(opr,index,inputNum,numArray)
//            for i in 1..<opr.count {
//                returnVal = calc4Ways(num1: numArray[i-1], num2: numArray[i], opr: opr[i])
//                numArray[i] = returnVal
//            }
            //1+2*3*
            if (operation[0] == "+" || operation[0] == "-") && (operation[1] == "×" || operation[1] == "÷") &&
                (operation[2] == "×" || operation[2] == "÷") {
                returnVal = calc4Ways(num1: inputNum[1], num2: inputNum[2], opr: operation[1])
            }else {//1+2*3+
                returnVal = calc4Ways2(num1: inputNum[0], num2: inputNum[1],num3: inputNum[2], opr1: operation[0], opr2: operation[1])
            }
            print("operation.count == 3")
        }
        //print(operation,inputNum)
        return returnVal
    }
    
    func calc4Ways(num1: Double, num2: Double, opr: String) -> Double{
        var returnVal: Double = NSString(string: formulaLabel.text!).doubleValue
        switch opr {
        case "+":
            returnVal = num1 + num2
        case "-":
            returnVal = num1 - num2
        case "×":
            returnVal = num1 * num2
        case "÷":
            returnVal = num1 / num2
        default:
            break
        }
        //print(opr)
        return returnVal
    }
    
    func calc4Ways2(num1: Double, num2: Double,num3: Double, opr1: String, opr2: String) -> Double{
        var returnVal: Double = NSString(string: formulaLabel.text!).doubleValue
        let str = opr1 + opr2
        switch str {
        case "+×":
            returnVal = num1 + num2 * num3;
        case "-×":
            returnVal = num1 - num2 * num3;
        case "+÷":
            returnVal = num1 + num2 / num3;
        case "-÷":
            returnVal = num1 - num2 / num3;
        default:
            break
        }
        return returnVal
    }
}



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
        //小数点がある場合
        if formulaLabel.text!.hasPrefix("0.") || formulaLabel.text!.hasPrefix("-0.") {
            formulaLabel.text = formulaLabel.text! + sender.titleLabel!.text!
            print("input1")
        }else if formulaLabel.text!.hasPrefix("0") {
            formulaLabel.text = ""
            formulaLabel.text = sender.titleLabel!.text
            print("input2")
        }else if formulaLabel.text!.hasPrefix("-0"){
            formulaLabel.text = ""
            formulaLabel.text = "-" + sender.titleLabel!.text!
        }else{
            if isOperation{//演算子を選んだ直後
                formulaLabel.text = ""
                isOperation = false
                
            }
            formulaLabel.text = formulaLabel.text! + sender.titleLabel!.text!
            print("input3")
        }
        isInput = true
    }
    
    @IBAction func dotButtonInput(sender:UIButton){
        let dot = "."
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
            //inputNums.remove(at: 1)
            isEqual = false
            isOperation = true
            print("演算子訂正")
        }else if isInput {//数字が入力された直後
            isInput = false
            isOperation = true
            //選択した演算子のボタンのタイトルラベル文字列が入る
            operations.append((sender.titleLabel?.text)!)
            //現在、表示されている数字をDoubleにして１番目として保存
            inputNums.append(NSString(string: formulaLabel.text!).doubleValue)
            print("数字が入力された直後")
        }
//        else {//operationButtonSelectの連打 演算子が訂正（再選択）された場合
//            if inputNums.count != 0 && operations.count != 0 {
//                //operationsの最後の要素をsender.titleLabel?.text!に入れ替える
//                operations[operations.count-1] = (sender.titleLabel?.text!)!
//                print("演算子訂正")
//            }
//        }
//        let zipped = zip(inputNums, operations + [""])
//        let equation = zipped.reduce(""){ $0 + $1.0 + $1.1 }
//        print(zipped)
        //print(equation)
        
//        print(operations)
//        print(operations.count)
        result = caluculate(operation: self.operations, inputNum: self.inputNums)
        let str: String = String(format: "%g", result)
        formulaLabel.text = str
    }
    
    func caluculate(operation: [String], inputNum: [Double]) -> Double {
        var returnVal: Double = NSString(string: formulaLabel.text!).doubleValue
        if operation.count == 2 {
            guard (operations[0] == "+" || operations[0] == "-") && (operations[1] == "×" || operations[1] == "÷") else {
                //計算してreturnValに格納
                returnVal = calc4Ways(num1: inputNum[0], num2: inputNum[1], opr: operation[0])
                print("guard")
                return returnVal
            }
            print("operation.count == 2")
        }else if operation.count == 3 {
            returnVal = calc4Ways2(num1: inputNum[0], num2: inputNum[1],num3: inputNum[2], opr1: operation[0], opr2: operation[1])
            print("operation.count == 3")
        }
        return returnVal
    }
    
    func calc4Ways(num1: Double, num2: Double, opr: String) -> Double{
        var returnVal: Double = 0
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
        //計算結果を配列の適切な要素番号に格納
        inputNums[0] = returnVal
        //演算子が最後の文字の場合1+2-
        if isOperation {
            operations[0] = operations[1]
            //いらなくなった配列の要素を削除(removeAtIndex(n))
            inputNums.remove(at: 1)//1+2=の場合は+2を残すので削除しない
        }
        operations.remove(at: 1)
        print(operations)
        print(operations.count)
        return returnVal
    }
    
    func calc4Ways2(num1: Double, num2: Double,num3: Double, opr1: String, opr2: String) -> Double{
        var returnVal: Double = 0
        let str = opr1 + opr2
        switch str {
        case "+×":
            returnVal = num1 + num2 * num3
        case "-×":
            returnVal = num1 - num2 * num3
        case "+÷":
            returnVal = num1 + num2 / num3
        case "-÷":
            returnVal = num1 - num2 / num3
        default:
            break
        }
        //計算結果を配列の適切な要素番号に格納
        inputNums[0] = returnVal
        //演算子が最後の文字の場合1+2×3+
        if isOperation {
            operations[0] = operations[2]
            //いらなくなった配列の要素を削除(removeAtIndex(n))
            inputNums.removeSubrange(1...2)
        }
        else {//1+2×3=
            inputNums[1] = inputNums[2]
            operations[0] = operations[1]
            inputNums.remove(at: 2)
        }
        operations.removeSubrange(1...2)
        print(operations)
        print(operations.count)
        return returnVal
    }
    
    //=ボタン
    @IBAction func equalButtonAnswer(sender:UIButton){
        var result:Double = NSString(string: formulaLabel.text!).doubleValue
        if inputNums.count >= 1{
            isEqual = true
            //選択した演算子のボタンのタイトルラベル文字列が入る
            operations.append((sender.titleLabel?.text)!)
            inputNums.append(NSString(string: formulaLabel.text!).doubleValue)
            print(operations)
            print(inputNums)
            //計算してreturnValに格納
            result = caluculate(operation: self.operations, inputNum: self.inputNums)
        }
        let str: String = String(format: "%g", result)
        formulaLabel.text = str
    }
}



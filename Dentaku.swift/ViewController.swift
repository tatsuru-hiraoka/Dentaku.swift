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
    var firstInputString :String?
    var secondInputString :String?
    var thirdInputString :String?
    var isFirstFunction :Bool = false
    var isSecondFunction :Bool = false
    var isFirstPlus:Bool=false
    var isSecondPlus:Bool=false
    var isThirdPlus:Bool=false
    var isFirstMinus:Bool=false
    var isSecondMinus:Bool=false
    var isThirdMinus:Bool=false
    var isFirstMultiplication:Bool=false
    var isSecondMultiplication:Bool=false
    var isThirdMultiplication:Bool=false
    var isFirstDivision:Bool=false
    var isSecondDivision:Bool=false
    var isThirdDivision:Bool=false
    var isFirstPercent:Bool=false
    var isSecondPercent:Bool=false
    var isThirdPercent:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func acButtonPush(sender:UIButton){
        formulaLabel.text = "0"
        firstInputString = nil
        secondInputString = nil
        thirdInputString = nil
        isFirstFunction = false
        isSecondFunction = false
        isFirstPlus = false
        isFirstMinus = false
        isFirstMultiplication = false
        isFirstDivision = false
        isFirstPercent = false
        isSecondPlus = false
        isSecondMinus = false
        isSecondMultiplication = false
        isSecondDivision = false
        isSecondPercent = false
        isThirdPlus = false
        isThirdMinus = false
        isThirdMultiplication = false
        isThirdDivision = false
        isThirdPercent = false
    }
    
    @IBAction func numbersButtonInput(sender:UIButton){
        if isFirstFunction {
            if formulaLabel.text!.hasPrefix("0.")||formulaLabel.text!.hasPrefix("-0.") {
                formulaLabel.text=formulaLabel.text!+sender.titleLabel!.text!
                print("input1")
            }else if formulaLabel.text!.hasPrefix("0") {
                formulaLabel.text=""
                formulaLabel.text=sender.titleLabel!.text
                print("input2")
            }else if formulaLabel.text!.hasPrefix("-0"){
                formulaLabel.text=""
                formulaLabel.text="-"+sender.titleLabel!.text!
            }else{
                formulaLabel.text=""
                formulaLabel.text=formulaLabel.text! + sender.titleLabel!.text!
                print("input3")
            }
            isFirstFunction=false
        }else{
            if formulaLabel.text!.hasPrefix("0.")||formulaLabel.text!.hasPrefix("-0.") {
                formulaLabel.text=formulaLabel.text!+sender.titleLabel!.text!
                print("input1")
            }else if formulaLabel.text!.hasPrefix("0"){
                formulaLabel.text=""
                formulaLabel.text=sender.titleLabel!.text
                print("input2")
            }else if formulaLabel.text!.hasPrefix("-0"){
                formulaLabel.text=""
                formulaLabel.text="-"+sender.titleLabel!.text!
            }else{
                formulaLabel.text=formulaLabel.text!+sender.titleLabel!.text!
                print("input3")
            }
        }
        isSecondFunction=true
    }
    
    @IBAction func commaButtonInput(sender:UIButton){
        let comma = "."
        //formulaLabelの中にコンマがなかったら入力できる
        guard formulaLabel.text!.contains(comma)else{
            formulaLabel.text!=formulaLabel.text!+sender.titleLabel!.text!
            return
        }
    }
    
    @IBAction func plusOrMinusButtonChange(sender:UIButton){
        if formulaLabel.text!.hasPrefix("-") {
            formulaLabel.text!=String(formulaLabel.text![formulaLabel.text!.index(formulaLabel.text!.startIndex, offsetBy: 1)..<formulaLabel.text!.endIndex])
        }else{
            formulaLabel.text!="-"+formulaLabel.text!
        }
    }
    
    @IBAction func functionButtonSelect(sender:UIButton){
        let isPlus:Bool=sender.titleLabel?.text!=="+"
        let isMinus:Bool=sender.titleLabel?.text!=="-"
        let isMultiplication:Bool=sender.titleLabel?.text!=="×"
        let isDivision:Bool=sender.titleLabel?.text!=="÷"
        let isPercent:Bool=sender.titleLabel?.text!=="%"
        isFirstFunction=true
        
        if isSecondFunction==false {
            if secondInputString==nil{
                if isPlus{
                    isFirstPlus=true;isFirstMinus=false;isFirstMultiplication=false;isFirstDivision=false;isFirstPercent=false;
                }else if isMinus{
                    isFirstPlus=false;isFirstMinus=true;isFirstMultiplication=false;isFirstDivision=false;isFirstPercent=false;
                }else if isMultiplication{
                    isFirstPlus=false;isFirstMinus=false;isFirstMultiplication=true;isFirstDivision=false;isFirstPercent=false;
                }else if isDivision{
                    isFirstPlus=false;isFirstMinus=false;isFirstMultiplication=false;isFirstDivision=true;isFirstPercent=false;
                }else if isPercent{
                    isFirstPlus=false;isFirstMinus=false;isFirstMultiplication=false;isFirstDivision=false;isFirstPercent=true;
                }
            }else if thirdInputString==nil{
                if isPlus{
                    isSecondPlus=true;isSecondMinus=false;isSecondMultiplication=false;isSecondDivision=false;isSecondPercent=false;
                }else if isMinus{
                    isSecondPlus=false;isSecondMinus=true;isSecondMultiplication=false;isSecondDivision=false;isSecondPercent=false;
                }else if isMultiplication{
                    isSecondPlus=false;isSecondMinus=false;isSecondMultiplication=true;isSecondDivision=false;isSecondPercent=false;
                }else if isDivision{
                    isSecondPlus=false;isSecondMinus=false;isSecondMultiplication=false;isSecondDivision=true;isSecondPercent=false;
                }else if isPercent{
                    isSecondPlus=false;isSecondMinus=false;isSecondMultiplication=false;isSecondDivision=false;isSecondPercent=true;
                }
            }
        }else{
            if firstInputString==nil{
                firstInputString=formulaLabel.text!
                if isPlus{
                    isFirstPlus=true
                }else if isMinus{
                    isFirstMinus=true
                }else if isMultiplication{
                    isFirstMultiplication=true
                }else if isDivision{
                    isFirstDivision=true
                }else if isPercent{
                    isFirstPercent=true
                }
            }else if secondInputString==nil{
                secondInputString=formulaLabel.text!
                if isPlus{
                    isSecondPlus=true
                }else if isMinus{
                    isSecondMinus=true
                }else if isMultiplication{
                    isSecondMultiplication=true
                }else if isDivision{
                    isSecondDivision=true
                }else if isPercent{
                    isSecondPercent=true
                }
            }else if thirdInputString==nil{
                thirdInputString=formulaLabel.text!
                if isPlus{
                    isThirdPlus=true
                }else if isMinus{
                    isThirdMinus=true
                }else if isMultiplication{
                    isThirdMultiplication=true
                }else if isDivision{
                    isThirdDivision=true
                }else if isPercent{
                    isThirdPercent=true
                }
            }
            let secondInputStringNum: Double?
            let thirdInputStringNum: Double?
            let firstInputStringNum: Double? = NSString(string: firstInputString!).doubleValue
            if secondInputString != nil {
                secondInputStringNum = NSString(string: secondInputString!).doubleValue
            }
            else {
                secondInputStringNum = 0
            }
            if thirdInputString != nil {
                thirdInputStringNum = NSString(string: thirdInputString!).doubleValue
            }
            else {
                thirdInputStringNum = 0
            }
            
            if (isFirstPlus && isSecondPlus) {
                let answer:Double = firstInputStringNum! + secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isSecondPlus = false
            }else if (isFirstPlus && isSecondMinus) {
                let answer:Double = firstInputStringNum! - secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isSecondMinus = false
            }else if (isFirstMinus && isSecondPlus) {
                let answer:Double = firstInputStringNum! - secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstPlus = true
                isFirstMinus = false
                isSecondPlus = false
            }else if (isFirstMinus && isSecondMinus) {
                let answer:Double = firstInputStringNum! - secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isSecondMinus = false
            }else if (isFirstMultiplication && isSecondPlus) {
                let answer:Double = firstInputStringNum! * secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstMultiplication = false
                isFirstPlus = true
                isSecondPlus = false
            }else if (isFirstMultiplication && isSecondMinus) {
                let answer:Double = firstInputStringNum! * secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstMultiplication = false
                isFirstMinus = true
                isSecondMinus = false
            }else if (isFirstMultiplication && isSecondMultiplication) {
                let answer:Double = firstInputStringNum! * secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isSecondMultiplication = false
            }else if (isFirstMultiplication && isSecondDivision) {
                let answer:Double = firstInputStringNum! * secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstDivision = true
                isFirstMultiplication = false
                isSecondDivision = false
            }else if (isFirstDivision && isSecondPlus) {
                let answer:Double = firstInputStringNum! / secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstDivision = false
                isFirstPlus = true
                isSecondPlus = false
            }else if (isFirstDivision && isSecondMinus) {
                let answer:Double = firstInputStringNum! / secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstDivision = false
                isFirstMinus = true
                isSecondMinus = false
            }else if (isFirstDivision && isSecondMultiplication) {
                let answer:Double = firstInputStringNum! / secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isFirstDivision = false
                isFirstMultiplication = true
                isSecondMultiplication = false
            }else if (isFirstDivision && isSecondDivision) {
                let answer:Double = firstInputStringNum! / secondInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                isSecondDivision = false
            }else if (isFirstPlus && isSecondMultiplication && isThirdPlus) {
                var answer:Double = secondInputStringNum! * thirdInputStringNum!
                answer = firstInputStringNum! + answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isSecondMultiplication = false
                isThirdPlus = false
            }else if (isFirstPlus && isSecondMultiplication && isThirdMinus) {
                var answer:Double = secondInputStringNum! * thirdInputStringNum!
                answer = firstInputStringNum! + answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isFirstPlus = false
                isFirstMinus = true
                isSecondMultiplication = false
                isThirdMinus = false
            }else if (isFirstPlus && isSecondMultiplication && isThirdMultiplication) {
                let answer:Double = secondInputStringNum! * thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isThirdMultiplication = false
            }else if (isFirstPlus && isSecondMultiplication && isThirdDivision) {
                let answer:Double = secondInputStringNum! * thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isSecondMultiplication = false
                isSecondDivision = true
                isThirdDivision = false
            }else if (isFirstPlus && isSecondDivision && isThirdPlus) {
                var answer:Double = secondInputStringNum! / thirdInputStringNum!
                answer = firstInputStringNum! + answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isSecondDivision = false
                isThirdPlus = false
            }else if (isFirstPlus && isSecondDivision && isThirdMinus) {
                var answer:Double = secondInputStringNum! / thirdInputStringNum!
                answer = firstInputStringNum! + answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isFirstPlus = false
                isFirstMinus = true
                isSecondDivision = false
                isThirdMinus = false
            }else if (isFirstPlus && isSecondDivision && isThirdMultiplication) {
                let answer:Double = secondInputStringNum! / thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isSecondDivision = false
                isSecondMultiplication = true
                isThirdMultiplication = false
            }else if (isFirstPlus && isSecondDivision && isThirdDivision) {
                let answer:Double = secondInputStringNum! / thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isThirdDivision = false
            }else if (isFirstMinus && isSecondMultiplication && isThirdPlus) {
                var answer:Double = secondInputStringNum! * thirdInputStringNum!
                answer = firstInputStringNum! - answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isFirstPlus = true
                isFirstMinus = false
                isSecondMultiplication = false
                isThirdPlus = false
            }else if (isFirstMinus && isSecondMultiplication && isThirdMinus) {
                var answer:Double = secondInputStringNum! * thirdInputStringNum!
                answer = firstInputStringNum! - answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isSecondMultiplication = false
                isThirdMinus = false
            }else if (isFirstMinus && isSecondMultiplication && isThirdMultiplication) {
                let answer:Double = secondInputStringNum! * thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isThirdMultiplication = false
            }else if (isFirstMinus && isSecondMultiplication && isThirdDivision) {
                let answer:Double = secondInputStringNum! * thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isSecondMultiplication = false
                isSecondDivision = true
                isThirdDivision = false
            }else if (isFirstMinus && isSecondDivision && isThirdPlus) {
                var answer:Double = secondInputStringNum! / thirdInputStringNum!
                answer = firstInputStringNum! - answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isFirstPlus = true
                isFirstMinus = false
                isSecondDivision = false
                isThirdPlus = false
            }else if (isFirstMinus && isSecondDivision && isThirdMinus) {
                var answer:Double = secondInputStringNum! / thirdInputStringNum!
                answer = firstInputStringNum! - answer
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                firstInputString = str
                secondInputString = nil
                thirdInputString = nil
                isSecondDivision = false
                isThirdMinus = false
            }else if (isFirstMinus && isSecondDivision && isThirdMultiplication) {
                let answer:Double = secondInputStringNum! / thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isSecondDivision = false
                isSecondMultiplication = true
                isThirdMultiplication = false
            }else if (isFirstMinus && isSecondDivision && isThirdDivision) {
                let answer:Double = secondInputStringNum! / thirdInputStringNum!
                let str: String = String(format: "%.2f", answer)
                formulaLabel.text = str
                secondInputString = str
                thirdInputString = nil
                isThirdDivision = false
            }
        }
    }
    
    @IBAction func equalButtonAnswer(sender:UIButton){
        var secondInputStringNum: Double?
        let thirdInputStringNum: Double?
        let firstInputStringNum: Double? = NSString(string: firstInputString!).doubleValue
        let formulaLabelStringNum: Double? = NSString(string: formulaLabel.text!).doubleValue
        if secondInputString != nil {
            secondInputStringNum = NSString(string: secondInputString!).doubleValue
        }
        else if secondInputString == nil {
            secondInputStringNum = NSString(string: formulaLabel.text!).doubleValue
            if isFirstPlus {
                let answer:Double = firstInputStringNum! + secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("secondInputString isFirstPlus")
            }else if isFirstMinus {
                let answer:Double = firstInputStringNum! - secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("secondInputString isFirstMinus")
            }else if isFirstMultiplication {
                let answer:Double = firstInputStringNum! * secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("secondInputString isFirstMultiplication")
            }else if isFirstDivision {
                let answer:Double = firstInputStringNum! / secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("secondInputString isFirstDivision")
            }
        }
        if thirdInputString != nil {
            thirdInputStringNum = NSString(string: thirdInputString!).doubleValue
        }else {
            secondInputStringNum = NSString(string: formulaLabel.text!).doubleValue
            thirdInputStringNum = NSString(string: formulaLabel.text!).doubleValue
            if isFirstPlus {
                let answer:Double = formulaLabelStringNum! + secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("thirdInputString isFirstPlus")
            }else if isFirstMinus {
                let answer:Double = formulaLabelStringNum! - secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("thirdInputString isFirstMinus")
            }else if isFirstMultiplication {
                let answer:Double = formulaLabelStringNum! * secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("thirdInputString isFirstMultiplication")
            }else if isFirstDivision {
                let answer:Double = formulaLabelStringNum! / secondInputStringNum!
                let str: String = String(format: "%f", answer)
                formulaLabel.text = str
                firstInputString = str
                print("thirdInputString isFirstDivision")
            }else if isFirstPlus && isSecondMultiplication {
                var answer:Double = secondInputStringNum! * thirdInputStringNum!
                answer = firstInputStringNum! + answer
                let str: String = String(format: "%.2f", answer)
                secondInputString = formulaLabel.text
                formulaLabel.text = str
                firstInputString = str
                isFirstPlus = false
                isFirstMultiplication = true
                isSecondMultiplication = false
                print("thirdInputString isFirstPlus && isSecondMultiplication")
            }else if isFirstPlus && isSecondDivision {
                var answer:Double = secondInputStringNum! / thirdInputStringNum!
                answer = firstInputStringNum! + answer
                let str: String = String(format: "%.2f", answer)
                secondInputString = formulaLabel.text
                formulaLabel.text = str
                firstInputString = str
                isFirstPlus = false
                isFirstDivision = true
                isSecondDivision = false
                print("thirdInputString isFirstPlus && isSecondDivision")
            }else if isFirstMinus && isSecondMultiplication {
                var answer:Double = secondInputStringNum! * thirdInputStringNum!
                answer = firstInputStringNum! - answer
                let str: String = String(format: "%.2f", answer)
                secondInputString = formulaLabel.text
                formulaLabel.text = str
                firstInputString = str
                isFirstMinus = false
                isFirstMultiplication = true
                isSecondMultiplication = false
                print("thirdInputString isFirstMinus && isSecondMultiplication")
            }else if isFirstMinus && isSecondDivision {
                var answer:Double = secondInputStringNum! / thirdInputStringNum!
                answer = firstInputStringNum! - answer
                let str: String = String(format: "%.2f", answer)
                secondInputString = formulaLabel.text
                formulaLabel.text = str
                firstInputString = str
                isFirstMinus = false
                isFirstDivision = true
                isSecondDivision = false
                print("thirdInputString isFirstMinus && isSecondDivision")
            }
        }
    }


}


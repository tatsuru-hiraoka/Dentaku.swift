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
    var operationBtnStr:String = ""
    var isOperation :Bool = false
    var isInput :Bool = false
    var count :Int = 0
    var firstInputStrNum: Double = 0
    var secondInputStrNum: Double = 0
    var thirdInputStrNum: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulaLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func acButtonPush(sender:UIButton){
        count = 0
        formulaLabel.text = "0"
        operationBtnStr = ""
        isOperation = false
        isInput = false
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
        if isInput {//数字が入力された直後
            isInput = false
            isOperation = true
            switch count {
            case 0://１回目の選択(1+
                //選択した演算子のボタンのタイトルラベル文字列が入る
                operationBtnStr = (sender.titleLabel?.text)!
                //現在、表示されている数字をDoubleにして１番目として保存
                firstInputStrNum = NSString(string: formulaLabel.text!).doubleValue
                print(firstInputStrNum)
            case 1://２回目の選択(1+2×
                //最初の演算子の文字列に選択した演算子の文字列をたす
                operationBtnStr = operationBtnStr + (sender.titleLabel?.text!)!
                //現在、表示されている数字をDoubleにして２番目として保存
                secondInputStrNum = NSString(string: formulaLabel.text!).doubleValue
                print(secondInputStrNum)
            case 2://３回目(1+2×3+
                operationBtnStr = operationBtnStr + (sender.titleLabel?.text!)!
                //現在、表示されている数字をDoubleにして３番目として保存
                thirdInputStrNum = NSString(string: formulaLabel.text!).doubleValue
                print(thirdInputStrNum)
            default:
                break
            }
            count += 1
        }else {//operationButtonSelectの連打 演算子が訂正（再選択）された場合
            switch count{
            case 1:
                operationBtnStr = (sender.titleLabel?.text)!
            case 2://operationBtnStrの末尾１文字を削除し、新しく選択された演算子を追加する
                let text = operationBtnStr.prefix((operationBtnStr.count)-1)
                operationBtnStr = text + (sender.titleLabel?.text!)!
                print(operationBtnStr)
            case 3:
                let text = operationBtnStr.prefix((operationBtnStr.count)-1)
                operationBtnStr = text + (sender.titleLabel?.text!)!
                print(operationBtnStr)
            default://数字が入力されてない状態で演算子のみ選択されたら
                //選択した演算子のボタンのタイトルラベル文字列が入る
                operationBtnStr = (sender.titleLabel?.text)!
                firstInputStrNum = 0
                count = 1
            }
            //countは+1されない
        }
        
        print(count)
        
        var result:Double = NSString(string: formulaLabel.text!).doubleValue
        
        switch operationBtnStr {
        case "++"://1+2+
            result = firstInputStrNum + secondInputStrNum
            print(firstInputStrNum,secondInputStrNum)
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
            print(result)
        case "+-"://1+2-
            result = firstInputStrNum + secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "-+"://1-2+
            result = firstInputStrNum - secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "--"://1-2-
            result = firstInputStrNum - secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "+×","+÷","-×","-÷"://1+2× or 1+2÷ or 1-2× or 1-2÷
            return
        case "×+"://1×2+
            result = firstInputStrNum * secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "×-"://1×2-
            result = firstInputStrNum * secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "××"://1×2×
            result = firstInputStrNum * secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "*"
            count = 1
        case "×÷"://1×2÷
            result = firstInputStrNum * secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "÷"
            count = 1
        case "÷+"://1÷2+
            result = firstInputStrNum / secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "÷-"://1÷2-
            result = firstInputStrNum / secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "÷×"://1÷2×
            result = firstInputStrNum / secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "×"
            count = 1
        case "÷÷"://1÷2÷
            result = firstInputStrNum / secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "÷"
            count = 1
        case "+×+"://1+2×3+
            result = secondInputStrNum * thirdInputStrNum
            result = firstInputStrNum + result
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "+×-"://1+2×3-
            result = secondInputStrNum * thirdInputStrNum
            result = firstInputStrNum + result
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "+××"://1+2×3×
            result = secondInputStrNum * thirdInputStrNum
            secondInputStrNum = result//1+6×
            operationBtnStr = "+×"
            count = 2
        case "+×÷"://1+2×3÷
            result = secondInputStrNum * thirdInputStrNum
            secondInputStrNum = result//1+6÷
            operationBtnStr = "+÷"
            count = 2
        case "+÷+"://1+2÷3+
            result = secondInputStrNum / thirdInputStrNum
            result = firstInputStrNum + result
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "+÷-"://1+2÷3-
            result = secondInputStrNum / thirdInputStrNum
            result = firstInputStrNum + result
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "+÷×"://1+2÷3×
            result = secondInputStrNum / thirdInputStrNum
            secondInputStrNum = result
            operationBtnStr = "+×"
            count = 2
        case "+÷÷"://1+2÷3÷
            result = secondInputStrNum / thirdInputStrNum
            secondInputStrNum = result
            operationBtnStr = "+÷"
            count = 2
        case "-×+"://1-2×3+
            result = secondInputStrNum * thirdInputStrNum
            result = firstInputStrNum - result
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "-×-"://1-2×3-
            result = secondInputStrNum * thirdInputStrNum
            result = firstInputStrNum - result
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "-××"://1-2×3×
            result = secondInputStrNum * thirdInputStrNum
            secondInputStrNum = result//1-6×
            operationBtnStr = "-×"
            count = 2
        case "-×÷"://1-2×3÷
            result = secondInputStrNum * thirdInputStrNum
            secondInputStrNum = result//1-6÷
            operationBtnStr = "-÷"
            count = 2
        case "-÷+"://1-2÷3+
            result = secondInputStrNum / thirdInputStrNum
            result = firstInputStrNum - result
            firstInputStrNum = result
            operationBtnStr = "+"
            count = 1
        case "-÷-"://1+2÷3-
            result = secondInputStrNum / thirdInputStrNum
            result = firstInputStrNum - result
            firstInputStrNum = result
            operationBtnStr = "-"
            count = 1
        case "-÷×"://1-2÷3×
            result = secondInputStrNum / thirdInputStrNum
            secondInputStrNum = result//1-0.66666667×
            operationBtnStr = "-×"
            count = 2
        case "-÷÷"://1-2÷3÷
            result = secondInputStrNum / thirdInputStrNum
            secondInputStrNum = result//1-0.6666667÷
            operationBtnStr = "-÷"
            count = 2
        default:
            break
        }
        let str: String = String(format: "%.\(String(describing: result))f", result)
        formulaLabel.text = str
    }
    
    //=ボタン
    @IBAction func equalButtonAnswer(sender:UIButton){
        switch count {
        case 1://1+2= or 1+=
            //現在、表示されている数字をDoubleにして２番目として保存
            secondInputStrNum = NSString(string: formulaLabel.text!).doubleValue
            print(secondInputStrNum)
        case 2://1+2×3= or 1+2×3+=
            //現在、表示されている数字をDoubleにして３番目として保存
            thirdInputStrNum = NSString(string: formulaLabel.text!).doubleValue
            print(thirdInputStrNum)
        default:
            break
        }
        
        var result:Double = NSString(string: formulaLabel.text!).doubleValue
        
        switch operationBtnStr {
        case "+"://1+2= or 1+=
            result = firstInputStrNum + secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "+"
        case "-"://1-=
            result = firstInputStrNum - secondInputStrNum
            firstInputStrNum = result
            operationBtnStr = "-"
        case "×"://1×=
            result = firstInputStrNum * secondInputStrNum
            firstInputStrNum = result
        case "÷"://1÷=
            result = firstInputStrNum / secondInputStrNum
            firstInputStrNum = result
        case "+×"://1+2*3=
            result = secondInputStrNum * thirdInputStrNum
            secondInputStrNum = result
            result = firstInputStrNum + secondInputStrNum
            firstInputStrNum = result
            secondInputStrNum = thirdInputStrNum
            operationBtnStr = "×"//7*3
        case "+÷"://1+2÷3=
            result = secondInputStrNum / thirdInputStrNum
            secondInputStrNum = result
            result = firstInputStrNum + secondInputStrNum
            firstInputStrNum = result
            secondInputStrNum = thirdInputStrNum
            operationBtnStr = "÷"//1.66666667÷3
        case "-×"://1-2×3=
            result = secondInputStrNum * thirdInputStrNum
            secondInputStrNum = result
            result = firstInputStrNum - secondInputStrNum
            firstInputStrNum = result
            secondInputStrNum = thirdInputStrNum
            operationBtnStr = "÷"//-5×3
        case "-÷"://1-2÷3=
            result = secondInputStrNum / thirdInputStrNum
            secondInputStrNum = result
            result = firstInputStrNum - secondInputStrNum
            firstInputStrNum = result
            secondInputStrNum = thirdInputStrNum
            operationBtnStr = "÷"//0.33333333÷3
        default:
            break
        }
        count = 0
        
//        //let number = 50
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .spellOut
//        let str = formatter.string(from: result as NSNumber) ?? ""
        
//        let hoge :NSNumber = result as NSNumber
//        //hoge = NSNumber(result)
//        let str: String = String(format:"%f", hoge.doubleValue)
//        formulaLabel.text = str
        
        //let dot: String = String(result).components(separatedBy: ".")
        
        let str: String = String(format: "%.\(String(describing: result))f", result)
//        if str.hasPrefix("."){
//            str = String(format: "%.1f", result)
//        }else {
//            str = String(format: "%d", result)
//        }
        formulaLabel.text = str
    }
}


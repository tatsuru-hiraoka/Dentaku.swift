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
    /*@IBOutlet var AC :UIButton!
    @IBOutlet var Change :UIButton!
    @IBOutlet var Answer :UIButton!
    @IBOutlet var Input :UIButton!
    @IBOutlet var Comma :UIButton!
    @IBOutlet var Function :UIButton!*/
    var first:String?
    var second:String?
    var third:String?
    let Function1=false
    let Function2=false
    let FP=false
    let SP=false
    let TP=false
    let FM=false
    let SM=false
    let TM=false
    let FK=false
    let SK=false
    let TK=false
    let FD=false
    let SD=false
    let TD=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func AC(sender:UIButton){
        formulaLabel.text="0"
    }
    
    @IBAction func Input(sender:UIButton){
        if formulaLabel.text!.hasPrefix("0.") {
            formulaLabel.text=formulaLabel.text! + sender.titleLabel!.text!
             print("input1")
        }
        else if formulaLabel.text!.hasPrefix("0") {
            formulaLabel.text=""
            formulaLabel.text=sender.titleLabel!.text
            print("input2")
        }
        else{
            formulaLabel.text=""
            formulaLabel.text=formulaLabel.text! + sender.titleLabel!.text!
            print("input3")
        }
        
    }
    
    @IBAction func Comma(sender:UIButton){
        let Comma = "."
        
        /*if formulaLabel.text!.contains(Comma) {
            formulaLabel.text!=formulaLabel.text!+sender.titleLabel!.text!
        }*/
        
        //formulaLabelの中にコンマがなかったら入力できる
        guard formulaLabel.text!.contains(Comma)else{
            formulaLabel.text!=formulaLabel.text!+sender.titleLabel!.text!
            return
        }
        /*let range = formulaLabel.text!.range(of: ".")
        //let notFoundRange = NSRange(location: NSNotFound, length: 0)
        if range.location==NSNotFound {
            formulaLabel.text!=formulaLabel.text!+sender.titleLabel!.text!
        }*/
    }
    
    @IBAction func Change(sender:UIButton){
        //let text = formulaLabel.text!.prefix(1)
        if formulaLabel.text!.hasPrefix("-") {
            
        }
        /*BOOL minus = [_formulaLabel.text hasPrefix:@"-"];
        NSString *str=@"-";
        if (minus) {
            _formulaLabel.text=[_formulaLabel.text substringFromIndex:1];
        }
        else{
            _formulaLabel.text=[str stringByAppendingString:_formulaLabel.text];
        }*/
    }
    
    @IBAction func Function(sender:UIButton){
        
    }
    
    @IBAction func Answer(sender:UIButton){
        print("answer")
    }


}


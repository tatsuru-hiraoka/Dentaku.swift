//
//  NumFormat.swift
//  Dentaku.swift
//
//  Created by 平岡 建 on 2018/04/24.
//  Copyright © 2018年 平岡 建. All rights reserved.
//

import Foundation

class NumFormat {
    
    static func make2Digits (number: Double) -> String {
        let str:String
        
        str = String(format: "%.2f", number)
        
        return str
    }
}

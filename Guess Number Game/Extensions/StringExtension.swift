//
//  StringExtension.swift
//  Guess Number Game
//
//  Created by Vova on 05.08.2021.
//

import Foundation

extension String {
   var isEmptyOrNumeric: Bool {
//     return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    return self == "" || self.allSatisfyEnumerated(closure: { index, item in
        if index == 0 {
            return item == "-" || item.isNumber
        } else {
            return item.isNumber
        }
    })
   }
    
    func allSatisfyEnumerated(closure: (Int, Self.Element) -> Bool) -> Bool {
        let array = Array(self)
        
        for (index, item) in array.enumerated() {
            if !closure(index, item) { return false }
        }
        
        return true
    }
}

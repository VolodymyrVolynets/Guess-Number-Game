//
//  StringExtension.swift
//  Guess Number Game
//
//  Created by Vova on 05.08.2021.
//

import Foundation

extension String {
   var isNumericAndNotEmpty: Bool {
       guard self.isEmpty else { return false }
       return self.allSatisfy { $0.isNumber }
   }
    
    func allSatisfyEnumerated(closure: (Int, Self.Element) -> Bool) -> Bool {
        let array = Array(self)
        
        for (index, item) in array.enumerated() {
            if !closure(index, item) { return false }
        }
        
        return true
    }
    
    mutating func validateStringByPattern(pattern: String) {
        let result = self.range(
            of: pattern,
            options: .regularExpression
        )
        
        guard let result = result else {
            // if can`t find patern in string, make string empty
            self = ""
            return
        }
        
        // change wrappedValue
        self = String(self[result])
    }
}

//
//  Test.swift
//  Guess Number Game
//
//  Created by Vova on 14.08.2021.
//

import Foundation

protocol SpecificNumericRange {
}
extension SpecificNumericRange {
    func test() {
        print("1")
    }
}

extension ClosedRange: SpecificNumericRange where Bound: Numeric {
    
}


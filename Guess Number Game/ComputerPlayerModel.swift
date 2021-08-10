//
//  ComputerPlayerModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

struct ComputerPlayerModel {
    private let range: Range<Int>
    private var guessNumberRange: Range<Int>
    init(range: Range<Int>) {
        self.range = range
        self.guessNumberRange = range
    }
    
    func createNumber() -> Int {
        let randomNum = range.randomElement() ?? 0
        
        print("computer variable: \(randomNum)")
        
        return randomNum
    }
    
    mutating func guessNumber(closure: (Int) -> GuessNumberModel.GuessNumberOut) {
        guard let randomNumber = guessNumberRange.randomElement() else { return }
        
        let result = closure(randomNumber)
        
            if result == .greater {
            guard let safeCurrentRangeMax = guessNumberRange.max() else { return }
            guessNumberRange = randomNumber + 1..<safeCurrentRangeMax + 1
        } else {
            guard let safeCurrentRangeMin = guessNumberRange.min() else { return }
            guessNumberRange = safeCurrentRangeMin..<randomNumber
        }
    }
}

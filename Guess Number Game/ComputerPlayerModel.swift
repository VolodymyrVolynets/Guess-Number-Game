//
//  ComputerPlayerModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

struct ComputerPlayerModel {
    private let range: Range<Int>
    private var currentRange: Range<Int>
    init(range: Range<Int>) {
        self.range = range
        self.currentRange = range
    }
    
    func createNumber() -> Int {
        range.randomElement() ?? 0
    }
    
    mutating func guessNumber(closure: (Int) -> GuessNumberModel.GuessNumberOut) {
        guard let randomNumber = currentRange.randomElement() else { return }
        
        let result = closure(randomNumber)
        
            if result == .greater {
            guard let safeCurrentRangeMax = currentRange.max() else { return }
            currentRange = randomNumber..<safeCurrentRangeMax
        } else {
            guard let safeCurrentRangeMin = currentRange.min() else { return }
            currentRange = safeCurrentRangeMin..<randomNumber
        }
    }
}

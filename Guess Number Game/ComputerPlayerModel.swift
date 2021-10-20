//
//  ComputerPlayerModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

struct ComputerPlayerModel<Element> where Element: BinaryInteger, Element.Stride: SignedInteger {
    private let range: ClosedRange<Element>
    private var guessNumberRange: ClosedRange<Element>
    init(range: ClosedRange<Element>) {
        self.range = range
        self.guessNumberRange = range
    }
    
    func createNumber() -> Element {
        let randomNum = range.randomElement()
        
        return randomNum ?? 0
    }
    
    mutating func guessNumber(closure: (Element) -> GuessNumberOut) {
        guard let randomNumber = guessNumberRange.randomElement() else { return }
        
        let result = closure(randomNumber)
        
        if result == .greater {
            guard let safeCurrentRangeMax = guessNumberRange.max() else { return }
            guessNumberRange = randomNumber + 1...safeCurrentRangeMax
        } else if result == .less {
            guard let safeCurrentRangeMin = guessNumberRange.min() else { return }
            guessNumberRange = safeCurrentRangeMin...randomNumber - 1
        }
    }
}

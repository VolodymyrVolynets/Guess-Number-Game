//
//  GuessNumberModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation


struct GuessNumberModel<Element> where Element: BinaryInteger {
    private let range: ClosedRange<Element>
    private let playerOneNumber: Element
    private let playerTwoNumber: Element
    private(set) var isPlayerOneTurn = true
    private(set) var playerOneFails: Int = 0
    private(set) var playerTwoFails: Int = 0
    
    init(range: ClosedRange<Element>, playerOneNumber: Element, playerTwoNumber: Element) {
        self.range = range
        self.playerOneNumber = playerOneNumber
        self.playerTwoNumber = playerTwoNumber
    }
    
    mutating func checkEnteredNumber(enteredNumber: Element) -> GuessNumberOut {
        let numberToCompare = isPlayerOneTurn ? playerTwoNumber : playerOneNumber
        let guessNumberOut: GuessNumberOut
        
        if numberToCompare == enteredNumber {
            guessNumberOut = .equal
            if isPlayerOneTurn {
                changeTurn()
            } else {
//                isEndGame = true
            }
            
        } else {
            addFailScore()
            
            
            guessNumberOut = numberToCompare > enteredNumber ? .greater : .less
        }
        
        return guessNumberOut
    }
    
    private mutating func changeTurn() {
        isPlayerOneTurn = false
    }
    
    private mutating func addFailScore() {
        if isPlayerOneTurn {
            playerOneFails += 1
        } else {
            playerTwoFails += 1
        }
    }
}
enum GuessNumberOut {
    case less
    case greater
    case equal
}

extension GuessNumberOut {
    var discription: String {
        switch self {
        case .equal:
            return "equal"
        case .greater:
            return "greater"
        case .less:
            return "less"
        }
    }
}

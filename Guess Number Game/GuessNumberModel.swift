//
//  GuessNumberModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation


struct GuessNumberModel {
    private let range: Range<Int>
    private let playerOneNumber: Int
    private let playerTwoNumber: Int
    private(set) var isPlayerOneTurn = true
    private(set) var playerOneFails: Int = 0
    private(set) var playerTwoFails: Int = 0
    
    init(range: Range<Int>, playerOneNumber: Int, playerTwoNumber: Int) {
        self.range = range
        self.playerOneNumber = playerOneNumber
        self.playerTwoNumber = playerTwoNumber
    }
    
    mutating func checkEnteredNumber(enteredNumber: Int) -> GuessNumberOut {
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
    
    enum GuessNumberOut {
        case less
        case greater
        case equal
    }
}

extension GuessNumberModel.GuessNumberOut {
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

//
//  GuessNumberModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

enum GuessNumberOut {
    case less
    case greater
    case equal
}

struct GuessNumberModel {
    private let range: Range<Int>
    private let playerOneNumber: Int
    private let playerTwoNumber: Int
    private var isPlayerOneTurn = true
    private var playerOneFails: Int = 0
    private var playerTwoFails: Int = 0
    
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
                
            }
            
        } else {
            
            addFailScore()
            
            if numberToCompare > enteredNumber {
                guessNumberOut = .greater
            } else {
                guessNumberOut = .less
            }
        }
        
        return guessNumberOut
    }
    
    private mutating func changeTurn() {
        isPlayerOneTurn = false
    }
    
    private mutating func addFailScore() {
        if isPlayerOneTurn {
            playerTwoFails += 1
        } else {
            playerOneFails += 1
        }
    }
}

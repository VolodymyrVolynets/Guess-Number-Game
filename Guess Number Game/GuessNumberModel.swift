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
    private let computerNumber: Int
    private let playerNumber: Int
    private var isPlayerTurn = true
    private var computerScore: Int = 0
    private var playerScore: Int = 0
    
    init(range: Range<Int>, playerNumber number: Int) {
        self.range = range
        computerNumber = Int.random(in: range)
        playerNumber = number
    }
    
    func checkEnteredNumber(enteredNumber: Int) -> GuessNumberOut {
        let numberToCompare = isPlayerTurn ? playerNumber : computerNumber
        let guessNumberOut: GuessNumberOut
        
        if numberToCompare == enteredNumber {
            guessNumberOut = .equal
        } else if numberToCompare > enteredNumber {
            guessNumberOut = .greater
        } else {
            guessNumberOut = .less
        }
        
        return guessNumberOut
    }
    
    mutating func changeTurn() {
        isPlayerTurn.toggle()
    }
    
    
    
}

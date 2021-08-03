//
//  GuessNumberViewModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var guessNumberModel: GuessNumberModel
    let computerPlayerModel: ComputerPlayerModel
    let range: Range<Int> = -100..<100
    var isPlayerOneTurn: Bool {
        guessNumberModel.isPlayerOneTurn
    }
    var playerOneFails: Int {
        guessNumberModel.playerOneFails
    }
    var playerTwoFails: Int {
        guessNumberModel.playerTwoFails
    }
    
    init(playerOneEnteredNumber: Int) {
        self.computerPlayerModel = ComputerPlayerModel(range: range)
        let playerOneEnteredNumber = playerOneEnteredNumber
        let playerTwoEnteredNumber = computerPlayerModel.createNumber()
        self.guessNumberModel = GuessNumberModel(range: range, playerOneNumber: playerOneEnteredNumber, playerTwoNumber: playerTwoEnteredNumber)
    }
    
    func makeChoice(number: Int) -> GuessNumberModel.GuessNumberOut{
        guessNumberModel.checkEnteredNumber(enteredNumber: number)
    }
    
    
}

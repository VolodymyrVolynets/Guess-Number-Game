//
//  GuessNumberViewModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var guessNumberModel: GuessNumberModel?
    var computerPlayerModel: ComputerPlayerModel
    let range: Range<Int> = -100..<100
    var isGameStarted: Bool {
        return guessNumberModel != nil ? true : false
    }
    var test: Int? {
        guessNumberModel?.playerOneFails
    }
    
    init() {
        self.computerPlayerModel = ComputerPlayerModel(range: range)
    }
    
    func startNewGame(playerOneEnteredNumber: Int) {
        let playerOneEnteredNumber = playerOneEnteredNumber
        let playerTwoEnteredNumber = computerPlayerModel.createNumber()
        print(playerTwoEnteredNumber)
        self.guessNumberModel = GuessNumberModel(range: range, playerOneNumber: playerOneEnteredNumber, playerTwoNumber: playerTwoEnteredNumber)
    }
    
    func makeChoice(number: Int) -> GuessNumberModel.GuessNumberOut?{
        return guessNumberModel?.checkEnteredNumber(enteredNumber: number)
    }
    
    
}

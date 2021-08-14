//
//  GuessNumberViewModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    typealias SignedIntegerElement = Int
    @Published var guessNumberModel: GuessNumberModel<SignedIntegerElement>?
    @Published var currentView: CurrentView = .startView {
        didSet {
            previousInput = ""
        }
    }
    var computerPlayerModel: ComputerPlayerModel<SignedIntegerElement>
    let range: ClosedRange<Int>
    var previousInput = ""
    var isGameStarted: Bool {
        return guessNumberModel != nil ? true : false
    }
    var isPlayerOneTurn: Bool {
        return guessNumberModel?.isPlayerOneTurn ?? true
    }
    var playerOneFails: Int {
        guessNumberModel?.playerOneFails ?? 0
    }
    var playerTwoFails: Int {
        guessNumberModel?.playerTwoFails ?? 0
    }
    
    init(range: ClosedRange<Int>) {
        self.range = range
        self.computerPlayerModel = ComputerPlayerModel(range: range)
    }
    
    func startNewGame(playerOneEnteredNumber: Int) {
        let playerOneEnteredNumber = playerOneEnteredNumber
        let playerTwoEnteredNumber = computerPlayerModel.createNumber()
        print(playerTwoEnteredNumber)
        self.guessNumberModel = GuessNumberModel(range: range, playerOneNumber: playerOneEnteredNumber, playerTwoNumber: playerTwoEnteredNumber)
    }
    
    func makeChoice(number: Int) -> GuessNumberOut? {
        previousInput = "\(number)"
        return guessNumberModel?.checkEnteredNumber(enteredNumber: number)
    }
    
    func computerMakeChoice() {
        guard var safeGuessNumberModel = guessNumberModel else { return }
        computerPlayerModel.guessNumber(closure: {safeGuessNumberModel.checkEnteredNumber(enteredNumber: $0)})
    }
    
    func startComputerTurn() {
        guard guessNumberModel != nil else { return }
        if !guessNumberModel!.isPlayerOneTurn {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                self.computerPlayerModel.guessNumber { number in
                    let result = self.guessNumberModel!.checkEnteredNumber(enteredNumber: number)
                    self.previousInput = "\(number)"
                    print("Computer turn: \(number)")
                    if result == .equal {
                        timer.invalidate()
                        self.currentView = .result
                        return result
                    }
                    return result
                }
            }
        }
    }
    
    enum CurrentView {
        case startView
        case playerEnterNumberView
        case playerGuessNumberView
        case result
    }
    
}

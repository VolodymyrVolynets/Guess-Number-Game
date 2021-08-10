//
//  GuessNumberViewModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var guessNumberModel: GuessNumberModel?
    @Published var currentView: CurrentView = .startView {
        didSet {
            previousInput = ""
        }
        get {
            currentView
        }
    }
    var computerPlayerModel: ComputerPlayerModel
    let range: Range<Int>
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
    
    init(range: Range<Int>) {
        self.range = range
        self.computerPlayerModel = ComputerPlayerModel(range: range)
    }
    
    func startNewGame(playerOneEnteredNumber: Int) {
        let playerOneEnteredNumber = playerOneEnteredNumber
        let playerTwoEnteredNumber = computerPlayerModel.createNumber()
        print(playerTwoEnteredNumber)
        self.guessNumberModel = GuessNumberModel(range: range, playerOneNumber: playerOneEnteredNumber, playerTwoNumber: playerTwoEnteredNumber)
    }
    
    func makeChoice(number: Int) -> GuessNumberModel.GuessNumberOut? {
        previousInput = "\(number)"
        return guessNumberModel?.checkEnteredNumber(enteredNumber: number)
    }
    
    func computerMakeChoice() {
        guard var safeGuessNumberModel = guessNumberModel else { return }
        computerPlayerModel.guessNumber(closure: {safeGuessNumberModel.checkEnteredNumber(enteredNumber: $0)})
    }
    
    func startComputerTurn() {
        print("1")
        guard guessNumberModel != nil else { return }
        print("2")
        if !guessNumberModel!.isPlayerOneTurn {
            print("3")
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                print("4")
                self.computerPlayerModel.guessNumber { number in
                    print("5")
                    let result = self.guessNumberModel!.checkEnteredNumber(enteredNumber: number)
                    self.previousInput = "\(number)"
                    print("Computer turn: \(number)")
                    if result == .equal {
                        timer.invalidate()
                        self.currentView = .result
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

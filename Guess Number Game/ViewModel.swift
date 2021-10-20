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
            withAnimation() {
                alert.isShow = false
            }
        }
    }
    var computerPlayerModel: ComputerPlayerModel<SignedIntegerElement>
    var range: ClosedRange<SignedIntegerElement>
    @Published var alert: (isShow :Bool, info: GuessNumberOut) = (false, .equal)
    
    let patternForIntString =
    // contains intenger (-infinity; 0) and (0; infinity)
    #"[-]?[1-9][0-9]*"# +
    // or
    #"|"# +
    // contains only 0
    #"[0]"# +
    // or
    #"|"# +
    // contains only -
    #"[-]"#
    
    
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
    var isPlayerOneWin: Bool {
        self.playerOneFails < self.playerTwoFails
    }
    
    init(range: ClosedRange<SignedIntegerElement>) {
        self.range = range
        self.computerPlayerModel = ComputerPlayerModel(range: range)
    }
    
    func restartGame() {
        self.computerPlayerModel = ComputerPlayerModel(range: self.range)
        changeView(to: .startView)
    }

    func startGame(playerOneEnteredNumber: SignedIntegerElement) {
        //reinit computer player to reset all properties
        computerPlayerModel = ComputerPlayerModel(range: range)
        
        let playerOneEnteredNumber = playerOneEnteredNumber
        let playerTwoEnteredNumber = computerPlayerModel.createNumber()
        
        //reinit game logic struct to reset all properties
        self.guessNumberModel = GuessNumberModel(range: range, playerOneNumber: playerOneEnteredNumber, playerTwoNumber: playerTwoEnteredNumber)
        
        //change view to start guessing numbers
        changeView(to: .playerGuessNumberView)
    }
    
    func startGuessingNumbers(playerOneEnteredNumber: SignedIntegerElement, playerTwoEnteredNumber: SignedIntegerElement) {
        let playerOneEnteredNumber = playerOneEnteredNumber
        let playerTwoEnteredNumber = playerTwoEnteredNumber
        
        //reinit game logic struct to reset all properties
        self.guessNumberModel = GuessNumberModel(range: range, playerOneNumber: playerOneEnteredNumber, playerTwoNumber: playerTwoEnteredNumber)
        
        //change view to start guessing numbers
        changeView(to: .playerGuessNumberView)
    }
    
    private func changeView(to view: CurrentView) {
        withAnimation() {
            currentView = view
        }
    }
    
    //create alert to show user number less greater or equal
    private func showAlert(alertInfo: GuessNumberOut) {
        alert.info = alertInfo
        
        withAnimation() {
            alert.isShow = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            withAnimation() {
                self.alert.isShow = false
            }
        }
    }
    
   //-------------------------------------------------
    func makeChoice(number: SignedIntegerElement) -> GuessNumberOut {
        guard let out = guessNumberModel?.checkEnteredNumber(enteredNumber: number) else { return .equal }
        
        showAlert(alertInfo: out)
        if out == .equal { changeView(to: .computerGuessNumberView) }
        
        return out
    }
    
    private func computerMakeChoice() {
        guard var guessNumberModel = guessNumberModel else { return }
        computerPlayerModel.guessNumber(closure: {guessNumberModel.checkEnteredNumber(enteredNumber: $0)})
    }
    
    func startComputerTurn(closure: @escaping (_ number: Int) -> ()) {
        guard guessNumberModel != nil else { return }
        if !guessNumberModel!.isPlayerOneTurn {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                self.computerPlayerModel.guessNumber { number in
                    closure(number)
                    let result = self.guessNumberModel!.checkEnteredNumber(enteredNumber: number)
                    self.showAlert(alertInfo: result)
                    if result == .equal {
                        timer.invalidate()
                        self.changeView(to: .result)
                        return result
                    }
                    return result
                }
            }
        }
    }
    
    func validateString(string: String) -> String {
        var validatedString = string
        
        validatedString.validateStringByPattern(pattern: patternForIntString)
        
        if isValidIntString(string: validatedString) {
            if Int(validatedString)! < range.min() ?? 0 {validatedString = "\(range.min() ?? 0)" }
            else if Int(validatedString)! > range.max() ?? 0 { validatedString = "\(range.max() ?? 0)" }
        }
        
        return validatedString
    }
    
    func isValidIntString(string: String) -> Bool {
        let patternForValidInt =
        // contains intenger (-infinity; 0) and (0; infinity)
        #"^[-]?[1-9][0-9]*$"# +
        // or
        #"|"# +
        // contains only 0
        #"^[0]$"#

        let result = string.range(
            of: patternForValidInt,
            options: .regularExpression
        )

        return result != nil
    }
    
    
    func showConfettiCannon(trigget: Binding<Int>, isShowingCannon: Binding<Bool>) {
        if isPlayerOneWin {
            isShowingCannon.wrappedValue = true
            Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { _ in
                trigget.wrappedValue += 1
            }
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                withAnimation() {
                    isShowingCannon.wrappedValue = false
                }
            }
        }
    }
    
    
    enum CurrentView {
        case startView
        case playerEnterNumberView
        case playerGuessNumberView
        case computerGuessNumberView
        case result
    }
    
}

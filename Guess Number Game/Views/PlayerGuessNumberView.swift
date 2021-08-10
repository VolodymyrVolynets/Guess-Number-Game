//
//  PlayerGuessNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct PlayerGuessNumberView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var textField = ""
    
    @State var result: GuessNumberModel.GuessNumberOut?
    
    var range: Range<Int> {
        viewModel.range
    }
    
    var enteredNumber: Int {
        Int(textField) ?? 0
    }
    
    
    var fails: Int {
        if let safeModel = viewModel.guessNumberModel {
            return safeModel.isPlayerOneTurn ? safeModel.playerOneFails : safeModel.playerTwoFails
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack {
            Text("PlayerGuessNumberView")
            Text("\(viewModel.playerOneFails)")
            Text("\(viewModel.playerTwoFails)")
            Text(result != nil ? "Hidden number is: \(result!.discription)" : "")
            TextField("Number", text: $textField.didSet({ (newValue: String, oldValue: String) in
                if !(newValue.isEmptyOrNumeric && range.contains(Int(newValue) ?? 0)) {
                    textField = oldValue
                }
            }))
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            
            
            
            Button(action: {
                if viewModel.isPlayerOneTurn {
                    result = viewModel.makeChoice(number: enteredNumber)
                } else {
                    viewModel.startComputerTurn()
                }
            }, label: {
                Text(viewModel.isPlayerOneTurn ? "Guess" : "Start Computer")
            })
        }
        .onTapGesture {
            endEditing()
        }
    }
}

struct PlayerGuessNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGuessNumberView(viewModel: ViewModel(range: -100..<100))
    }
}

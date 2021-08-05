//
//  PlayerGuessNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct PlayerGuessNumberView: View {
    
    @Binding var currentView: CurrentView
    @ObservedObject var viewModel: ViewModel
    @State var textfield = ""
    @State var previousInput = ""

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
            Text("\(viewModel.test!) fails")
            TextField("", text: $textfield)
                .keyboardType(.decimalPad)
            
            Text(previousInput)
            
            Button(action: {
                previousInput = textfield
                if viewModel.makeChoice(number: Int(textfield) ?? 0) == .equal {
                    currentView = .result
                }
//                viewModel.makeChoice(number: Int(textfield) ?? 0)
                print(textfield)
            }, label: {
                Text("Guess")
            })
        }
        .onAppear {
            guard var safeModel = viewModel.guessNumberModel else {return}
            if safeModel.isPlayerOneTurn {
//                    out = viewModel.computerPlayerModel.guessNumber { number in
//                        viewModel.makeChoice(number: number)
                let a = Timer.scheduledTimer(withTimeInterval: 1, repeats: true ) { Timer in

                        viewModel.computerPlayerModel.guessNumber { number in
                            previousInput = "\(number)"
                            print("\(number)")
                            var out = safeModel.checkEnteredNumber(enteredNumber: number)
                            if out == .equal {
                                currentView = .result
                            }
                            return out
                    }
                    }
            }
        }
    }
}

struct PlayerGuessNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGuessNumberView(currentView: .constant(.playerEnterNumberView), viewModel: ViewModel())
    }
}

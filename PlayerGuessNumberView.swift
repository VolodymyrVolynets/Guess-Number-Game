//
//  PlayerGuessNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct PlayerGuessNumberView: View {
    
    @Binding var currentView: CurrentView
    @Binding var viewModel: ViewModel?
    @State var enteredNumber: Int = 10
    var safeViewModel: ViewModel {
        guard let safeViewModel = viewModel else { return ViewModel(playerOneEnteredNumber: 0) }
        return safeViewModel
    }
    var fails: Int {
        safeViewModel.isPlayerOneTurn ? safeViewModel.playerOneFails : safeViewModel.playerTwoFails
    }
    
    var body: some View {
        VStack {
            Text("PlayerGuessNumberView")
            Text("\(fails) fails")
            TextField("Number", value: $enteredNumber, formatter: NumberFormatter())
            
            Button(action: {
                if viewModel?.makeChoice(number: enteredNumber) == .equal {
                    currentView = .result
                }
            }, label: {
                Text("Guess")
            })
        }
    }
}

struct PlayerGuessNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGuessNumberView(currentView: .constant(.playerEnterNumberView), viewModel: .constant(ViewModel(playerOneEnteredNumber: 10)))
    }
}

//
//  GuessNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct GuessNumberView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var number: Int = 0
    var currentPlayer: String {
        viewModel.isPlayerOneTurn ? "Player One" : "Player TWO"
    }
    var currentFails: Int {
        viewModel.isPlayerOneTurn ? viewModel.playerOneFails : viewModel.playerTwoFails
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text(currentPlayer)
            
            Text("\(currentFails)")
            
            TextField("Enter Number", value: $number, formatter: NumberFormatter())
                .keyboardType(.numberPad)
            
            Button(action: {
                viewModel.makeChoice(number: number)
            }, label: {
                Text("Button")
            })
        }
    }
}

struct GuessNumberView_Previews: PreviewProvider {
    static var previews: some View {
        GuessNumberView(viewModel: ViewModel(playerOneEnteredNumber: 10))
    }
}

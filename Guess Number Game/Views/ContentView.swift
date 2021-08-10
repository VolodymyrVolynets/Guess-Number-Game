//
//  ContentView.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = ViewModel(range: -100..<100)

    var body: some View {

        switch viewModel.currentView {
        case .startView:
            StartView(viewModel: viewModel)
                .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .move(edge: .top)))
        case .playerEnterNumberView:
            PlayerEnterNumberView(viewModel: viewModel)
        case .playerGuessNumberView:
            PlayerGuessNumberView(viewModel: viewModel)
        case .result:
            VStack {
                Text("Player one fails: \(viewModel.playerOneFails)")
                Text("Player two fails: \(viewModel.playerTwoFails)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

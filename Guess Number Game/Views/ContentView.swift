//
//  ContentView.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel(range: 0...100)
    var currentView: ViewModel.CurrentView { viewModel.currentView
    }
    
    var body: some View {
        Group {
            switch currentView {
            case .startView:
                StartView()
            case .playerEnterNumberView:
                PlayerEnterNumberView()
            case .playerGuessNumberView:
                PlayerGuessNumberView()
            case .computerGuessNumberView:
                ComputerGuessNumberView()
            case .result:
                ResultView()
            }
        }
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "en"))
    }
}

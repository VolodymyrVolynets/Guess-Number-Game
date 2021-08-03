//
//  ContentView.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentView: CurrentView = .startView
    @State var viewModel: ViewModel?

    var body: some View {

        switch currentView {
        case .startView:
            StartView(currentView: $currentView)
        case .playerEnterNumberView:
            PlayerEnterNumberView(currentView: $currentView, viewModel: $viewModel)
        case .playerGuessNumberView:
            PlayerGuessNumberView(currentView: $currentView, viewModel: $viewModel)
        case .result:
            Text("Win")
        }
    }
}

enum CurrentView {
    case startView
    case playerEnterNumberView
    case playerGuessNumberView
    case result
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: nil)
    }
}

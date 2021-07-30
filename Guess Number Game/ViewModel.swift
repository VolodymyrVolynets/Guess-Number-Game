//
//  GuessNumberViewModel.swift
//  Guess Number Game
//
//  Created by Vova on 30.07.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var guessNumberModel: GuessNumberModel
    
    init() {
        guessNumberModel = GuessNumberModel()
    }
}

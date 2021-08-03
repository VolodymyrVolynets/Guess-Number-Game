//
//  PlayerEnterNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct PlayerEnterNumberView: View {
    
    @Binding var currentView: CurrentView
    @Binding var viewModel: ViewModel?
    @State var enteredNumber: Int = 0
    
    var body: some View {
        VStack {
            Text("PlayerEnterNumberView")
            TextField("Number", value: $enteredNumber, formatter: NumberFormatter())
            
            Button(action: {
                viewModel = ViewModel(playerOneEnteredNumber: enteredNumber)
                currentView = .playerGuessNumberView
            }, label: {
                Text("Next")
            })
        }
    }
}

struct PlayerEnterNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerEnterNumberView(currentView: .constant(.playerEnterNumberView), viewModel: .constant(ViewModel(playerOneEnteredNumber: 10)))
    }
}

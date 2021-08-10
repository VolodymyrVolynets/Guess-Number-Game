//
//  PlayerEnterNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct PlayerEnterNumberView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var textField = ""
    var range: Range<Int> {
        viewModel.range
    }
    var enteredNumber: Int {
        Int(textField) ?? 0
    }
    
    var body: some View {
        VStack {
            Text("PlayerEnterNumberView")
            TextField("Number", text: $textField.didSet({ (newValue: String, oldValue: String) in
                if !(newValue.isEmptyOrNumeric && range.contains(Int(newValue) ?? 0)) {
                    textField = oldValue
                }
            }))
            .keyboardType(.numberPad)
            
            Button(action: {
                guard !textField.isEmpty else { return }
                viewModel.startNewGame(playerOneEnteredNumber: enteredNumber)
                viewModel.currentView = .playerGuessNumberView
            }, label: {
                Text("Next")
            })
        }.onTapGesture {
            endEditing()
        }
    }
}

struct PlayerEnterNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerEnterNumberView(viewModel: ViewModel(range: -100..<100))
    }
}

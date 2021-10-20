//
//  PlayerEnterNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//
//

import SwiftUI

struct PlayerEnterNumberView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var textField = ""
    
    var range: ClosedRange<Int> {
        viewModel.range
    }
    
    var screenSize: CGRect {
        UIScreen.main.bounds
    }
    
    var isValidNumber: Bool {
        viewModel.isValidIntString(string: textField)
    }
    
    var body: some View {
        VStack {
            Text("Please enter your hidden number")
                .font(.system(size: 40, weight: .bold))
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
            
            Text("Enter number between \(range.min()!) and \(range.max()!)")
                .font(.system(size: 20, weight: .light))
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
            
            TextField("Enter Number", text: $textField)
                .font(.system(size: CGFloat(screenSize.width / 10), weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .onChange(of: textField) { _ in textField = viewModel.validateString(string: textField) }
            
            Spacer()
            
            Button {
                viewModel.startGame(playerOneEnteredNumber: Int(textField)!)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 170, height: 57)
                        .foregroundColor(isValidNumber ? .accentColor : .gray)
                    Text("Enter")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold))
                }
                .padding(.vertical, 10)
            }
            .disabled(!isValidNumber)

            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            endEditing()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}

struct PlayerEnterNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerEnterNumberView()
            .environmentObject(ViewModel(range: 0...100))
    }
}


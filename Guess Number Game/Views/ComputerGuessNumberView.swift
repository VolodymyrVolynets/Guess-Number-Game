//
//  ComputerGuessNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 02.10.2021.
//

import SwiftUI

struct ComputerGuessNumberView: View {
    
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
    
    @State var wasPressed = false
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Computer guess hidden number")
                    .font(.system(size: 40, weight: .bold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                
                Text("\(textField)")
                    .font(.system(size: CGFloat(screenSize.width / 3), weight: .bold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                    .onChange(of: textField) { _ in textField = viewModel.validateString(string: textField) }
                
                Spacer()
                
                if !wasPressed {
                    Button {
                        viewModel.startComputerTurn { num in
                            textField = "\(num)"
                        }
                        wasPressed = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 170, height: 57)
                                .foregroundColor(.accentColor)
                            Text("Start")
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .bold))
                        }
                        .padding(.vertical, 10)
                    }
                }
                
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                endEditing()
            }
            if viewModel.alert.isShow { showAlert() }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
    
    func showAlert() -> some View{
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 400, height: 170)
                    .foregroundColor(viewModel.alert.info == .equal ? .green : .red)
                let text = viewModel.alert.info == .equal ? "Correct" : "Wrong number, hidden number is \(viewModel.alert.info == .less ? "less" : "greater")"
                Text("\(text)")
                    .font(.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(.black)
                    .padding()
            }
            
            Spacer()
        }
    }
}

struct ComputerGuessNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ComputerGuessNumberView()
    }
}

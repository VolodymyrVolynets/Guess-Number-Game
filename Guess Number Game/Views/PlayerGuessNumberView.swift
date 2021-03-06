//
//  PlayerGuessNumberView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct PlayerGuessNumberView: View {
    
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
        ZStack {
            VStack {
                Text("Please guess hidden number")
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
                    viewModel.makeChoice(number: Int(textField)!)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 170, height: 57)
                            .foregroundColor(isValidNumber ? .accentColor : .gray)
                        Text("Guess")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold))
                    }
                    .padding(.vertical, 10)
                }
                .disabled(!isValidNumber || viewModel.alert.isShow)
                
                
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

struct PlayerGuessNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerGuessNumberView()
            .environmentObject(ViewModel(range: 0...100))
    }
}

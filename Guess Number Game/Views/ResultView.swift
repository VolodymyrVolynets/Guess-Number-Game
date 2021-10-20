//
//  SwiftUIView.swift
//  Guess Number Game
//
//  Created by Vova on 03.10.2021.
//

import SwiftUI
import ConfettiSwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isshowCannon: Bool = false
    @State var trigger: Int = 0
    
    var body: some View {
        ZStack {
            
            CustomConfettiView(trigger: $trigger)
                .opacity(isshowCannon ? 1 : 0)
                .onAppear {
                    viewModel.showConfettiCannon(trigget: $trigger, isShowingCannon: $isshowCannon)
                }
            
            VStack(spacing: 40) {
                Text("Result")
                    .font(.system(size: 40, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                HStack(alignment: .center,spacing: 20) {
                    Spacer()
                    VStack {
                        Text("You")
                            .font(.system(size: 25, weight: .bold))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        Text("\(viewModel.playerOneFails)")
                            .font(.system(size: 40, weight: .bold))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                    }
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3)
                    
                    
                    VStack {
                        Text("Computer")
                            .font(.system(size: 25, weight: .bold))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        Text("\(viewModel.playerTwoFails)")
                            .font(.system(size: 40, weight: .bold))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                    }
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3)
                    Spacer()
                }
                Text(viewModel.isPlayerOneWin ? "You win" : "You lose")
                    .font(.system(size: 40, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                
                Button {
                    viewModel.restartGame()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 170, height: 57)
                            .foregroundColor(.accentColor)
                        Text("Restart")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold))
                    }
                    .padding(.vertical, 10)
                }
            }
        }
    }
}

struct CustomConfettiView: View {
    
    @Binding var trigger: Int
    var radius = (UIScreen.main.bounds.width / 2)
    
    var body: some View {
        HStack {
            ZStack {
                Text("🎉").font(.system(size: 50))
                ConfettiCannon(counter: $trigger, num: 100, openingAngle: Angle.degrees(30), closingAngle: Angle.degrees(90), radius: radius)
            }
            
            Spacer()
            
            ZStack {
                Text("🎉").font(.system(size: 50))
                .rotation3DEffect(Angle.degrees(180), axis: (x: 0, y: 1, z: 0))
                ConfettiCannon(counter: $trigger, num: 100, openingAngle: Angle.degrees(90), closingAngle: Angle.degrees(150), radius: radius)
            }
        }
        .padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
            .environmentObject(ViewModel(range: 0...100))
    }
}

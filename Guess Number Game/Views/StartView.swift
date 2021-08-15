//
//  StartView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct StartView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var scaleEffect: CGFloat = 1
    var screenSize = UIScreen.main.bounds.size

    var body: some View {
        ZStack {
            VStack {
                Text("Press To Start New Game")

                    .font(.system(size: 40, weight: .bold, design: .default))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .padding(40)
                    .scaleEffect(scaleEffect)
                    .foregroundColor(Color("fontColor"))
            }
        }
        .frame(width: screenSize.width, height: screenSize.height)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                scaleEffect = 0.8
            }
        }
        .onTapGesture {
            withAnimation() {
                viewModel.currentView = .playerEnterNumberView
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: ViewModel(range: -100...100))
    }
}

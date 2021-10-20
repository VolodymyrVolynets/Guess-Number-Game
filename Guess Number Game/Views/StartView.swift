//
//  StartView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var scaleEffect: CGFloat = 1
    var screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            // Spacers are used to extend the whole VStack
            Spacer()
            
            Text("Press To Start New Game")
                .font(UIConstants.fontStyle)
                .lineLimit(2)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .padding(40)
                .scaleEffect(scaleEffect)
                .foregroundColor(Color.black)
                .shadow(color: .black, radius: 10, x: 0, y: 5)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        // to make whole VStack tappable
        .contentShape(Rectangle())
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                scaleEffect = 0.8
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .onTapGesture {
            // On Tap switch View
            withAnimation() {
                viewModel.currentView = .playerEnterNumberView
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(ViewModel(range: 0...100))
    }
}

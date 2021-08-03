//
//  StartView.swift
//  Guess Number Game
//
//  Created by Vova on 31.07.2021.
//

import SwiftUI

struct StartView: View {
    
    @Binding var currentView: CurrentView
    
    var body: some View {
        VStack {
            Text("Start New Game")
            
            Button(action: {
                currentView = .playerEnterNumberView
            }, label: {
                Text("Start")
            })
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(currentView: .constant(.startView))
    }
}

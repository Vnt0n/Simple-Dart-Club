//
//  GameView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        ZStack {
            Color.blue.frame(maxWidth: .infinity)
            VStack {
                
                Spacer()
                
                Text("Player 1")
                Text("501")
                    .font(.system(size: 140, weight: .bold, design: .default))
                
                Spacer()
                
                Text("Player 2")
                Text("501")
                    .font(.system(size: 140, weight: .bold, design: .default))
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GameView()
}

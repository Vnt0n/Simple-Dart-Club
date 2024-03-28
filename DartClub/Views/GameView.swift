//
//  GameView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct GameView: View {
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Text(namePlayer1)
                    Text("501")
                        .font(.system(size: 140, weight: .bold, design: .default))
                }
                .foregroundColor(.black)
            }
            
            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    Text(namePlayer2)
                    Text("501")
                        .font(.system(size: 140, weight: .bold, design: .default))
                }
                .foregroundColor(.black)
            }

            if !namePlayer3.isEmpty {
                ZStack {
                    Color.gray
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        Text(namePlayer3)
                        Text("501")
                            .font(.system(size: 140, weight: .bold, design: .default))
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "player3")
    }
}

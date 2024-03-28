//
//  GameView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct GameView: View {
    
    var name1: String
    var name2: String
    var name3: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Premier tier de l'écran (Joueur 1)
            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Text(name1)
                    Text("501")
                        .font(.system(size: 140, weight: .bold, design: .default))
                }
                .foregroundColor(.black)
            }
            
            // Deuxième tier de l'écran (Joueur 2)
            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    Text(name2)
                    Text("501")
                        .font(.system(size: 140, weight: .bold, design: .default))
                }
                .foregroundColor(.black)
            }
            // Troisième tier de l'écran (Joueur 3)
            if !name3.isEmpty {
                ZStack {
                    Color.gray
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        Text("Player 3")
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
        GameView(name1: "Player 1", name2: "Player 2", name3: "player3")
    }
}

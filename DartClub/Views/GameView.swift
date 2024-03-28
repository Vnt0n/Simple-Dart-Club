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
    
    var scorePlayer1: Int = 501
    var scorePlayer2: Int = 501
    var scorePlayer3: Int = 501

    
    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Text(namePlayer1)
                    Button(action: {
                        enterScoreForPlayer(player: 1)
                    }) {
                        Text("\(scorePlayer1)")
                            .font(.system(size: 140, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                }
            }
            
            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    Text(namePlayer2)
                    Button(action: {
                        enterScoreForPlayer(player: 2)
                    }) {
                        Text("\(scorePlayer1)")
                            .font(.system(size: 140, weight: .bold, design: .default))
                            .foregroundColor(.black)
                    }
                }
            }

            if !namePlayer3.isEmpty {
                ZStack {
                    Color.gray
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        Text(namePlayer3)
                        Button(action: {
                            enterScoreForPlayer(player: 3)
                        }) {
                            Text("\(scorePlayer1)")
                                .font(.system(size: 140, weight: .bold, design: .default))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
    
    func enterScoreForPlayer(player: Int) {
        
        print("NEW SCORE")
        // Logique pour permettre au joueur de saisir son score
        // Par exemple, vous pouvez présenter un clavier numérique
        // et mettre à jour le score du joueur en conséquence.
        // Ici, je laisse la logique de mise à jour du score à votre implémentation.
        
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "player3")
    }
}

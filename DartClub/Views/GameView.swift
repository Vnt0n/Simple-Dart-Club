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
    
    @State private var scorePlayer1: Int = 501
    @State private var scorePlayer2: Int = 501
    @State private var scorePlayer3: Int = 501

    
    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                Color.gray
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Text(namePlayer1)
                    Button(action: {
                        self.enterScoreForPlayer(player: 1)
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
                        self.enterScoreForPlayer(player: 2)
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
                            self.enterScoreForPlayer(player: 3)
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
        
        let enteredNumber: Int = 5
        
        switch player {
            case 1:
                scorePlayer1 -= enteredNumber
            case 2:
                scorePlayer2 -= enteredNumber
            case 3:
                scorePlayer3 -= enteredNumber
            default:
                break
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "player3")
    }
}

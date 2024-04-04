//
//  InformationsView.swift
//  DartClub
//
//  Created by Antoine on 03/04/2024.
//

import SwiftUI

struct InformationsView: View {
    
    @Binding var scoreHistories: [GameView.ScoreHistory]
    @Binding var player1Scores: [Int]
    @Binding var player2Scores: [Int]
    @Binding var player3Scores: [Int]
    
    var scorePlayer1: Int
    var scorePlayer2: Int
    var scorePlayer3: Int
    
    var body: some View {
        VStack {
            Text("Score Histories:")
                .font(.title)
                .padding()

            ScrollView {
                VStack {
                    ForEach(scoreHistories, id: \.self) { history in
                        VStack {
                            Text("Game \(scoreHistories.firstIndex(of: history)! + 1):")
                                .font(.headline)
                            
                            Text("Player 1: \(history.player1)")
                            Text("Player 2: \(history.player2)")
                            Text("Player 3: \(history.player3)")
                        }
                        .padding()
                    }
                }
                VStack {
                                Text("Player 1: \(scorePlayer1)")
                                Text("Player 2: \(scorePlayer2)")
                                Text("Player 3: \(scorePlayer3)")
                            }
                            .padding()
                VStack {
                                    Text("Player 1: \(player1Scores)")
                                    Text("Player 2: \(player2Scores)")
                                    Text("Player 3: \(player3Scores)")
                                }
                                .padding()
            }
        }
    }
}


struct InformationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let scoreHistories: [GameView.ScoreHistory] = [
            GameView.ScoreHistory(player1: [100, 200, 300], player2: [150, 250, 350], player3: [180, 220, 320]),
            GameView.ScoreHistory(player1: [120, 220, 320], player2: [130, 230, 330], player3: [160, 240, 340])
        ]
        
        return InformationsView(scoreHistories: .constant(scoreHistories),
                                player1Scores: .constant([500, 450, 400]),
                                player2Scores: .constant([510, 460, 410]),
                                player3Scores: .constant([520, 470, 420]),
                                scorePlayer1: 490,
                                scorePlayer2: 480,
                                scorePlayer3: 470)
    }
}

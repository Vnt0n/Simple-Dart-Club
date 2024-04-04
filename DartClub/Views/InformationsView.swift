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
            
            Text("Score Histories")
                .font(.title)
                .padding()
            
            ScrollView {
            
                VStack {
                    Text("Actual Score")
                        .font(.headline)
                    Text("Player 1: \(player1Scores)")
                    Text("Player 2: \(player2Scores)")
                    Text("Player 3: \(player3Scores)")
                    Text("SCORE CHOISI - \(player1Scores[2])")

                }
                .padding()
            
                VStack {
                    ForEach(scoreHistories, id: \.self) { history in
                        VStack {
                            Text("GAME \(scoreHistories.firstIndex(of: history)! + 1)")
                                .font(.headline)
                            
                            Text("Player 1: \(history.player1)")
                            Text("Player 2: \(history.player2)")
                            Text("Player 3: \(history.player3)")
                            Text("SCORE CHOISI - \(history.player1[2])")
                        }
                        .padding()
                    }
                }
                
                VStack {
                    Text("Actual Score")
                        .font(.headline)
                    Text("Player 1: \(scorePlayer1)")
                    Text("Player 2: \(scorePlayer2)")
                    Text("Player 3: \(scorePlayer3)")
                }
                .padding()

            }
        }
    }
}


struct InformationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let scoreHistories: [GameView.ScoreHistory] = [
            GameView.ScoreHistory(player1: [5, 57, 25, 65, 89, 45, 78], player2: [45, 36, 75, 29, 27, 65, 25], player3: [14, 28, 35, 45, 20, 18, 43]),
            GameView.ScoreHistory(player1: [120, 220, 320], player2: [130, 230, 330], player3: [160, 240, 340])
        ]
        
        return InformationsView(scoreHistories: .constant(scoreHistories),
                                player1Scores: .constant([10, 55, 35]),
                                player2Scores: .constant([25, 41, 17]),
                                player3Scores: .constant([54, 22, 14]),
                                scorePlayer1: 490,
                                scorePlayer2: 480,
                                scorePlayer3: 470)
    }
}

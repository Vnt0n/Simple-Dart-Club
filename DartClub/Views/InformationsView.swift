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

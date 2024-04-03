//
//  InformationsView.swift
//  DartClub
//
//  Created by Antoine on 03/04/2024.
//

import SwiftUI

struct InformationsView: View {
    var scoreHistory: GameView.ScoreHistory
    
    var body: some View {
        VStack {
            Text("Score History:")
                .font(.headline)
                .padding()
            
            // Display score history for each player
            if !scoreHistory.player1.isEmpty {
                Text("Player 1: \(scoreHistory.player1)")
            }
            
            if !scoreHistory.player2.isEmpty {
                Text("Player 2: \(scoreHistory.player2)")
            }
            
            if !scoreHistory.player3.isEmpty {
                Text("Player 3: \(scoreHistory.player3)")
            }
            
            Spacer()
        }
    }
}


import SwiftUI

struct InformationsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleScoreHistory = GameView.ScoreHistory(player1: [450, 400, 350], player2: [480, 430, 380], player3: [470, 420, 370])
        
        return InformationsView(scoreHistory: sampleScoreHistory)
    }
}

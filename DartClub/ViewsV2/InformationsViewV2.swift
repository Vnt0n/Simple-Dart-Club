//
//  InformationsViewV2.swift
//  DartClub
//
//  Created by Antoine on 26/04/2024.
//

import SwiftUI

struct InformationsViewV2: View {
    @ObservedObject var viewModel: GameViewModel  // Liaison avec le modèle de données du jeu

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.currentGame.players.indices, id: \.self) { playerIndex in
                        let player = viewModel.currentGame.players[playerIndex]
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(player.name)")
                                .font(.title2)
                                .fontWeight(.bold)

                            ForEach(player.scores.indices, id: \.self) { turnIndex in
                                let turnScores = player.scores[turnIndex]
                                let turnSum = turnScores.reduce(0, +)
                                let remainingScore = 501 - turnSum
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Turn \(turnIndex + 1):")
                                            .fontWeight(.semibold)
                                        Text("Throws: \(turnScores.map(String.init).joined(separator: ", "))")
                                        Text("Sum: \(turnSum)")
                                        Text("Remaining from 501: \(remainingScore)")
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                }
                            }
                            if player.scores.isEmpty {
                                Text("No scores recorded yet")
                                    .italic()
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onAppear {
                            print("Displaying scores for \(player.name): \(player.scores)")
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Game Information", displayMode: .inline)
        }
    }
}

// Preview Provider
struct InformationsViewV2_Previews: PreviewProvider {
    static var previews: some View {
        let model = GameViewModel(gameType: 501, playerCount: 4)
        model.currentGame.players[0].name = "Alice"
        model.currentGame.players[0].scores = [[60, 20, 25], [50, 10, 10]]
        model.currentGame.players[1].name = "Bob"
        model.currentGame.players[1].scores = [[40, 15, 10], [60, 10, 5]]
        model.currentGame.players[2].name = "Charlie"
        model.currentGame.players[2].scores = [[20, 30, 40], [10, 5, 5]]
        model.currentGame.players[3].name = "Diana"
        model.currentGame.players[3].scores = [[25, 25, 25], [30, 10, 5]]
        
        return InformationsViewV2(viewModel: model)
    }
}


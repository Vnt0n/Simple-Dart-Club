//
//  InformationsViewV2.swift
//  DartClub
//
//  Created by Antoine on 26/04/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct InformationsViewV2: View {
    
    @ObservedObject var viewModel: GameViewModel
    @State private var counter = 0
    @State private var isGameStarted = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                
                if let winningPlayer = viewModel.currentGame.players.first(where: { $0.remainingScore == 0 }) {

                    VStack {
                        
                        Text("🥇")
                            .padding([.bottom], 10)
                            .padding([.top], 50)
                            .font(.system(size: 130))
                        
                        Text("\(winningPlayer.name)")
                            .padding([.bottom], 10)
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(.black)
                        
                        Text("You won!")
                            .font(.system(size: 50, weight: .bold, design: .default))
                            .foregroundColor(.blue)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    self.counter = 1
                                    
                                    print("--------------------------------------------")
                                    print("Winner Name: \(winningPlayer.name)")
                                    
                                }
                            }
                    }
                    
                    Button("New game") {
                        viewModel.resetForNextGame()
                        isGameStarted = true
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.bottom, 25)
                    .confettiCannon(counter: $counter, num: 150, radius: 500.0)
                }
                
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
                                let totalRemainingScore = player.remainingScoresPerTurn[turnIndex]

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Turn \(turnIndex + 1):")
                                            .fontWeight(.semibold)
                                        Text("Throws: \(turnScores.map(String.init).joined(separator: ", "))")
                                        Text("Sum: \(turnSum)")
                                        Text("Remaining Score Turn \(turnIndex + 1): \(totalRemainingScore)")
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
                            print("Remaining scores for \(player.name): \(player.remainingScore)")
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Game Information", displayMode: .inline)
        }
    }
}


struct InformationsViewV2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview avec 1 joueur
            InformationsViewV2(viewModel: viewModelWithPlayers(count: 1))
                .previewDisplayName("1 Player")
                .previewLayout(.sizeThatFits)

            // Preview avec 2 joueurs
            InformationsViewV2(viewModel: viewModelWithPlayers(count: 2))
                .previewDisplayName("2 Players")
                .previewLayout(.sizeThatFits)

            // Preview avec 3 joueurs
            InformationsViewV2(viewModel: viewModelWithPlayers(count: 3))
                .previewDisplayName("3 Players")
                .previewLayout(.sizeThatFits)

            // Preview avec 4 joueurs
            InformationsViewV2(viewModel: viewModelWithPlayers(count: 4))
                .previewDisplayName("4 Players")
                .previewLayout(.sizeThatFits)
        }
    }

    // Helper function to create a GameViewModel with a given number of players
    static func viewModelWithPlayers(count: Int) -> GameViewModel {
        let model = GameViewModel(gameType: 501)
        for _ in 0..<count {
            model.addPlayer()
        }
        let names = ["Alice", "Bob", "Charlie", "Diana"]
        let scores = [
            [[60, 20, 25], [50, 10, 10]],
            [[40, 15, 10], [60, 10, 5]],
            [[20, 30, 40], [10, 5, 5]],
            [[25, 25, 25], [30, 10, 5]]
        ]

        for i in 0..<count {
            model.currentGame.players[i].name = names[i]
            model.currentGame.players[i].scores = scores[i]
            let _ = scores[i].flatMap { $0 }.reduce(0, +)
            let remainingScoresPerTurn = scores[i].map { model.currentGame.gameType - $0.reduce(0, +) }
            model.currentGame.players[i].remainingScoresPerTurn = remainingScoresPerTurn
        }
        return model
    }
}

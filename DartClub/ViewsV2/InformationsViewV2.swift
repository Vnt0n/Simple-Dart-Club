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
    @State private var isDismissForbidden = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {

//  ///////////////////////////////////////////////////////////////////////////////
//  //////////////////////// WINNING VIEW ////////////////////////////////

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
                                }
                                isDismissForbidden = true
                            }
                    }
                    .confettiCannon(counter: $counter, num: 150, radius: 500.0)
                    
                    Button("New game") {
                        viewModel.endGame()
                        isGameStarted = true
                        isDismissForbidden = false
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.bottom, 25)
                }
                
//  ///////////////////////////////////////////////////////////////////////////////
//  ///////////////////////////////////////////////////////////////////////////////

                
                Divider()
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Text("CURRENT GAME")
                        .fontWeight(.bold)
                    
                    ForEach(viewModel.currentGame.players.indices, id: \.self) { playerIndex in
                        let player = viewModel.currentGame.players[playerIndex]
                        
                        VStack(alignment: .center, spacing: 10) {
                            
                            Text("\(player.name)")
                                .font(.title2)
                                .fontWeight(.bold)

                            ForEach(player.scores.indices, id: \.self) { turnIndex in
                                let turnScores = player.scores[turnIndex]
                                let turnSum = turnScores.reduce(0, +)
                                let totalRemainingScore = player.remainingScoresPerTurn[turnIndex]
                                  
                                    VStack(alignment: .center) {
                                        
                                        Text("Turn \(turnIndex + 1)")
                                            .fontWeight(.semibold)
                                        Text("Throws - \(turnScores.map(String.init).joined(separator: " | ")) = \(turnSum)")
                                        Text("Remaining Score - \(totalRemainingScore)")
                                        
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    
                            }
                            
//                            if player.scores.isEmpty {
//                                Text("No scores recorded yet")
//                                    .italic()
//                            }
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
                
                VStack(alignment: .center, spacing: 10) {
                    
                    Text("HISTORY")
                        .fontWeight(.bold)
                    
                    ForEach(viewModel.gameHistory, id: \.gameNumber) { record in
                        
                        VStack(alignment: .center) {
                            
                            Text("Game \(record.gameNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            VStack(alignment: .center) {
                                
                                ForEach(record.finalScores, id: \.name) { player in
                                    
                                    Text("\(player.name)")
                                        .fontWeight(.bold)
                                    
                                    ForEach(player.scores.indices, id: \.self) { index in
                                        let turn = player.scores[index]
                                                                                    
                                            Text("Throws Turn \(index + 1)")
                                                .fontWeight(.bold)
                                            Text("\(turn.map(String.init).joined(separator: " | "))")
                                        
                                    }
                                    
                                }
                            }
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .padding()
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5)
//                        frame(width: 200)
                    }
                }
                .padding()
            }
            .navigationBarTitle("ScoreBoard", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .interactiveDismissDisabled(isDismissForbidden)
            .frame(maxWidth: .infinity)
        }
    }
}


// ///////////////////////////
// PREVIEW //////////////////

struct InformationsViewV2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview avec 1 joueur
            InformationsViewV2(viewModel: viewModelWithPlayersAndHistory(count: 1))
                .previewDisplayName("1 Player")
                .previewLayout(.sizeThatFits)

            // Preview avec 2 joueurs
            InformationsViewV2(viewModel: viewModelWithPlayersAndHistory(count: 2))
                .previewDisplayName("2 Players")
                .previewLayout(.sizeThatFits)

            // Preview avec 3 joueurs
            InformationsViewV2(viewModel: viewModelWithPlayersAndHistory(count: 3))
                .previewDisplayName("3 Players")
                .previewLayout(.sizeThatFits)

            // Preview avec 4 joueurs
            InformationsViewV2(viewModel: viewModelWithPlayersAndHistory(count: 4))
                .previewDisplayName("4 Players")
                .previewLayout(.sizeThatFits)
        }
    }

    // Fonction aidante pour créer un GameViewModel avec un nombre donné de joueurs et un historique de parties
    static func viewModelWithPlayersAndHistory(count: Int) -> GameViewModel {
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

        // Ajout des scores et des configurations initiales des joueurs
        for i in 0..<count {
            model.currentGame.players[i].name = names[i]
            model.currentGame.players[i].scores = scores[i]
            let _ = scores[i].flatMap { $0 }.reduce(0, +)
            let remainingScoresPerTurn = scores[i].map { model.currentGame.gameType - $0.reduce(0, +) }
            model.currentGame.players[i].remainingScoresPerTurn = remainingScoresPerTurn
        }

        // Simulation des historiques de jeux
        let historyScores = [[[30, 30, 30], [20, 20, 20]], [[60, 20, 15], [40, 30, 20]], [[45, 10, 20], [40, 10, 10]]]
        for gameNumber in 1...3 {
            var players = [Player]()
            for i in 0..<min(count, 3) {
                let player = Player(name: names[i], scores: historyScores[i], remainingScore: 501 - historyScores[i].flatMap { $0 }.reduce(0, +))
                players.append(player)
            }
            let gameRecord = GameRecord(gameNumber: gameNumber, finalScores: players)
            model.gameHistory.append(gameRecord)
        }

        return model
    }
}


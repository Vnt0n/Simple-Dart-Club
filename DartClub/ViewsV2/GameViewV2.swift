//
//  GameViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct GameViewV2: View {
    
    var selectedGame: Int?
    var players: [Player]
    
    @State private var currentPlayerIndex: Int = 0
    @State private var enterThrowScore: Bool = false
    @State private var showInformationsView = false

    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {

                ZStack {

                    Color(.blue)

                    HStack {

                        Spacer()

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON InformationsViewV2")
                            showInformationsView = true
                        }) {
                            Image(systemName: "info.circle")
                                .accessibilityLabel("Undo")
                                .font(.system(size: 25))
                        }
                        .sheet(isPresented: $showInformationsView) {
                            InformationsViewV2(viewModel: viewModel)
                        }
                        
// /////////////////////// DEBUG BUTTON //////////////////////////////////////////////////

//                        Button(action: {
//                            
//                            print("--------------------------------------------")
//                            print("DEBUG")
//                            print("--------------------------------------------")
//                            print("GAMETYPE : \(viewModel.currentGame.gameType)")
//                            print("NOMBRE DE JOUEURS : \(viewModel.currentGame.players.count)")
//                            print("NAME PLAYER 1 : \(viewModel.currentGame.players[0].name)")
//                            print("REMAINGSCORE PLAYER 1 : \(viewModel.remainingScore(forPlayer: 0))")
//                            print("NAME PLAYER 2 : \(viewModel.currentGame.players[1].name)")
//                            print("REMAINGSCORE PLAYER 2 : \(viewModel.remainingScore(forPlayer: 1))")
//                            print("NAME PLAYER 3 : \(viewModel.currentGame.players[2].name)")
//                            print("REMAINGSCORE PLAYER 3 : \(viewModel.remainingScore(forPlayer: 2))")
//                            print("NAME PLAYER 4 : \(viewModel.currentGame.players[3].name)")
//                            print("REMAINGSCORE PLAYER 4 : \(viewModel.remainingScore(forPlayer: 3))")
//                            print("CURRENT TURN : \(viewModel.currentGame.currentTurn)")
//                            print("CURRENT PLAYER : \(players[currentPlayerIndex].name)")
//                           
//                            print("GAMETYPE : \(viewModel.currentGame.gameType)")
//
//                        }) {
//                            Image(systemName: "ladybug.circle")
//                                .accessibilityLabel("Undo")
//                                .font(.system(size: 25))
//                        }
                        
// //////////////////////////////////////////////////////////////////////////////////////
                        
                        Spacer()

                        Text("\(players[currentPlayerIndex].name)")
                            .fontWeight(.bold)

                        Spacer()

                        Text("Game \(viewModel.gameCount)")
                        Text("- Turn \(viewModel.currentGame.currentTurn)")
                            .bold()

                        Spacer()

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON undoLastScore")
                        undoLastScore()
                        }) {
                            Image(systemName: "arrow.uturn.backward.circle")
                                .accessibilityLabel("Undo")
                                .font(.system(size: 25))
                        }
//                    .disabled(isUndoDisabled)
//                    .foregroundColor(isUndoDisabled ? .gray : .white)

                        Spacer()

                    }
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .frame(height: 55)

                ZStack {

                    Color(currentPlayerIndex == 0 ? .yellow : .gray)
                    
                    VStack {

                        Spacer()

                        HStack {
                            Text("\(players[0].name)")
                                .fontWeight(.bold)
                            Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 0))")
                                .font(
                                    .system(size: 14))
//                         if isBustedPlayer1 {
//                             Text("- BUST")
//                                 .fontWeight(.bold)
//                                 .foregroundColor(.red)
//                                 .glowBorder(color: .black, lineWidth: 2)
//                         }
                        }

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON enterThrowScore PLAYER 1")
                            enterThrowScore = true
//                         isUndoDisabled = false
                        }) {
                            Text("\(viewModel.remainingScore(forPlayer: 0))")
                                .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                        }
                        .disabled(currentPlayerIndex != 0)
                        
                        Spacer()
                        Divider()
                        
                    }
                }
                
                if players.count > 1 {

                    ZStack {
                        
                        Color(currentPlayerIndex == 1 ? .yellow : .gray)

                        VStack {

                            Spacer()

                            HStack {
                                Text("\(players[1].name)")
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 1))")
                                    .font(
                                        .system(size: 14))
//                         if isBustedPlayer1 {
//                             Text("- BUST")
//                                 .fontWeight(.bold)
//                                 .foregroundColor(.red)
//                                 .glowBorder(color: .black, lineWidth: 2)
//                         }
                            }

                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 2")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.remainingScore(forPlayer: 1))")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 1)
                            
                            Spacer()
                            Divider()

                        }
                    }
                }

                if players.count > 2 {

                    ZStack {

                        Color(currentPlayerIndex == 2 ? .yellow : .gray)

                        VStack {

                            Spacer()

                            HStack {
                                Text("\(players[2].name)")
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 2))")
                                    .font(
                                        .system(size: 14))
//                             if isBustedPlayer1 {
//                                 Text("- BUST")
//                                     .fontWeight(.bold)
//                                     .foregroundColor(.red)
//                                     .glowBorder(color: .black, lineWidth: 2)
//                             }
                            }

                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 3")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.remainingScore(forPlayer: 2))")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 2)
                            
                            Spacer()
                            Divider()

                        }
                    }
                }

                if players.count > 3 {

                    ZStack {

                        Color(currentPlayerIndex == 3 ? .yellow : .gray)

                        VStack {

                            Spacer()

                            HStack {
                                Text("\(players[3].name)")
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 3))")
                                    .font(
                                        .system(size: 14))
//                             if isBustedPlayer1 {
//                                 Text("- BUST")
//                                     .fontWeight(.bold)
//                                     .foregroundColor(.red)
//                                     .glowBorder(color: .black, lineWidth: 2)
//                             }
                            }

                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 4")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.remainingScore(forPlayer: 3))")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 3)
                            
                            Spacer()

                        }
                    }
                }
            }
            .foregroundColor(.black)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $enterThrowScore) {
                EnterThrowScoreViewV2(viewModel: viewModel, currentPlayerIndex: $currentPlayerIndex)
            }
            .onAppear {
                print("------------------------------")
                print("GAMEVIEW")
                print("------------------------------")
                viewModel.currentGame.players[0].remainingScore = viewModel.currentGame.gameType
                if players.count > 1 {
                    viewModel.currentGame.players[1].remainingScore = viewModel.currentGame.gameType
                    if players.count > 2 {
                        viewModel.currentGame.players[2].remainingScore = viewModel.currentGame.gameType
                        if players.count > 3 {
                            viewModel.currentGame.players[3].remainingScore = viewModel.currentGame.gameType
                        }
                    }
                }
            }
            .onChange(of: viewModel.remainingScore(forPlayer: 0)) {
                if viewModel.remainingScore(forPlayer: 0) == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showInformationsView = true
                    }
                }
            }
            .sheet(isPresented: $showInformationsView) {
                InformationsViewV2(viewModel: viewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    
    // FUNCTIONS ///////////////////
    
    private func undoLastScore() {
        print("----------------------------------------")
        print("Function undoLastScore in GameViewV2")

        // Calcul de l'index du joueur précédent
        var previousPlayerIndex = currentPlayerIndex - 1
        if previousPlayerIndex < 0 {
            previousPlayerIndex = viewModel.currentGame.players.count - 1
        }

        // Vérification si le joueur a des scores à annuler
        if let _ = viewModel.currentGame.players[previousPlayerIndex].scores.popLast() {
            // Mettre à jour les remainingScoresPerTurn si utilisé
            if !viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.isEmpty {
                viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.removeLast()
            }

            // Recalculer le score total et mettre à jour le remainingScore
            let totalScore = viewModel.currentGame.players[previousPlayerIndex].scores.flatMap { $0 }.reduce(0, +)
            viewModel.currentGame.players[previousPlayerIndex].remainingScore = viewModel.currentGame.gameType - totalScore

            // Ajuster l'index du joueur actuel
            currentPlayerIndex = previousPlayerIndex

            // Ajuster le tour, si nécessaire
            if viewModel.currentGame.currentTurn > 1 {
                viewModel.currentGame.currentTurn -= 1
            }
        } else {
            print("No scores to undo for player \(viewModel.currentGame.players[previousPlayerIndex].name).")
        }
    }

}


// ///////////////////////////
// PREVIEW //////////////////

// Define a preview provider for the GameViewV2
struct GameViewV2_Previews: PreviewProvider {

    // Helper function to create a GameViewModel with a specified number of players
    static func createViewModel(playerCount: Int) -> GameViewModel {
        let viewModel = GameViewModel(gameType: 501) // Assuming a game type of 501
        while viewModel.currentGame.players.count < playerCount {
            viewModel.addPlayer()
        }
        for i in 0..<viewModel.currentGame.players.count {
            viewModel.currentGame.players[i].name = "Player \(i + 1)"
            viewModel.currentGame.players[i].remainingScore = viewModel.currentGame.gameType
            // Assign some sample scores if needed for realistic preview
            viewModel.currentGame.players[i].scores = [[20, 15, 16], [25, 18, 17]]
            viewModel.currentGame.players[i].remainingScoresPerTurn = [viewModel.currentGame.gameType - 51, viewModel.currentGame.gameType - 110]
        }
        return viewModel
    }

    static var previews: some View {
        Group {
            // Preview with 1 player
            GameViewV2(selectedGame: 501, players: createViewModel(playerCount: 1).currentGame.players, viewModel: createViewModel(playerCount: 1))
                .previewDisplayName("1 Player")
            
            // Preview with 2 players
            GameViewV2(selectedGame: 501, players: createViewModel(playerCount: 2).currentGame.players, viewModel: createViewModel(playerCount: 2))
                .previewDisplayName("2 Players")
            
            // Preview with 3 players
            GameViewV2(selectedGame: 501, players: createViewModel(playerCount: 3).currentGame.players, viewModel: createViewModel(playerCount: 3))
                .previewDisplayName("3 Players")
            
            // Preview with 4 players
            GameViewV2(selectedGame: 501, players: createViewModel(playerCount: 4).currentGame.players, viewModel: createViewModel(playerCount: 4))
                .previewDisplayName("4 Players")
        }
    }
}


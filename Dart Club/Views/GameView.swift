//
//  GameView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct GameView: View {
    
    var selectedGame: Int?
    var players: [Player]
    
    @State private var enterThrowScore: Bool = false
    @State private var showInformationsView = false
    @State private var showSettingsView = false

    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {

                ZStack {

                    Color(.blue)

                    HStack {

                        Spacer()

//                        Button(action: {
//                            print("--------------------------------------------")
//                            print("BUTTON SettingsView")
//                            showSettingsView = true
//                        }) {
//                            Image(systemName: "gearshape")
//                                .accessibilityLabel("Undo")
//                                .font(.system(size: 25))
//                        }
//                        .sheet(isPresented: $showSettingsView) {
//                            SettingsView()
//                        }
                        
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
                            InformationsView(viewModel: viewModel)
                        }
                        
// /////////////////////// DEBUG BUTTON //////////////////////////////////////////////////

//                        Button(action: {
//
//                            print("--------------------------------------------")
//                            print("--------------------------------------------")
//                            print("DEBUG")
//                            print("--------------------------------------------")
//                            print("--------------------------------------------")
//                            print(" ")
//                            print("GAMETYPE : \(viewModel.currentGame.gameType)")
//                            print(" ")
//                            print("NOMBRE DE JOUEURS : \(viewModel.currentGame.players.count)")
//                            print(" ")
//                            print("NAME PLAYER 1 : \(viewModel.currentGame.players[0].name)")
//                            print("REMAINGSCORE PLAYER 1 : \(viewModel.currentGame.players[0].remainingScore)")
//                            print(" ")
//                            if players.count > 1 {
//                                print("NAME PLAYER 2 : \(viewModel.currentGame.players[1].name)")
//                                print("REMAINGSCORE PLAYER 2 : \(viewModel.currentGame.players[1].remainingScore)")
//                                print(" ")
//                            }
//                            if players.count > 2 {
//                                print("NAME PLAYER 3 : \(viewModel.currentGame.players[2].name)")
//                                print("REMAINGSCORE PLAYER 3 : \(viewModel.currentGame.players[2].remainingScore)")
//                                print(" ")
//                            }
//                            if players.count > 3 {
//                                print("NAME PLAYER 4 : \(viewModel.currentGame.players[3].name)")
//                                print("REMAINGSCORE PLAYER 4 : \(viewModel.currentGame.players[3].remainingScore)")
//                                print(" ")
//                            }
//                            print("CURRENT TURN : \(viewModel.currentGame.currentTurn)")
//                            print(" ")
//                            print("CURRENT PLAYER : \(players[viewModel.currentPlayerIndex].name)")
//                            print("CURRENT PLAYER INDEX : \(viewModel.currentPlayerIndex)")
//                            print(" ")
//                        }) {
//                            Image(systemName: "ladybug.circle")
//                                .accessibilityLabel("Undo")
//                                .font(.system(size: 25))
//                        }
                        
// //////////////////////////////////////////////////////////////////////////////////////
                        
                        Spacer()

                        Text("\(players[viewModel.currentPlayerIndex].name)")
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

                    Color(viewModel.currentPlayerIndex == 0 ? .yellow : .gray)
                    
                    VStack {

                        Spacer()

                        HStack {
                            Text("\(players[0].name)")
                                .fontWeight(.bold)
                            Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 0))")
                                .font(
                                    .system(size: 14))
                            if viewModel.currentGame.players[0].isBusted {
                                Text("🥊 BUST")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                            }
                        }

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON enterThrowScore PLAYER 1")
                            enterThrowScore = true
//                         isUndoDisabled = false
                        }) {
                            Text("\(viewModel.currentGame.players[0].remainingScore)")
                                .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                .foregroundColor(viewModel.currentGame.players[0].isBusted ? .red : .black)
                                .shadow(color: viewModel.currentGame.players[0].isBusted ? .black : .clear, radius: viewModel.currentGame.players[0].isBusted ? 2 : 0, x: 1, y: 1)
                        }
                        .disabled(viewModel.currentPlayerIndex != 0)
                        
                        Spacer()
                        Divider()
                        
                    }
                }
                
                if players.count > 1 {

                    ZStack {
                        
                        Color(viewModel.currentPlayerIndex == 1 ? .yellow : .gray)

                        VStack {

                            Spacer()

                            HStack {
                                Text("\(players[1].name)")
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 1))")
                                    .font(
                                        .system(size: 14))
                                if viewModel.currentGame.players[1].isBusted {
                                    Text("- BUST")
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .shadow(color: .black.opacity(1), radius: 5, x: 1, y: 1)
                                }
                            }

                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 2")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.currentGame.players[1].remainingScore)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                    .foregroundColor(viewModel.currentGame.players[1].isBusted ? .red : .black)
                                    .shadow(color: viewModel.currentGame.players[1].isBusted ? .black : .clear, radius: viewModel.currentGame.players[1].isBusted ? 2 : 0, x: 1, y: 1)
                            }
                            .disabled(viewModel.currentPlayerIndex != 1)
                            
                            Spacer()
                            Divider()

                        }
                    }
                }

                if players.count > 2 {

                    ZStack {

                        Color(viewModel.currentPlayerIndex == 2 ? .yellow : .gray)

                        VStack {

                            Spacer()

                            HStack {
                                Text("\(players[2].name)")
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 2))")
                                    .font(
                                        .system(size: 14))
                                if viewModel.currentGame.players[2].isBusted {
                                    Text("- BUST")
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .shadow(color: .black.opacity(1), radius: 5, x: 1, y: 1)
                                }
                            }

                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 3")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.currentGame.players[2].remainingScore)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                    .foregroundColor(viewModel.currentGame.players[2].isBusted ? .red : .black)
                                    .shadow(color: viewModel.currentGame.players[2].isBusted ? .black : .clear, radius: viewModel.currentGame.players[2].isBusted ? 2 : 0, x: 1, y: 1)
                            }
                            .disabled(viewModel.currentPlayerIndex != 2)
                            
                            Spacer()
                            Divider()

                        }
                    }
                }

                if players.count > 3 {

                    ZStack {

                        Color(viewModel.currentPlayerIndex == 3 ? .yellow : .gray)

                        VStack {

                            Spacer()

                            HStack {
                                Text("\(players[3].name)")
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(viewModel.averageThrowScore(forPlayer: 3))")
                                    .font(
                                        .system(size: 14))
                                if viewModel.currentGame.players[3].isBusted {
                                    Text("- BUST")
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .shadow(color: .black.opacity(1), radius: 5, x: 1, y: 1)
                                }
                            }

                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 4")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.currentGame.players[3].remainingScore)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                    .foregroundColor(viewModel.currentGame.players[3].isBusted ? .red : .black)
                                    .shadow(color: viewModel.currentGame.players[3].isBusted ? .black : .clear, radius: viewModel.currentGame.players[3].isBusted ? 2 : 0, x: 1, y: 1)
                            }
                            .disabled(viewModel.currentPlayerIndex != 3)
                            
                            Spacer()

                        }
                    }
                }
            }
            .foregroundColor(.black)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $enterThrowScore) {
                EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: $viewModel.currentPlayerIndex)
            }
            .onAppear {
                print("------------------------------")
                print("GAMEVIEW")
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
            .onChange(of: viewModel.currentGame.players.map({ $0.remainingScore })) {
                checkScores()
            }
            .sheet(isPresented: $showInformationsView) {
                InformationsView(viewModel: viewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    
    // FUNCTIONS ///////////////////
    
    private func checkScores() {
        for (_, player) in viewModel.currentGame.players.enumerated() {
            if player.remainingScore == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showInformationsView = true
                }
                break
            }
        }
        print("----------------------------------------")
        print("FONCTION CHECKSCORE")
    }
    
    private func undoLastScore() {
        print("----------------------------------------")
        print("FONCTION UNDOLASTSCORE (GAMEVIEW)")

        // Calcul de l'index du joueur précédent
        var previousPlayerIndex = viewModel.currentPlayerIndex - 1
        if previousPlayerIndex < 0 {
            previousPlayerIndex = viewModel.currentGame.players.count - 1
        }

        // Vérification si le joueur a des scores à annuler
        if let _ = viewModel.currentGame.players[previousPlayerIndex].scores.popLast() {
            print("Undoing score for player \(viewModel.currentGame.players[previousPlayerIndex].name).")

            // Mettre à jour les remainingScoresPerTurn si utilisé
            if !viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.isEmpty {
                viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.removeLast()
            }

            // Utiliser le dernier remainingScoresPerTurn valide pour recalculer le remainingScore
            if let lastValidRemainingScore = viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.last {
                viewModel.currentGame.players[previousPlayerIndex].remainingScore = lastValidRemainingScore
            } else {
                // Si aucun remainingScore valide n'est disponible, revenir à la valeur initiale du jeu
                viewModel.currentGame.players[previousPlayerIndex].remainingScore = viewModel.currentGame.gameType
            }

            // Ajuster l'index du joueur actuel
            viewModel.currentPlayerIndex = previousPlayerIndex

            // Ajuster le tour, si nécessaire
            if viewModel.currentGame.currentTurn > 1 && viewModel.currentGame.scoresThisTurn == 0 {
                viewModel.currentGame.currentTurn -= 1
                viewModel.currentGame.scoresThisTurn = viewModel.currentGame.players.count - 1
            } else if viewModel.currentGame.scoresThisTurn > 0 {
                viewModel.currentGame.scoresThisTurn -= 1
            }
        } else {
            print("No scores to undo for player \(viewModel.currentGame.players[previousPlayerIndex].name).")
        }
    }

}


// ///////////////////////////
// PREVIEW //////////////////

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
            GameView(selectedGame: 501, players: createViewModel(playerCount: 1).currentGame.players, viewModel: createViewModel(playerCount: 1))
                .previewDisplayName("1 Player")
            
            // Preview with 2 players
            GameView(selectedGame: 501, players: createViewModel(playerCount: 2).currentGame.players, viewModel: createViewModel(playerCount: 2))
                .previewDisplayName("2 Players")
            
            // Preview with 3 players
            GameView(selectedGame: 501, players: createViewModel(playerCount: 3).currentGame.players, viewModel: createViewModel(playerCount: 3))
                .previewDisplayName("3 Players")
            
            // Preview with 4 players
            GameView(selectedGame: 501, players: createViewModel(playerCount: 4).currentGame.players, viewModel: createViewModel(playerCount: 4))
                .previewDisplayName("4 Players")
        }
    }
}

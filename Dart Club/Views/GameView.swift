//
//  GameView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct GameView: View {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var selectedGame: Int?
    var players: [Player]
    
    @State private var enterThrowScore: Bool = false
    @State private var showInformationsView = false
    @State private var showSettingsView = false
    @State private var isUndoDisabled = true
    
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {

                ZStack {

                    Color(.blue)

                    HStack {

                        Spacer()

//////////////////////////////////////////////////////////////////// SETTINGS /////////////////////////////////////////////////////////////////

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
                        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON InformationsViewV2")
                            showInformationsView = true
                        }) {
                            Image(systemName: "info.circle")
                                .accessibilityLabel("Undo")
                                .font(.system(size: 25))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showInformationsView) {
                            InformationsView(viewModel: viewModel)
                        }
                        
//////////////////////////////////////////////////////////////////// DEBUG BUTTON /////////////////////////////////////////////////////////////////

//        Button(action: {
//
//            print("--------------------------------------------")
//            print("--------------------------------------------")
//            print("DEBUG")
//            print("--------------------------------------------")
//            print("--------------------------------------------")
//            print("DOUBLE OUT: \(viewModel.currentGame.isToggledDoubleOut)")
//            print(" ")
//            print(" ")
//            
//        }) {
//            Image(systemName: "ladybug.circle")
//                .accessibilityLabel("Undo")
//                .font(.system(size: 25))
//        }
                        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        
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
                        .disabled(isUndoDisabled)
                        .foregroundColor(isUndoDisabled ? .gray : .white)
                        .buttonStyle(PlainButtonStyle())

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
                        }) {
                            Text("\(viewModel.currentGame.players[0].remainingScore)")
                                .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                .foregroundColor(viewModel.currentGame.players[0].isBusted ? .red : .black)
                                .shadow(color: viewModel.currentGame.players[0].isBusted ? .black : .clear, radius: viewModel.currentGame.players[0].isBusted ? 2 : 0, x: 1, y: 1)
                        }
                        .disabled(viewModel.currentPlayerIndex != 0)
                        .buttonStyle(PlainButtonStyle())

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
                            }) {
                                Text("\(viewModel.currentGame.players[1].remainingScore)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                    .foregroundColor(viewModel.currentGame.players[1].isBusted ? .red : .black)
                                    .shadow(color: viewModel.currentGame.players[1].isBusted ? .black : .clear, radius: viewModel.currentGame.players[1].isBusted ? 2 : 0, x: 1, y: 1)
                            }
                            .disabled(viewModel.currentPlayerIndex != 1)
                            .buttonStyle(PlainButtonStyle())

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
                            }) {
                                Text("\(viewModel.currentGame.players[2].remainingScore)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                    .foregroundColor(viewModel.currentGame.players[2].isBusted ? .red : .black)
                                    .shadow(color: viewModel.currentGame.players[2].isBusted ? .black : .clear, radius: viewModel.currentGame.players[2].isBusted ? 2 : 0, x: 1, y: 1)
                            }
                            .disabled(viewModel.currentPlayerIndex != 2)
                            .buttonStyle(PlainButtonStyle())

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
                            }) {
                                Text("\(viewModel.currentGame.players[3].remainingScore)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                                    .foregroundColor(viewModel.currentGame.players[3].isBusted ? .red : .black)
                                    .shadow(color: viewModel.currentGame.players[3].isBusted ? .black : .clear, radius: viewModel.currentGame.players[3].isBusted ? 2 : 0, x: 1, y: 1)
                            }
                            .disabled(viewModel.currentPlayerIndex != 3)
                            .buttonStyle(PlainButtonStyle())

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
                updateUndoButtonState()
            }
            .onChange(of: viewModel.currentGame.players.map({ $0.remainingScore })) {
                checkScores()
                updateUndoButtonState()
            }
            .sheet(isPresented: $showInformationsView) {
                InformationsView(viewModel: viewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
        viewModel.currentGame.players[previousPlayerIndex].isBusted = false
    }
    
    private func updateUndoButtonState() {
        // Cette fonction met à jour l'état du bouton undo en fonction de la possibilité d'annuler un score
        let playerIndex = viewModel.currentPlayerIndex
        let previousIndex = playerIndex == 0 ? viewModel.currentGame.players.count - 1 : playerIndex - 1
        isUndoDisabled = viewModel.currentGame.players[previousIndex].scores.isEmpty
    }

}


// ///////////////////////////
// PREVIEW //////////////////

struct GameViewV2_Previews: PreviewProvider {
    static func createViewModel(playerCount: Int) -> GameViewModel {
        let viewModel = GameViewModel(gameType: 501)
        while viewModel.currentGame.players.count < playerCount {
            viewModel.addPlayer()
        }
        for i in 0..<viewModel.currentGame.players.count {
            viewModel.currentGame.players[i].name = "Player \(i + 1)"
            viewModel.currentGame.players[i].remainingScore = viewModel.currentGame.gameType
            viewModel.currentGame.players[i].scores = [[20, 15, 16], [25, 18, 17]]
            viewModel.currentGame.players[i].remainingScoresPerTurn = [viewModel.currentGame.gameType - 51, viewModel.currentGame.gameType - 110]
        }
        viewModel.currentGame.isToggledDoubleOut = true
        return viewModel
    }

    static var previews: some View {
        Group {
            let onePlayerVM = createViewModel(playerCount: 1)
            let twoPlayerVM = createViewModel(playerCount: 2)
            let threePlayerVM = createViewModel(playerCount: 3)
            let fourPlayerVM = createViewModel(playerCount: 4)
            
            GameView(selectedGame: 501, players: onePlayerVM.currentGame.players, viewModel: onePlayerVM)
                .previewDisplayName("1 Player")
                .environment(\.locale, Locale(identifier: "en"))

            GameView(selectedGame: 501, players: twoPlayerVM.currentGame.players, viewModel: twoPlayerVM)
                .previewDisplayName("2 Players")
                .environment(\.locale, Locale(identifier: "en"))

            GameView(selectedGame: 501, players: threePlayerVM.currentGame.players, viewModel: threePlayerVM)
                .previewDisplayName("3 Players")
                .environment(\.locale, Locale(identifier: "en"))

            GameView(selectedGame: 501, players: fourPlayerVM.currentGame.players, viewModel: fourPlayerVM)
                .previewDisplayName("4 Players")
                .environment(\.locale, Locale(identifier: "en"))

            GameView(selectedGame: 501, players: threePlayerVM.currentGame.players, viewModel: threePlayerVM)
                .previewDisplayName("Français")
                .environment(\.locale, Locale(identifier: "fr"))
        }
    }
}

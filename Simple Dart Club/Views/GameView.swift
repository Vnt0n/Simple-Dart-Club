//
//  GameView.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct GameView: View {
        
    var selectedGame: Int?
    var players: [Player]
    
    @State private var enterThrowScore: Bool = false
    @State private var showInformationsView = false
    @State private var isUndoDisabled = true
    
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {

                ZStack {

                    Color(.blue)

                    HStack {

                        Spacer()

                        if UIDevice.current.userInterfaceIdiom != .pad {
                            
                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON InformationsView")
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
                            
                        }
                        
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
                .frame(height: 40)

                HStack {
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        InformationsView(viewModel: viewModel)
                            .frame(width: 400)
                    }
                    
                    VStack {
                        ZStack {
                            
                            Color(viewModel.currentPlayerIndex == 0 ? .yellow : .gray)
                            
                            VStack {
                                
                                Spacer()
                                
                                VStack {
                                    HStack {
                                        Text("\(players[0].name)")
                                            .fontWeight(.bold)
                                            .font(.system(size: 18))
                                        if viewModel.currentGame.players[0].isBusted {
                                            Text("🥊 BUST")
                                                .fontWeight(.bold)
                                                .foregroundColor(.red)
                                                .shadow(color: .black, radius: 0, x: 1, y: 1)
                                        }
                                        
                                    }
                                    Text("Average Throw Score: \(viewModel.averageThrowScore(forPlayer: 0))")
                                        .font(
                                            .system(size: 14))
                                   
                                }
                                
                                Button(action: {
                                    print("--------------------------------------------")
                                    print("BUTTON enterThrowScore PLAYER 1")
                                    enterThrowScore = true
                                    viewModel.dismissEnterThrowScoreView = false
                                }) {
                                    Text("\(viewModel.currentGame.players[0].remainingScore)")
                                        .font(players.count > 3 ? .system(size: 70, weight: .bold, design: .default) : .system(size: 123, weight: .bold, design: .default))
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
                                    
                                    VStack {
                                        HStack {
                                            Text("\(players[1].name)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 18))
                                            if viewModel.currentGame.players[1].isBusted {
                                                Text("🥊 BUST")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.red)
                                                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                                            }
                                        }
                                        Text("Average Throw Score: \(viewModel.averageThrowScore(forPlayer: 1))")
                                            .font(
                                                .system(size: 14))
                                    }
                                    
                                    Button(action: {
                                        print("--------------------------------------------")
                                        print("BUTTON enterThrowScore PLAYER 2")
                                        enterThrowScore = true
                                        viewModel.dismissEnterThrowScoreView = false
                                    }) {
                                        Text("\(viewModel.currentGame.players[1].remainingScore)")
                                            .font(players.count > 3 ? .system(size: 70, weight: .bold, design: .default) : .system(size: 123, weight: .bold, design: .default))
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
                                    
                                    VStack {
                                        HStack {
                                            Text("\(players[2].name)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 18))
                                            if viewModel.currentGame.players[2].isBusted {
                                                Text("🥊 BUST")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.red)
                                                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                                            }
                                        }
                                        Text("Average Throw Score: \(viewModel.averageThrowScore(forPlayer: 2))")
                                            .font(
                                                .system(size: 14))
                                    }
                                    
                                    Button(action: {
                                        print("--------------------------------------------")
                                        print("BUTTON enterThrowScore PLAYER 3")
                                        enterThrowScore = true
                                        viewModel.dismissEnterThrowScoreView = false
                                    }) {
                                        Text("\(viewModel.currentGame.players[2].remainingScore)")
                                            .font(players.count > 3 ? .system(size: 70, weight: .bold, design: .default) : .system(size: 123, weight: .bold, design: .default))
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
                                    
                                    VStack {
                                        HStack {
                                            Text("\(players[3].name)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 18))
                                            if viewModel.currentGame.players[3].isBusted {
                                                Text("🥊 BUST")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.red)
                                                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                                            }
                                        }
                                        Text("Average Throw Score: \(viewModel.averageThrowScore(forPlayer: 3))")
                                            .font(
                                                .system(size: 14))
                                    }
                                    
                                    Button(action: {
                                        print("--------------------------------------------")
                                        print("BUTTON enterThrowScore PLAYER 4")
                                        enterThrowScore = true
                                        viewModel.dismissEnterThrowScoreView = false
                                    }) {
                                        Text("\(viewModel.currentGame.players[3].remainingScore)")
                                            .font(players.count > 3 ? .system(size: 70, weight: .bold, design: .default) : .system(size: 123, weight: .bold, design: .default))
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
                }
            }
            .foregroundColor(.black)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $enterThrowScore) {
                EnterThrowScoreView(viewModel: viewModel)
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
        .preferredColorScheme(.dark)
    }

    
    // FUNCTIONS ///////////////////
    
    private func checkScores() {
        print("--------------------------------------------")
        print("checkScores (PRIVATE) FUNCTION (GameView)")
        for (_, player) in viewModel.currentGame.players.enumerated() {
            if player.remainingScore == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showInformationsView = true
                }
                break
            }
        }
    }
    
    private func undoLastScore() {
        print("--------------------------------------------")
        print("undoLastScore (PRIVATE) FUNCTION (GameView)")

        var previousPlayerIndex = viewModel.currentPlayerIndex - 1
        if previousPlayerIndex < 0 {
            previousPlayerIndex = viewModel.currentGame.players.count - 1
        }

        if let _ = viewModel.currentGame.players[previousPlayerIndex].scores.popLast() {
            print("Undoing score for player \(viewModel.currentGame.players[previousPlayerIndex].name).")

            if !viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.isEmpty {
                viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.removeLast()
            }

            if let lastValidRemainingScore = viewModel.currentGame.players[previousPlayerIndex].remainingScoresPerTurn.last {
                viewModel.currentGame.players[previousPlayerIndex].remainingScore = lastValidRemainingScore
            } else {
                viewModel.currentGame.players[previousPlayerIndex].remainingScore = viewModel.currentGame.gameType
            }

            viewModel.currentPlayerIndex = previousPlayerIndex

            if viewModel.currentGame.currentTurn > 1 && viewModel.currentGame.scoresThisTurn == 0 {
                viewModel.currentGame.currentTurn -= 1
                viewModel.currentGame.scoresThisTurn = viewModel.currentGame.players.count - 1
            } else if viewModel.currentGame.scoresThisTurn > 0 {
                viewModel.currentGame.scoresThisTurn -= 1
            }
        }
        viewModel.currentGame.players[previousPlayerIndex].isBusted = false
    }
    
    private func updateUndoButtonState() {
        print("--------------------------------------------")
        print("updateUndoButtonState (PRIVATE) FUNCTION (GameView)")
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
                .previewDisplayName("French")
                .environment(\.locale, Locale(identifier: "fr"))

            GameView(selectedGame: 501, players: threePlayerVM.currentGame.players, viewModel: threePlayerVM)
                .previewDisplayName("Spanish")
                .environment(\.locale, Locale(identifier: "es"))
            
            GameView(selectedGame: 501, players: threePlayerVM.currentGame.players, viewModel: threePlayerVM)
                .previewDisplayName("German")
                .environment(\.locale, Locale(identifier: "de"))
            
            GameView(selectedGame: 501, players: threePlayerVM.currentGame.players, viewModel: threePlayerVM)
                .previewDisplayName("Chinese")
                .environment(\.locale, Locale(identifier: "zh-Hans"))
            
            GameView(selectedGame: 501, players: threePlayerVM.currentGame.players, viewModel: threePlayerVM)
                .previewDisplayName("Japanese")
                .environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

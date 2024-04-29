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
    @State private var gameCount: Int = 1

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
                        
                        Spacer()

                        Text("\(players[currentPlayerIndex].name)")
                            .fontWeight(.bold)

                        Spacer()

                        Text("Game \(gameCount)")
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
                            Text("-  Average Score:  #")
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
                            Text("\(viewModel.currentGame.gameType)")
                                .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                        }
                        .disabled(currentPlayerIndex != 0)

                        Spacer()

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
                                Text("-  Average Score:  #")
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
                                Text("\(viewModel.currentGame.gameType)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 1)

                            Spacer()

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
                                Text("-  Average Score:  #")
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
                                print("BUTTON enterThrowScore PLAYER 3")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.currentGame.gameType)")
                                    .font(players.count > 3 ? .system(size: 80, weight: .bold, design: .default) : .system(size: 130, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 2)

                            Spacer()

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
                                Text("-  Average Score:  #")
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
                                print("BUTTON enterThrowScore PLAYER 4")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("\(viewModel.currentGame.gameType)")
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
                    .onAppear {
                                // Ici, tu imprimes directement les scores du premier joueur
                                if let firstPlayer = viewModel.currentGame.players.first {
                                    let scores = firstPlayer.scores
                                    print("Scores du player 1: \(scores)")
                                } else {
                                    print("No players available")
                                }
                            }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    
    // FUNCTIONS ///////////////////
    
    private func undoLastScore() {
        viewModel.undoLastScore(forPlayer: viewModel.currentGame.currentTurn % viewModel.currentGame.players.count)
        print("----------------------------------------")
        print("Function undoLastScore 02")
    }
    
}


// ///////////////////////////
// PREVIEW //////////////////

struct GameViewV2_Previews: PreviewProvider {
    static var previews: some View {
        let gameType = 501  // Assuming the game type is 501
        let viewModel = GameViewModel(gameType: gameType)  // Initialize the view model with the game type

        // Ensure we have exactly 4 players for the preview
        while viewModel.currentGame.players.count < 4 {
            viewModel.addPlayer()
        }

        // Assign names to players for the preview
        viewModel.currentGame.players[0].name = "Alice"
        viewModel.currentGame.players[1].name = "Bob"
        viewModel.currentGame.players[2].name = "Carol"
        viewModel.currentGame.players[3].name = "Dave"

        // Return the GameViewV2 with the configured viewModel
        return GameViewV2(selectedGame: gameType, players: viewModel.currentGame.players, viewModel: viewModel)
    }
}

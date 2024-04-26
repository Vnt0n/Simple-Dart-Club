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
    @State private var enterThrowScore = false
    @State private var showInformationsView = false

    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {

                ZStack {

                    Color(.blue)

                    HStack {

                        Spacer()

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON undoLastScore")
                            showInformationsView = true
//                            undoLastScore()
                        }) {
                            Image(systemName: "info.circle")
                                .accessibilityLabel("Undo")
                                .font(.system(size: 25))
                        }
                        .sheet(isPresented: $showInformationsView) {
                            InformationsViewV2()
                        }
                        
                        Spacer()

                        Text("\(players[currentPlayerIndex].name)")
                            .fontWeight(.bold)

                        Spacer()

                        Text("Game #")
                        Text("- Turn #")
                            .bold()

                        Spacer()

                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON undoLastScore")
//                        undoLastScore()
                            currentPlayerIndex = (currentPlayerIndex + 1) % players.count
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
                            Text("300")
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
                                print("BUTTON enterThrowScore PLAYER 1")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("300")
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
                                print("BUTTON enterThrowScore PLAYER 1")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("300")
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
                                print("BUTTON enterThrowScore PLAYER 1")
                         enterThrowScore = true
//                         isUndoDisabled = false
                            }) {
                                Text("300")
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
                EnterThrowScoreViewV2(players: players, currentPlayerIndex: $currentPlayerIndex)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

}


// ///////////////////////////
// PREVIEW //////////////////

struct GameViewV2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Prévisualisation avec un jeu 301 sélectionné et 1 joueurs
            GameViewV2(selectedGame: 301, players: [
                Player(name: "Alice", isNameSubmitted: true)
            ])
            .previewLayout(.sizeThatFits)
            .previewDisplayName("301 - 1 Player")
            
            // Prévisualisation avec un jeu 301 sélectionné et 2 joueurs
            GameViewV2(selectedGame: 301, players: [
                Player(name: "Alice", isNameSubmitted: true),
                Player(name: "Bob", isNameSubmitted: true)
            ])
            .previewLayout(.sizeThatFits)
            .previewDisplayName("301 - 2 Players")
            
            // Prévisualisation avec un jeu 301 sélectionné et 3 joueurs
            GameViewV2(selectedGame: 301, players: [
                Player(name: "Alice", isNameSubmitted: true),
                Player(name: "Bob", isNameSubmitted: true),
                Player(name: "Charlie", isNameSubmitted: true)
            ])
            .previewLayout(.sizeThatFits)
            .previewDisplayName("301 - 3 Players")

            // Prévisualisation avec un jeu 501 sélectionné et 4 joueurs
            GameViewV2(selectedGame: 501, players: [
                Player(name: "Alice", isNameSubmitted: true),
                Player(name: "Bob", isNameSubmitted: true),
                Player(name: "Charlie", isNameSubmitted: true),
                Player(name: "Diana", isNameSubmitted: true)
            ])
            .previewLayout(.sizeThatFits)
            .previewDisplayName("501 - 4 Players")
        }
    }
}

//
//  GameView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct GameView: View {
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    @State private var selectedPlayer: String = ""
    @State private var currentPlayerIndex: Int = 0
    @State private var gameCount: Int = 0
       
    @State private var scorePlayer1: Int = 501
    @State private var scorePlayer2: Int = 501
    @State private var scorePlayer3: Int = 501
    
    @State private var enterScore = false
    @State private var isGameOver = false
    
    @State private var isConfettiAnimationActive = false
                    
    private var playerNames: [String] {
        [namePlayer1, namePlayer2, namePlayer3].filter { !$0.isEmpty }
    }
    
    private var isAnyPlayerScoreZero: Bool {
        scorePlayer1 == 0 || scorePlayer2 == 0 || scorePlayer3 == 0
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                ZStack {
                    Color(.blue)
                    HStack {
                        Spacer()
                        Text("\(selectedPlayer) 1st threw")
                        Spacer()
                        Image(systemName: "info.circle")
                            .accessibilityLabel("Menu")
                            .font(.system(size: 25))
                        Spacer()
                        Image(systemName: "arrow.uturn.backward.circle")
                            .accessibilityLabel("Undo")
                            .font(.system(size: 25))
                        Spacer()

                    }
                }
                .background(Color.blue)
                .frame(height: 60)
                
                 ZStack {
                     Color(currentPlayerIndex == 0 ? .yellow : .gray)
                     VStack {
                         Text(namePlayer1)
                         Button(action: {
                             enterScore = true
                             selectedPlayer = namePlayer1
                         }) {
                             Text("\(scorePlayer1)")
                                 .font(.system(size: 140, weight: .bold, design: .default))
                         }
                         .disabled(currentPlayerIndex != 0 || scorePlayer1 == 0)
                     }
                 }
                 .edgesIgnoringSafeArea(.all)

                ZStack {
                    Color(currentPlayerIndex == 1 ? .yellow : .gray)
                    VStack {
                        Text(namePlayer2)
                        Button(action: {
                            enterScore = true
                            selectedPlayer = namePlayer2
                        }) {
                            Text("\(scorePlayer2)")
                                .font(.system(size: 140, weight: .bold, design: .default))
                        }
                        .disabled(currentPlayerIndex != 1 || scorePlayer2 == 0)
                    }
                }
                .edgesIgnoringSafeArea(.all)

                if !namePlayer3.isEmpty {
                    ZStack {
                        Color(currentPlayerIndex == 2 ? .yellow : .gray)
                        VStack {
                            Text(namePlayer3)
                            Button(action: {
                                enterScore = true
                                selectedPlayer = namePlayer3
                            }) {
                                Text("\(scorePlayer3)")
                                    .font(.system(size: 140, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 2  || scorePlayer3 == 0)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                
            }
            .foregroundColor(.black)
            .sheet(isPresented: $enterScore) {
                EnterScoreView(playerName: selectedPlayer, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3) { enteredScore in
                    var newScore = 0
                    
                    switch selectedPlayer {
                    case namePlayer1:
                        let tempScore = scorePlayer1 - (Int(enteredScore) ?? 0)
                        if tempScore < 0 {
                            return
                        } else {
                            scorePlayer1 = tempScore
                            newScore = tempScore
                        }
                    case namePlayer2:
                        let tempScore = scorePlayer2 - (Int(enteredScore) ?? 0)
                        if tempScore < 0 {
                            return
                        } else {
                            scorePlayer2 = tempScore
                            newScore = tempScore
                        }
                    case namePlayer3:
                        let tempScore = scorePlayer3 - (Int(enteredScore) ?? 0)
                        if tempScore < 0 {
                            return
                        } else {
                            scorePlayer3 = tempScore
                            newScore = tempScore
                        }
                    default:
                        break
                    }
                    
                    if newScore == 0 {
                        enterScore = false
                        isGameOver = true
                    } else {
                        currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                    }
                }
                .presentationDetents([.large])
            }
        }
        .navigationBarBackButtonHidden(true)
        .overlay(
            EmptyView()
        )
        .navigationDestination(isPresented: $isGameOver) {
            WinnerView(playerNames: playerNames, scorePlayer1: $scorePlayer1, scorePlayer2: $scorePlayer2, scorePlayer3: $scorePlayer3, currentPlayerIndex: $currentPlayerIndex, winnerName: selectedPlayer, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
        }
        .onAppear() {
            gameCount += 1
            let numberOfPlayers = playerNames.count
            currentPlayerIndex = (gameCount - 1) % numberOfPlayers
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "Player 3")
    }
}

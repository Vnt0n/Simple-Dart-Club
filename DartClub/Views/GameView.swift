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
    
    @State private var scorePlayer1: Int = 501
    @State private var scorePlayer2: Int = 501
    @State private var scorePlayer3: Int = 501
    
    @State private var enterScore = false
    @State private var isGameOver = false
    
    @State private var isConfettiAnimationActive = false
                    
    private var playerNames: [String] {
        [namePlayer1, namePlayer2, namePlayer3].filter { !$0.isEmpty }
    }
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                
                ZStack {
                    Color(currentPlayerIndex == 0 ? .yellow : .gray)
                    if scorePlayer1 == 0 {
                        Color(.black)
                    }
                    VStack {
                        Text(namePlayer1)
                        Button(action: {
                            enterScore = true
                            selectedPlayer = namePlayer1
                            
                            print(selectedPlayer)
                            print("Current Player index = \(currentPlayerIndex)")
                            
                        }) {
                            Text("\(scorePlayer1)")
                                .font(.system(size: 140, weight: .bold, design: .default))
                        }
                        .disabled(currentPlayerIndex != 0 || scorePlayer1 == 0)
                    }
                    .foregroundColor(scorePlayer1 == 0 ? .white : .black)
                }
                .edgesIgnoringSafeArea(.top)
                
                ZStack {
                    Color(currentPlayerIndex == 1 ? .yellow : .gray)
                    if scorePlayer2 == 0 {
                        Color(.black)                  }
                    VStack {
                        Text(namePlayer2)
                        Button(action: {
                            enterScore = true
                            selectedPlayer = namePlayer2
                            
                            print(selectedPlayer)
                            print("Current Player index = \(currentPlayerIndex)")

                        }) {
                            Text("\(scorePlayer2)")
                                .font(.system(size: 140, weight: .bold, design: .default))
                        }
                        .disabled(currentPlayerIndex != 1 || scorePlayer2 == 0)
                    }
                    .foregroundColor(scorePlayer2 == 0 ? .white : .black)
                }
                .edgesIgnoringSafeArea(.bottom)

                if !namePlayer3.isEmpty {
                    ZStack {
                        Color(currentPlayerIndex == 2 ? .yellow : .gray)
                        if scorePlayer3 == 0 {
                            Color(.black)
                        }
                        VStack {
                            Text(namePlayer3)
                            Button(action: {
                                enterScore = true
                                selectedPlayer = namePlayer3
                                
                                print(selectedPlayer)
                                print("Current Player index = \(currentPlayerIndex)")

                            }) {
                                Text("\(scorePlayer3)")
                                    .font(.system(size: 140, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 2  || scorePlayer3 == 0)
                        }
                        .foregroundColor(scorePlayer3 == 0 ? .white : .black)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
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
            WinnerView(playerNames: playerNames, scorePlayer1: $scorePlayer1, scorePlayer2: $scorePlayer2, scorePlayer3: $scorePlayer3, winnerName: selectedPlayer, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "Player 3")
    }
}

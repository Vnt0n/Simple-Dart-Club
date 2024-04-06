//
//  GameView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct GameView: View {
        
    @State private var informationRequested = false
    @State private var enterScore = false
    @State private var isGameOver = false
    @State private var isConfettiAnimationActive = false
    
    @State private var currentPlayerName: String = ""
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    private var playerNames: [String] {
        [namePlayer1, namePlayer2, namePlayer3].filter { !$0.isEmpty }
    }
    
    @State private var currentPlayerIndex: Int = 0
    @State private var gameCount: Int = 1
       
    @State private var scorePlayer1: Int = 501
    @State private var scorePlayer2: Int = 501
    @State private var scorePlayer3: Int = 501
    
    @State private var player1Scores: [Int] = []
    @State private var player2Scores: [Int] = []
    @State private var player3Scores: [Int] = []
    
    @State private var scoreHistory = ScoreHistory()
    @State private var scoreHistories: [ScoreHistory] = []

    struct ScoreHistory: Hashable {
        var player1: [Int] = []
        var player2: [Int] = []
        var player3: [Int] = []
        var winner: String = ""
    }

    private var isAnyPlayerScoreZero: Bool {
        scorePlayer1 == 0 || scorePlayer2 == 0 || scorePlayer3 == 0
    }
    
    @State private var throwsPlayer1: Int = 1
    @State private var throwsPlayer2: Int = 1
    @State private var throwsPlayer3: Int = 1
    
    private var currentPlayerThrows: Int {
        switch currentPlayerName {
        case namePlayer1:
            return throwsPlayer1
        case namePlayer2:
            return throwsPlayer2
        case namePlayer3:
            return throwsPlayer3
        default:
            return 0
        }
    }
        
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                ZStack {
                    
                    Color(.blue)
                    
                    HStack {
                        
                        Spacer()
                        
                        NavigationLink(destination: InformationsView(scoreHistories: $scoreHistories, player1Scores: $player1Scores, player2Scores: $player2Scores, player3Scores: $player3Scores, scorePlayer1: scorePlayer1, scorePlayer2: scorePlayer2, scorePlayer3: scorePlayer3, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3), isActive: $informationRequested) {
                            Image(systemName: "info.circle")
                                .accessibilityLabel("Menu")
                                .font(.system(size: 25))
                        }
                        
                        Spacer()
                        
                        Text("\(currentPlayerName)")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("Game \(gameCount)")
                        Text("- Turn \(currentPlayerThrows)")
                            .bold()

                        Spacer()
                        
                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON undoLastScore. Done?")
                            undoLastScore()
                            print("DONE")
                        }) {
                            Image(systemName: "arrow.uturn.backward.circle")
                                .accessibilityLabel("Undo")
                                .font(.system(size: 25))
                        }
                        
                            Spacer()
                        
                    }
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .frame(height: 60)
                
                 ZStack {
                     
                     Color(currentPlayerIndex == 0 ? .yellow : .gray)
                     
                     VStack {
                         
                         Spacer()
                         
                         HStack {
                             Text(namePlayer1)
                                 .fontWeight(.bold)
                             Text("-  Average Score:  \(calculateAverageScore(scores: player1Scores))")
                                 .font(
                                     .system(size: 14))
                         }
                         
                         Button(action: {
                             enterScore = true
                         }) {
                             Text("\(scorePlayer1)")
                                 .font(.system(size: 140, weight: .bold, design: .default))
                         }
                         .disabled(currentPlayerIndex != 0)
                         
                         Spacer()

                     }
                 }
                 .edgesIgnoringSafeArea(.all)

                ZStack {
                    
                    Color(currentPlayerIndex == 1 ? .yellow : .gray)
                    
                    VStack {
                        
                        Spacer()
                        
                        HStack {
                            Text(namePlayer2)
                                .fontWeight(.bold)
                            Text("-  Average Score: \(calculateAverageScore(scores: player2Scores))")
                                .font(
                                    .system(size: 14))
                        }
                        
                        Button(action: {
                            enterScore = true
                        }) {
                            Text("\(scorePlayer2)")
                                .font(.system(size: 140, weight: .bold, design: .default))
                        }
                        .disabled(currentPlayerIndex != 1)

                        Spacer()
                        
                    }
                }
                .edgesIgnoringSafeArea(.all)

                if !namePlayer3.isEmpty {
                    
                    ZStack {
                        
                        Color(currentPlayerIndex == 2 ? .yellow : .gray)
                        
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                Text(namePlayer3)
                                    .fontWeight(.bold)
                                Text("-  Average Score: \(calculateAverageScore(scores: player3Scores))")
                                    .font(
                                        .system(size: 14))
                            }
                            
                            Button(action: {
                                enterScore = true
                            }) {
                                Text("\(scorePlayer3)")
                                    .font(.system(size: 140, weight: .bold, design: .default))
                            }
                            .disabled(currentPlayerIndex != 2)
                            
                            Spacer()

                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .foregroundColor(.black)
            .sheet(isPresented: $enterScore) {
                EnterScoreView(playerName: currentPlayerName, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3, throwsPlayer1: $throwsPlayer1, throwsPlayer2: $throwsPlayer2, throwsPlayer3: $throwsPlayer3, player1Scores: $player1Scores, player2Scores: $player2Scores, player3Scores: $player3Scores) { enteredScore in

                    var newScore = 0
                    
                    switch currentPlayerName {
                    case namePlayer1:
                        let tempScore = scorePlayer1 - (Int(enteredScore) ?? 0)
                        if tempScore < 0 {
                            return
                        } else {
                            scoreHistory.player1.append(scorePlayer1 - tempScore)
                            scorePlayer1 = tempScore
                            newScore = tempScore
                        }
                    case namePlayer2:
                        let tempScore = scorePlayer2 - (Int(enteredScore) ?? 0)
                        if tempScore < 0 {
                            return
                        } else {
                            scoreHistory.player2.append(scorePlayer2 - tempScore)
                            scorePlayer2 = tempScore
                            newScore = tempScore
                        }
                    case namePlayer3:
                        let tempScore = scorePlayer3 - (Int(enteredScore) ?? 0)
                        if tempScore < 0 {
                            return
                        } else {
                            scoreHistory.player3.append(scorePlayer3 - tempScore)
                            scorePlayer3 = tempScore
                            newScore = tempScore
                        }
                    default:
                        break
                    }
                    
                    if newScore == 0 {
                        enterScore = false
                        isGameOver = true
                        saveScoreHistory()
                    } else {
                        currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                        currentPlayerName = playerNames[currentPlayerIndex]
                    }
                    
                    if isGameOver {
                        gameCount += 1
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
            WinnerView(scorePlayer1: $scorePlayer1, scorePlayer2: $scorePlayer2, scorePlayer3: $scorePlayer3, player1Scores: $player1Scores, player2Scores: $player2Scores, player3Scores: $player3Scores, currentPlayerIndex: $currentPlayerIndex, winnerName: currentPlayerName, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3, newGameResetClosure: { self.newGameReset() })
        }
        .onAppear() {
            if !informationRequested {
                
                print("--------------------------------------------")
                print("onAppear GameView if !informationRequested. Done?")
                
                currentPlayerIndex = (gameCount - 1) % playerNames.count
                currentPlayerName = playerNames[currentPlayerIndex]
                
                print("DONE")

            }
        }
        
    }

    
    // FUNCTIONS ///////////////////
    
    private func undoLastScore() {
        
        print("--------------------------------------------")
        print("func undoLastScore. Done?")
        
        let previousPlayerIndex = (currentPlayerIndex - 1 + playerNames.count) % playerNames.count
        switch playerNames[previousPlayerIndex] {
            
        case namePlayer1:
            if let lastScore = scoreHistory.player1.last {
                currentPlayerIndex = previousPlayerIndex
                scoreHistory.player1.removeLast()
                scorePlayer1 += lastScore
                throwsPlayer1 -= 1

                if !player1Scores.isEmpty {
                    player1Scores.removeLast()
                }
            }
            
        case namePlayer2:
            if let lastScore = scoreHistory.player2.last {
                currentPlayerIndex = previousPlayerIndex
                scoreHistory.player2.removeLast()
                scorePlayer2 += lastScore
                throwsPlayer2 -= 1

                if !player2Scores.isEmpty {
                    player2Scores.removeLast()
                }
            }
            
        case namePlayer3:
            if let lastScore = scoreHistory.player3.last {
                currentPlayerIndex = previousPlayerIndex
                scoreHistory.player3.removeLast()
                scorePlayer3 += lastScore
                throwsPlayer3 -= 1

                if !player3Scores.isEmpty {
                    player3Scores.removeLast()
                }
                
                print("DONE")
                
            }
        default:
            break
        }
        currentPlayerName = playerNames[currentPlayerIndex]
    }
    
    
    private func saveScoreHistory() {
        
        print("--------------------------------------------")
        print("func saveScoreHistory. Done?")
        
        // Déterminer le gagnant
        var winner = ""
        if scorePlayer1 == 0 {
            winner = namePlayer1
        } else if scorePlayer2 == 0 {
            winner = namePlayer2
        } else if scorePlayer3 == 0 {
            winner = namePlayer3
        }
        
        // Ajouter les scores et le gagnant à l'historique
        var history = scoreHistory
        history.winner = winner
        scoreHistories.append(history)
        
        // Réinitialiser l'historique des scores
        scoreHistory = ScoreHistory()
        
        print("DONE")

    }
    
    private func newGameReset() {
        
        print("--------------------------------------------")
        print("func newGameReset. Done?")
        
        throwsPlayer1 = 1
        throwsPlayer2 = 1
        throwsPlayer3 = 1
        player1Scores = []
        player2Scores = []
        player3Scores = []
        
        print("DONE")

    }
    
    func calculateAverageScore(scores: [Int]) -> Int {
      guard !scores.isEmpty else { return 0 }
      let sum = scores.reduce(0, +)
      return Int(round(Double(sum) / Double(scores.count)))
    }

}


// PREVIEWS ///////////////////

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(namePlayer1: "Antoine", namePlayer2: "Julien", namePlayer3: "JJ")
    }
}

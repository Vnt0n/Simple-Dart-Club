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
    @State private var isBusted = false
    
    var isThreeHundredOne: Bool
    var isFiveHundredOne:Bool
    
    @State private var currentPlayerName: String = ""
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    private var playerNames: [String] {
        [namePlayer1, namePlayer2, namePlayer3].filter { !$0.isEmpty }
    }
    
    @State private var currentPlayerIndex: Int = 0
    @State private var gameCount: Int = 1

    @State private var scorePlayer1: Int = 0
    @State private var scorePlayer2: Int = 0
    @State private var scorePlayer3: Int = 0
    
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
                            print("BUTTON undoLastScore")
                            undoLastScore()
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
                             print("--------------------------------------------")
                             print("BUTTON enterScore PLAYER 1")
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
                            print("--------------------------------------------")
                            print("BUTTON enterScore PLAYER 2")
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
                                print("--------------------------------------------")
                                print("BUTTON enterScore PLAYER 3")
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
                    var isBusted = false
                    
                    switch currentPlayerName {
                        
                    case namePlayer1:
                        
                        let tempScore = scorePlayer1 - (Int(enteredScore) ?? 0)
                        
                        if tempScore < 0 {
                            
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]
                            isBusted = true
                            
                            print("--------------------------------------------")
                            print("\(playerNames[currentPlayerIndex]) isBusted: \(isBusted), switch currentPlayerName : DONE")
                            
                            return
                            
                        } else {
                            
                            print("--------------------------------------------")
                            print("\(playerNames[currentPlayerIndex]) isBusted: \(isBusted), calculate score & switch currentPlayerName. Done?")
                            
                            scoreHistory.player1.append(scorePlayer1 - tempScore)
                            scorePlayer1 = tempScore
                            newScore = tempScore
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]
                            
                            print("Next player: \(currentPlayerName).")
                            print("DONE")

                        }
                        
                    case namePlayer2:
                        
                        let tempScore = scorePlayer2 - (Int(enteredScore) ?? 0)
                        
                        if tempScore < 0 {
                            
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]
                            isBusted = true
                            
                            print("--------------------------------------------")
                            print("\(playerNames[currentPlayerIndex]) isBusted: \(isBusted), switch currentPlayerName : DONE")
                            
                            return
                            
                        } else {
                            
                            print("--------------------------------------------")
                            print("\(playerNames[currentPlayerIndex]) isBusted: \(isBusted), calculate score & switch currentPlayerName. Done?")

                            scoreHistory.player2.append(scorePlayer2 - tempScore)
                            scorePlayer2 = tempScore
                            newScore = tempScore
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]
                            
                            print("Next player: \(currentPlayerName).")
                            print("DONE")

                        }
                        
                    case namePlayer3:
                        
                        let tempScore = scorePlayer3 - (Int(enteredScore) ?? 0)
                        
                        if tempScore < 0 {
                            
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]
                            isBusted = true
                            
                            print("--------------------------------------------")
                            print("PLAYER 3 isBusted: \(isBusted), switch currentPlayerName : DONE")
                            
                            return
                            
                        } else {
                            
                            print("--------------------------------------------")
                            print("\(playerNames[currentPlayerIndex]) isBusted: \(isBusted), calculate score & switch currentPlayerName. Done?")

                            scoreHistory.player3.append(scorePlayer3 - tempScore)
                            scorePlayer3 = tempScore
                            newScore = tempScore
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]
                            
                            print("Next player: \(currentPlayerName).")
                            print("DONE")

                        }
                        
                    default:
                        
                        print("--------------------------------------------")
                        print("switch currentPlayerName: BREAK")
                        
                        break
                    }
                    
                    if newScore == 0 {
                        
                        print("--------------------------------------------")
                        print("newScore == 0")
                        
                        enterScore = false
                        isGameOver = true
                        saveScoreHistory()
                        gameCount += 1
                        
                        print("enterScore: \(enterScore)")
                        print("isGameOver: \(isGameOver)")
                        print("gameCount + 1: next game = GAME \(gameCount)")

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
            WinnerView(isThreeHundredOne: isThreeHundredOne, isFiveHundredOne: isFiveHundredOne, scoreHistories: $scoreHistories, scorePlayer1: $scorePlayer1, scorePlayer2: $scorePlayer2, scorePlayer3: $scorePlayer3, player1Scores: $player1Scores, player2Scores: $player2Scores, player3Scores: $player3Scores, currentPlayerIndex: $currentPlayerIndex, winnerName: currentPlayerName, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3, newGameResetClosure: { self.newGameReset() })
        }
        .onAppear() {
            if !informationRequested {
                
                print("--------------------------------------------")
                print("onAppear GameView if !informationRequested. Done?")
                
                currentPlayerIndex = (gameCount - 1) % playerNames.count
                currentPlayerName = playerNames[currentPlayerIndex]
                
                print("DONE")
                
                print("isThreeHundredOne: \(isThreeHundredOne)")
                print("isFiveHundredOne: \(isFiveHundredOne)")
                
                if isThreeHundredOne {
                    scorePlayer1 = 301
                    scorePlayer2 = 301
                    scorePlayer3 = 301
                } else {
                    scorePlayer1 = 501
                    scorePlayer2 = 501
                    scorePlayer3 = 501
                }

            }
        }
        
    }

    
    // FUNCTIONS ///////////////////
    
    
    private func undoLastScore() {
        let previousPlayerIndex = (currentPlayerIndex - 1 + playerNames.count) % playerNames.count
        
        print("--------------------------------------------")
        print("func undoLastScore. Done?")

        var currentPlayerTotalScore: Int
        var currentPlayerScores: [Int]

        switch playerNames[previousPlayerIndex] {
        case namePlayer1:
            currentPlayerTotalScore = scorePlayer1
            currentPlayerScores = player1Scores
        case namePlayer2:
            currentPlayerTotalScore = scorePlayer2
            currentPlayerScores = player2Scores
        case namePlayer3:
            currentPlayerTotalScore = scorePlayer3
            currentPlayerScores = player3Scores
        default:
            return
        }

        if let lastScore = currentPlayerScores.last {
            currentPlayerIndex = previousPlayerIndex
            currentPlayerScores.removeLast()
            currentPlayerTotalScore += lastScore
            throwsPlayer1 -= 1
            
            if !currentPlayerScores.isEmpty && currentPlayerTotalScore != scorePlayer1 {
                player1Scores.removeLast()
            }
        }

        currentPlayerName = playerNames[currentPlayerIndex]
        
        print("DONE")

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
        GameView(isThreeHundredOne: true, isFiveHundredOne: false, namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "Player 3")
    }
}

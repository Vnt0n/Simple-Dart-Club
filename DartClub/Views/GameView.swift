//
//  GameView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct GameView: View {
        
    @State private var informationRequested = false
    @State private var enterThrowScore = false
    @State private var isGameOver = false
    @State private var isConfettiAnimationActive = false
    @State private var isBustedPlayer1 = false
    @State private var isBustedPlayer2 = false
    @State private var isBustedPlayer3 = false
    @State private var isUndoDisabled = true
    
    var isThreeHundredOne: Bool
    var isFiveHundredOne: Bool
    
    @State private var currentPlayerName: String = ""
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    private var playerNames: [String] {
        [namePlayer1, namePlayer2, namePlayer3].filter { !$0.isEmpty }
    }
    
    @State private var currentPlayerIndex: Int = 0
    @State private var gameCount: Int = 1

    @State private var totalScorePlayer1: Int = 0
    @State private var totalScorePlayer2: Int = 0
    @State private var totalScorePlayer3: Int = 0
    
    @State private var player1TotalScores: [Int] = []
    @State private var player2TotalScores: [Int] = []
    @State private var player3TotalScores: [Int] = []
    
    @State private var player1ThrowsScores: [Int] = []
    @State private var player2ThrowsScores: [Int] = []
    @State private var player3ThrowsScores: [Int] = []
    
    @State private var throwsScoresHistory = ThrowsScoresHistory()
    @State private var throwsScoresHistories: [ThrowsScoresHistory] = []

    struct ThrowsScoresHistory: Hashable {
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
                        
                        NavigationLink(destination: InformationsView(throwsScoresHistories: $throwsScoresHistories, player1ThrowsScores: $player1ThrowsScores, player2ThrowsScores: $player2ThrowsScores, player3ThrowsScores: $player3ThrowsScores, totalScorePlayer1: totalScorePlayer1, totalScorePlayer2: totalScorePlayer2, totalScorePlayer3: totalScorePlayer3, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3), isActive: $informationRequested) {
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
                        .disabled(isUndoDisabled)
                        .foregroundColor(isUndoDisabled ? .gray : .white)
                        
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
                             Text("-  Average Score:  \(calculateAverageThrowsScore(scores: player1ThrowsScores))")
                                 .font(
                                     .system(size: 14))
                             if isBustedPlayer1 {
                                 Text("- BUST")
                                     .fontWeight(.bold)
                                     .foregroundColor(.red)
                                     .glowBorder(color: .black, lineWidth: 2)
                             }
                         }
                         
                         Button(action: {
                             print("--------------------------------------------")
                             print("BUTTON enterThrowScore PLAYER 1")
                             enterThrowScore = true
                             isUndoDisabled = false
                         }) {
                             Text("\(totalScorePlayer1)")
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
                            Text("-  Average Score: \(calculateAverageThrowsScore(scores: player2ThrowsScores))")
                                .font(
                                    .system(size: 14))
                            if isBustedPlayer2 {
                                Text("- BUST")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .glowBorder(color: .black, lineWidth: 2)
                            }
                        }
                        
                        Button(action: {
                            print("--------------------------------------------")
                            print("BUTTON enterThrowScore PLAYER 2")
                            enterThrowScore = true
                            isUndoDisabled = false
                        }) {
                            Text("\(totalScorePlayer2)")
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
                                Text("-  Average Score: \(calculateAverageThrowsScore(scores: player3ThrowsScores))")
                                    .font(
                                        .system(size: 14))
                                if isBustedPlayer3 {
                                    Text("- BUST")
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .glowBorder(color: .black, lineWidth: 2)
                                }
                            }
                            
                            Button(action: {
                                print("--------------------------------------------")
                                print("BUTTON enterThrowScore PLAYER 3")
                                enterThrowScore = true
                                isUndoDisabled = false
                            }) {
                                Text("\(totalScorePlayer3)")
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
            .sheet(isPresented: $enterThrowScore) {
                enterThrowScoreView(playerName: currentPlayerName, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3, throwsPlayer1: $throwsPlayer1, throwsPlayer2: $throwsPlayer2, throwsPlayer3: $throwsPlayer3, player1ThrowsScores: $player1ThrowsScores, player2ThrowsScores: $player2ThrowsScores, player3ThrowsScores: $player3ThrowsScores) { enteredThrowScore in

                    var newScore = 0
                    
                    saveTotalScoresHistory()
                    
                    switch currentPlayerName {
                        
                    case namePlayer1:
                        
                        let tempScore = totalScorePlayer1 - (Int(enteredThrowScore) ?? 0)
                        
                        if tempScore < 0 {
                            
                            isBustedPlayer1 = true

                            print("--------------------------------------------")
                            print("Current Player: \(currentPlayerName) < 0")
                            
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]

                            print("Next player: \(currentPlayerName).")
                            print("Switching Player. Done ?")
                            print("DONE")
                            print("Current Player: \(currentPlayerName)")

                            return
                            
                        } else {
                            
                            isBustedPlayer1 = false
                            
                            print("--------------------------------------------")
                            print("Current Player: \(currentPlayerName)")

                            throwsScoresHistory.player1.append(totalScorePlayer1 - tempScore)
                            totalScorePlayer1 = tempScore
                            newScore = tempScore
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]

                            print("Next player: \(currentPlayerName).")
                            print("Switching Player. Done ?")
                            print("DONE")
                            print("Current Player: \(currentPlayerName)")

                        }
                        
                    case namePlayer2:
                        
                        let tempScore = totalScorePlayer2 - (Int(enteredThrowScore) ?? 0)
                        
                        if tempScore < 0 {

                            isBustedPlayer2 = true

                            print("--------------------------------------------")
                            print("Current Player: \(currentPlayerName) < 0")

                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]

                            print("Next player: \(currentPlayerName).")
                            print("Switching Player. Done ?")
                            print("DONE")
                            print("Current Player: \(currentPlayerName)")
                            
                            return
                            
                        } else {
                            
                            isBustedPlayer2 = false

                            print("--------------------------------------------")
                            print("Current Player: \(currentPlayerName)")

                            throwsScoresHistory.player2.append(totalScorePlayer2 - tempScore)
                            totalScorePlayer2 = tempScore
                            newScore = tempScore
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]

                            print("Next player: \(currentPlayerName).")
                            print("Switching Player. Done ?")
                            print("DONE")
                            print("Current Player: \(currentPlayerName)")

                        }
                        
                    case namePlayer3:
                        
                        let tempScore = totalScorePlayer3 - (Int(enteredThrowScore) ?? 0)
                        
                        if tempScore < 0 {
                            
                            isBustedPlayer3 = true

                            print("--------------------------------------------")
                            print("Current Player: \(currentPlayerName) < 0")
                            
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]

                            print("Next player: \(currentPlayerName).")
                            print("Switching Player. Done ?")
                            print("DONE")
                            print("Current Player: \(currentPlayerName)")
                            
                            return
                            
                        } else {
                            
                            isBustedPlayer3 = false

                            print("--------------------------------------------")
                            print("Current Player: \(currentPlayerName)")

                            throwsScoresHistory.player3.append(totalScorePlayer3 - tempScore)
                            totalScorePlayer3 = tempScore
                            newScore = tempScore
                            currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
                            currentPlayerName = playerNames[currentPlayerIndex]

                            print("Next player: \(currentPlayerName).")
                            print("Switching Player. Done ?")
                            print("DONE")
                            print("Current Player: \(currentPlayerName)")

                        }
                        
                    default:
                        
                        print("--------------------------------------------")
                        print("switch currentPlayerName: BREAK")
                        
                        break
                    }
                    
                    if newScore == 0 {
                        
                        print("--------------------------------------------")
                        print("newScore == 0")
                        
                        enterThrowScore = false
                        isGameOver = true
                        saveThrowsScoresHistory()
                        gameCount += 1
                        
                        print("enterThrowScore: \(enterThrowScore)")
                        print("isGameOver: \(isGameOver)")
                        print("gameCount + 1: next game = GAME \(gameCount)")
                        print("Current Player: \(currentPlayerName)")

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
            WinnerView(isThreeHundredOne: isThreeHundredOne, isFiveHundredOne: isFiveHundredOne, throwsScoresHistories: $throwsScoresHistories, totalScorePlayer1: $totalScorePlayer1, totalScorePlayer2: $totalScorePlayer2, totalScorePlayer3: $totalScorePlayer3, player1ThrowsScores: $player1ThrowsScores, player2ThrowsScores: $player2ThrowsScores, player3ThrowsScores: $player3ThrowsScores, currentPlayerIndex: $currentPlayerIndex, winnerName: currentPlayerName, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3, newGameResetClosure: { self.newGameReset() })
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
                    totalScorePlayer1 = 301
                    totalScorePlayer2 = 301
                    totalScorePlayer3 = 301
                } else {
                    totalScorePlayer1 = 501
                    totalScorePlayer2 = 501
                    totalScorePlayer3 = 501
                }
                
            }
        }
        
    }

    
    // FUNCTIONS ///////////////////
    
    
    private func undoLastScore() {
        print("func undoLastScore. Done?")
        
        let previousPlayerIndex = (currentPlayerIndex - 1 + playerNames.count) % playerNames.count
        
        print("Current Player: \(currentPlayerName)")
        print("Previous Player: \(playerNames[previousPlayerIndex])")

        switch playerNames[previousPlayerIndex] {
            
        case namePlayer1:
            
            let lastIndex = player1TotalScores.count - 1
            let lastScore = player1TotalScores[lastIndex]
            
            if let lastThrewScore = throwsScoresHistory.player1.last {
                
                currentPlayerIndex = previousPlayerIndex
                throwsScoresHistory.player1.removeLast()
                throwsPlayer1 -= 1
                isBustedPlayer1 = false

                if totalScorePlayer1 != lastScore {
                    totalScorePlayer1 += lastThrewScore
                }

                if !player1ThrowsScores.isEmpty {
                    player1ThrowsScores.removeLast()
                }
                
            }

        case namePlayer2:
        
            let lastIndex = player2TotalScores.count - 1
            let lastScore = player2TotalScores[lastIndex]
            
            if let lastThrewScore = throwsScoresHistory.player2.last {
                
                currentPlayerIndex = previousPlayerIndex
                throwsScoresHistory.player2.removeLast()
                throwsPlayer2 -= 1
                isBustedPlayer2 = false

                if totalScorePlayer2 != lastScore {
                    totalScorePlayer2 += lastThrewScore
                }

                if !player2ThrowsScores.isEmpty {
                    player2ThrowsScores.removeLast()
                }
                
            }

        case namePlayer3:
            
            let lastIndex = player3TotalScores.count - 1
            let lastScore = player3TotalScores[lastIndex]

            if let lastThrewScore = throwsScoresHistory.player3.last {
                
                currentPlayerIndex = previousPlayerIndex
                throwsScoresHistory.player3.removeLast()
                throwsPlayer3 -= 1
                isBustedPlayer3 = false

                if totalScorePlayer3 != lastScore {
                    totalScorePlayer3 += lastThrewScore
                }

                if !player3ThrowsScores.isEmpty {
                    player3ThrowsScores.removeLast()
                }
                
            }

        default:
            break
        }
        
        currentPlayerName = playerNames[currentPlayerIndex]
        isUndoDisabled = true
        
        print("DONE")
        
    }


    
    private func saveThrowsScoresHistory() {
        
        print("--------------------------------------------")
        print("func saveThrowsScoresHistory. Done?")
        
        // Déterminer le gagnant
        var winner = ""
        if totalScorePlayer1 == 0 {
            winner = namePlayer1
        } else if totalScorePlayer2 == 0 {
            winner = namePlayer2
        } else if totalScorePlayer3 == 0 {
            winner = namePlayer3
        }
        
        // Ajouter les scores et le gagnant à l'historique
        var history = throwsScoresHistory
        history.winner = winner
        throwsScoresHistories.append(history)
        
        // Réinitialiser l'historique des scores
        throwsScoresHistory = ThrowsScoresHistory()
        
        print("DONE")

    }
    
    
    private func saveTotalScoresHistory() {
        print("--------------------------------------------")
        print("func saveTotalScoresHistory. Done?")
        
        switch currentPlayerName {
        case namePlayer1:
            player1TotalScores.append(totalScorePlayer1)
        case namePlayer2:
            player2TotalScores.append(totalScorePlayer2)
        case namePlayer3:
            player3TotalScores.append(totalScorePlayer3)
        default:
            break
        }
        
        print("DONE")
        
        print("--------------------------------------------")
        print("isBustedPlayer1: \(isBustedPlayer1)")
        print("isBustedPlayer2: \(isBustedPlayer2)")
        print("isBustedPlayer3: \(isBustedPlayer3)")
    
    }


    private func newGameReset() {
        
        print("--------------------------------------------")
        print("func newGameReset. Done?")
        
        throwsPlayer1 = 1
        throwsPlayer2 = 1
        throwsPlayer3 = 1
        player1ThrowsScores = []
        player2ThrowsScores = []
        player3ThrowsScores = []
        isBustedPlayer1 = false
        isBustedPlayer2 = false
        isBustedPlayer3 = false
        
        print("DONE")

    }
    
    func calculateAverageThrowsScore(scores: [Int]) -> Int {
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

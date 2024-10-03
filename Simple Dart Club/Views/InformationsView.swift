//
//  InformationsView.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct InformationsView: View {
       
    @ObservedObject var viewModel: GameViewModel
    @State private var counter = 0
    @State private var isGameStarted = false
    @State private var isDismissForbidden = false
    @State private var showCreditView = false
    @State private var isToggled: Bool = false
    @Binding var navigateToFirstView: Bool

    @Environment(\.dismiss) var dismiss
    
    private var winningPlayer: Player? {
            viewModel.currentGame.players.first(where: { $0.remainingScore == 0 })
        }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    winningView
                    Divider()
                    currentGameView
                    
                    if !viewModel.gameHistory.isEmpty {
                        Divider()
                        gameHistoryView
                        Divider()
                        victoriesView
                    }
                    
                    Button(action: {
                        showCreditView = true
                    }) {
                        Label {
                            Text("Game rules")
                        } icon: {
                            Image(systemName: "info.bubble")
                                .font(.system(size: 22))  // Agrandir uniquement l'image
                        }
                    }
                    .sheet(isPresented: $showCreditView) {
                        CreditView()
                    }
                    .padding(.top, 15)
                    .accessibilityLabel("Game rules")
                    
                    Button(action: {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            navigateToFirstView = true
                        }
                    }) {
                        Label {
                            Text("Return to Home screen")
                        } icon: {
                            Image(systemName: "arrowshape.turn.up.backward")
                                .font(.system(size: 22))  // Agrandir uniquement l'image
                        }
                    }
                    .padding(.bottom, 35)
                    .accessibilityLabel("Return to Home screen")
                    
                }
                .padding()
                .frame(maxWidth: 700)
            }
            .navigationBarBackButtonHidden(true)
            .interactiveDismissDisabled(isDismissForbidden)
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.primary)
            .toolbar {
                if winningPlayer == nil {
                    
                    ToolbarItem(placement: .principal) {
                        Text("ScoreBoard")
                            .font(.largeTitle.bold())
                            .accessibilityAddTraits(.isHeader)
                            .padding(.top, 15)
                            .padding(.bottom, 5)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var winningView: some View {
        Group {
            if let winningPlayer = winningPlayer {
                VStack {
                    Text("🥇")
                        .padding([.bottom], 10)
                        .padding([.top], 50)
                        .font(.system(size: 130))
                    
                    Text(winningPlayer.name)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("You won!")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                        .padding(.bottom, 25)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                self.counter = 1
                            }
                            isDismissForbidden = true
                        }
                    
                    Button("New game") {
                        viewModel.endGame()
                        isGameStarted = true
                        isDismissForbidden = false
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.bottom, 25)
                    .foregroundColor(.white)
                    .confettiCannon(counter: $counter, num: 150, radius: 500.0)
                }
            }
        }
    }
    
    private var currentGameView: some View {
        
        VStack(alignment: .center, spacing: 20) {
                
            Text("CURRENT GAME")
                .font(.title2)
                .padding(.top, 15)
            
            if viewModel.currentGame.isToggledDoubleOut {
                Text("-- Double Out--")
                    .foregroundColor(.blue)
            }
            
            ForEach(viewModel.currentGame.players.indices, id: \.self) { playerIndex in
                let player = viewModel.currentGame.players[playerIndex]
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.blue.opacity(0.2))
                        .padding(.horizontal)
                                            
                        VStack(alignment: .center, spacing: 8) {
                            
                            Text(player.name)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Divider()
                            
                            if player.scores.isEmpty {
                                 Text("No score yet")
                                     .fontWeight(.semibold)
                                     .padding()
                            } else {
                                
                                ForEach(player.scores.indices, id: \.self) { turnIndex in
                                    let turnScores = player.scores[turnIndex]
                                    let turnSum = turnScores.reduce(0, +)
                                    let totalRemainingScore = player.remainingScoresPerTurn[turnIndex]
                                    
                                    HStack {
                                        
                                        Spacer()

                                        Text("Turn \(turnIndex + 1)")
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        Divider()
                                        Spacer()

                                        Text("\(turnScores.map(String.init).joined(separator: "    |     "))")
                                        
                                        Spacer()
                                        Divider()
                                        Spacer()

                                        Text("(\(turnSum))")
                                            .fontWeight(.bold)
                                        
                                        Spacer()

                                        }
                                    HStack {
                                        if turnIndex > 0 && player.remainingScoresPerTurn[turnIndex] == player.remainingScoresPerTurn[turnIndex - 1] && turnSum != 0 {
                                            Text("BUST")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                                .foregroundColor(.red)
                                            Text("-  Remaining Score: \(totalRemainingScore)  -")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                            Text("BUST")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                                .foregroundColor(.red)
                                        } else {
                                            Text("Remaining Score: \(totalRemainingScore)")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                        }
                                    }
                                    
                                    Divider()
  
                                }
                                
                                Divider()
                                
                                Text("Average Throw Score: \(viewModel.averageThrowScore(forPlayer: playerIndex))")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                
                            }
                        }
                        .padding()
                }
            }
        }
        
    }
    
    private var gameHistoryView: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
        Text("HISTORY")
            .font(.title2)
            .padding(.top, 15)
            
            ForEach(viewModel.gameHistory, id: \.gameNumber) { record in
                    
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.green.opacity(0.2))
                        .padding(.horizontal)
                        
                    VStack(alignment: .center, spacing: 8) {
                        
                        Text("Game \(record.gameNumber)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 15)
                        
                        Spacer()
                        
                        if let winner = record.winners.first {
                            Text("🎉 \(winner.name) won! 🥇")
                                .fontWeight(.bold)
                        }
                        
                        ForEach(record.finalScores, id: \.name) { player in
                            
                            VStack(alignment: .center) {
                                
                                Divider()

                                Text(player.name)
                                    .fontWeight(.bold)
                                
                                Divider()
                                
                                ForEach(player.scores.indices, id: \.self) { turnIndex in
                                    let turn = player.scores[turnIndex]
                                    let turnScores = player.scores[turnIndex]
                                    let turnSum = turnScores.reduce(0, +)
                                    let totalRemainingScore = player.remainingScoresPerTurn[turnIndex]

                                    HStack {
                                        
                                        Spacer()
                                        
                                        Text("Turn \(turnIndex + 1)")
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        Divider()
                                        Spacer()

                                        Text("\(turn.map(String.init).joined(separator: "    |    "))")
                                        
                                        Spacer()
                                        Divider()
                                        Spacer()
                                        
                                        Text("(\(turnSum))")
                                            .fontWeight(.bold)
                                        
                                        Spacer()

                                    }
                                    HStack {
                                        if turnIndex > 0 && player.remainingScoresPerTurn[turnIndex] == player.remainingScoresPerTurn[turnIndex - 1] {
                                            Text("BUST")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                                .foregroundColor(.red)
                                            Text("-  Remaining Score: \(totalRemainingScore)  -")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                            Text("BUST")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                                .foregroundColor(.red)
                                        } else {
                                            Text("Remaining Score: \(totalRemainingScore)")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 14))
                                        }
                                    }
                                    Divider()
                                    
                                }
                                
                                Divider()
                                
                                Text("Average Throw Score: \(viewModel.averageThrowScoreInGame(forPlayer: player, gameRecord: record))")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                
                                Divider()

                            }
                            .padding()
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    private var victoriesView: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.yellow.opacity(0.2))
                    .padding(.horizontal)

                VStack {
                    
                    Text("🏆 VICTORIES 🏆")
                        .font(.title2)
                        .padding(.top, 15)

                    VStack(alignment: .center, spacing: 8) {
                        
                        ForEach(Array(viewModel.countVictories().keys), id: \.self) { playerName in
                            
                            Divider()
                            
                            HStack {
                                
                                Spacer()
                                
                                Text(playerName)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                Divider()
                                Spacer()
                                
                                Text("\(viewModel.countVictories()[playerName, default: 0])")
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
            }
            
        }

    }

}


// ///////////////////////////
// PREVIEW //////////////////

extension Player {
    static var demoPlayers: [Player] {
        [
            Player(name: "Alice",
                   scores: [[10, 20, 30], [5, 15, 25]],
                   remainingScore: 130,
                   remainingScoresPerTurn: [140, 130],
                   isBusted: false),
            Player(name: "Bob",
                   scores: [[20, 10, 15], [10, 15, 20]],
                   remainingScore: 140,
                   remainingScoresPerTurn: [155, 140],
                   isBusted: false)
        ]
    }
}

extension GameRecord {
    static var demoHistory: [GameRecord] {
        [
            GameRecord(gameNumber: 1, finalScores: [
                Player(name: "Alice", scores: [[10, 20, 30], [5, 15, 25]], remainingScore: 130, remainingScoresPerTurn: [140, 130], isBusted: false),
                Player(name: "Bob", scores: [[20, 10, 15], [10, 15, 20]], remainingScore: 140, remainingScoresPerTurn: [155, 140], isBusted: false)
            ], winners: [Player.demoPlayers[1]]), // Bob comme gagnant pour le jeu 1
            GameRecord(gameNumber: 2, finalScores: [
                Player(name: "Alice", scores: [[10, 20, 30], [5, 15, 25]], remainingScore: 130, remainingScoresPerTurn: [140, 130], isBusted: false),
                Player(name: "Bob", scores: [[20, 10, 15], [10, 15, 20]], remainingScore: 140, remainingScoresPerTurn: [155, 140], isBusted: false)
            ], winners: [Player.demoPlayers[0]])  // Alice comme gagnante pour le jeu 2
        ]
    }
}

class MockGameViewModel: GameViewModel {
    override init(gameType: Int) {
        super.init(gameType: 301) // Initialiser avec un score standard de 301 pour les jeux de fléchettes
        self.currentGame = Game(players: Player.demoPlayers, gameType: 301)
        self.gameHistory = GameRecord.demoHistory
        self.currentGame.isToggledDoubleOut = true
    }
}

struct English: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InformationsView(viewModel: MockGameViewModel(gameType: 301), navigateToFirstView: .constant(false))
                .environment(\.locale, Locale(identifier: "en"))
        }
    }
}

struct French: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InformationsView(viewModel: MockGameViewModel(gameType: 301), navigateToFirstView: .constant(false))
                .environment(\.locale, Locale(identifier: "fr"))
        }
    }
}

struct Spanish: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InformationsView(viewModel: MockGameViewModel(gameType: 301), navigateToFirstView: .constant(false))
                .environment(\.locale, Locale(identifier: "es"))
        }
    }
}

struct German: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InformationsView(viewModel: MockGameViewModel(gameType: 301), navigateToFirstView: .constant(false))
                .environment(\.locale, Locale(identifier: "de"))
        }
    }
}

struct Chinese: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InformationsView(viewModel: MockGameViewModel(gameType: 301), navigateToFirstView: .constant(false))
                .environment(\.locale, Locale(identifier: "zh-Hans"))
        }
    }
}

struct Japanese: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InformationsView(viewModel: MockGameViewModel(gameType: 301), navigateToFirstView: .constant(false))
                .environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

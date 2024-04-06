//
//  WinnerView.swift
//  DartClub
//
//  Created by Antoine on 29/03/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct WinnerView: View {
    
    @State private var counter = 0
    @State private var isGameStarted = false
    @State private var showCreditView = false
    
    @Binding var scoreHistories: [GameView.ScoreHistory]
    
    @Binding var scorePlayer1: Int
    @Binding var scorePlayer2: Int
    @Binding var scorePlayer3: Int
    
    @Binding var player1Scores: [Int]
    @Binding var player2Scores: [Int]
    @Binding var player3Scores: [Int]
    
    
    var player1Wins: Int {
        scoreHistories.filter { $0.winner == namePlayer1 }.count
    }
        
    var player2Wins: Int {
        scoreHistories.filter { $0.winner == namePlayer2 }.count
    }
        
    var player3Wins: Int {
        scoreHistories.filter { $0.winner == namePlayer3 }.count
    }
    
    @Binding var currentPlayerIndex: Int

    var winnerName: String
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    var newGameResetClosure: (() -> Void)?

    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack {
                    
                    Text("0")
                        .padding([.bottom], 10)
                        .font(.system(size: 140, weight: .bold, design: .default))
                    
                    Text(winnerName)
                        .padding([.bottom], 10)
                        .font(.system(size: 30, weight: .bold, design: .default))
                    
                    Text("You won!")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(.blue)
                        .confettiCannon(counter: $counter, num: 150, radius: 500.0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                self.counter = 1
                            }
                        }
                    
                }
                
                Button("New game") {
                    newGame()
                    isGameStarted = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.bottom, 25)
                .navigationDestination(isPresented: $isGameStarted) {
                    GameView(namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
                }
                
                // Premier tableau
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.blue.opacity(0.2))
                        .padding(.horizontal)
                    
                    VStack {
                        
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                
                                Text("")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                
                                Text("\(namePlayer1)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 15)
                                
                                Spacer()
                                
                                Text("\(namePlayer2)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom, 15)
                                
                                if !player3Scores.isEmpty {
                                    
                                    Spacer()
                                    
                                    Text("\(namePlayer3)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 17))
                                        .frame(maxWidth: .infinity)
                                        .padding(.bottom, 15)
                                    
                                }
                            }
                            .padding(.horizontal)
                            
                            ForEach(0..<max(player1Scores.count, player2Scores.count, player3Scores.count), id: \.self) { index in
                                
                                Divider()
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("Turn \(index + 1)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 15))
                                        .frame(maxWidth: .infinity)
                                    
                                    Spacer()
                                    Divider()
                                    
                                    Text("\(index < player1Scores.count ? "\(player1Scores[index])" : "-")")
                                        .frame(maxWidth: .infinity)
                                        .font(.system(size: 17))
                                    
                                    Spacer()
                                    Divider()
                                    
                                    Text("\(index < player2Scores.count ? "\(player2Scores[index])" : "-")")
                                        .frame(maxWidth: .infinity)
                                        .font(.system(size: 17))
                                    
                                    if !player3Scores.isEmpty {
                                        
                                        Spacer()
                                        Divider()
                                        
                                        Text("\(index < player3Scores.count ? "\(player3Scores[index])" : "-")")
                                            .frame(maxWidth: .infinity)
                                            .font(.system(size: 17))
                                    }
                                }
                                .padding(.horizontal)
                                
                                Divider()
                                
                            }
                            
                            Divider()
                            
                            HStack {
                                
                                Spacer()
                                
                                Text("Score")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                
                                Spacer()
                                Divider()
                                
                                Text("\(scorePlayer1)")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                
                                Spacer()
                                Divider()
                                
                                Text("\(scorePlayer2)")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                
                                if !namePlayer3.isEmpty {
                                    
                                    Spacer()
                                    Divider()
                                    
                                    Text("\(scorePlayer3)")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                            Divider()
                            Divider()
                            
                            Text("Average Scores")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            Divider()
                            
                            HStack {
                                
                                Spacer()
                                
                                Text("\(namePlayer1)")
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity)
                                
                                Spacer()
                                Divider()
                                
                                Text("\(calculateAverageScore(scores: player1Scores))")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 14))
                                
                                Spacer()
                            }
                            
                            Divider()
                            
                            HStack {
                                
                                Spacer()
                                
                                Text("\(namePlayer2)")
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity)
                                
                                Spacer()
                                Divider()
                                
                                Text("\(calculateAverageScore(scores: player2Scores))")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 14))
                                
                                Spacer()
                                
                            }
                            
                            Divider()
                            
                            if !player3Scores.isEmpty {
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("\(namePlayer3)")
                                        .font(.system(size: 14))
                                        .frame(maxWidth: .infinity)
                                    
                                    Spacer()
                                    Divider()
                                    
                                    Text("\(calculateAverageScore(scores: player3Scores))")
                                        .frame(maxWidth: .infinity)
                                        .font(.system(size: 14))
                                    
                                    Spacer()
                                    
                                }
                                Divider()
                            }
                        }
                    }.padding()
                }
                
//                if !scoreHistories.isEmpty {
                    
                    Section {
                        
                        // Deuxième tableau
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.green.opacity(0.2))
                                .padding(.horizontal)
                            
                            VStack {
                                
                                ForEach(scoreHistories.indices, id: \.self) { index in
                                    let history = scoreHistories[index]
                                    if !history.winner.isEmpty {
                                        
                                        VStack {
                                            
                                            Text("GAME \(index + 1)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))

                                            Spacer()
                                            
                                            Text("🎉 \(history.winner) won! 🥇")
                                                .fontWeight(.bold)
                                            
                                            Divider()
                                            Spacer()
                                            
                                            Spacer()
                                            
                                            HStack {
                                                Text("")
                                                    .fontWeight(.bold)
                                                    .frame(maxWidth: .infinity)
                                                
                                                Text("\(namePlayer1)")
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 17))
                                                    .frame(maxWidth: .infinity)
                                                    .padding(.bottom, 15)
                                                
                                                Spacer()
                                                
                                                Text("\(namePlayer2)")
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 17))
                                                    .frame(maxWidth: .infinity)
                                                    .padding(.bottom, 15)
                                                
                                                Spacer()
                                                
                                                if !history.player3.isEmpty {
                                                    Text("\(namePlayer3)")
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 17))
                                                        .frame(maxWidth: .infinity)
                                                        .padding(.bottom, 15)
                                                    
                                                    Spacer()
                                                }
                                            }
                                            .padding(.horizontal)
                                            
                                            ForEach(0..<max(history.player1.count, history.player2.count, history.player3.count), id: \.self) { index in
                                                
                                                Divider()
                                                
                                                HStack {
                                                    
                                                    Text("Turn \(index + 1)")
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 15))
                                                        .frame(maxWidth: .infinity)
                                                    
                                                    Spacer()
                                                    Divider()
                                                    
                                                    Text("\(index < history.player1.count ? "\(history.player1[index])" : "-")")
                                                        .frame(maxWidth: .infinity)
                                                        .font(.system(size: 17))
                                                    
                                                    Spacer()
                                                    Divider()
                                                    
                                                    Text("\(index < history.player2.count ? "\(history.player2[index])" : "-")")
                                                        .frame(maxWidth: .infinity)
                                                        .font(.system(size: 17))
                                                    
                                                    Spacer()
                                                    Divider()
                                                    
                                                    if !history.player3.isEmpty {
                                                        Text("\(index < history.player3.count ? "\(history.player3[index])" : "-")")
                                                            .frame(maxWidth: .infinity)
                                                            .font(.system(size: 17))
                                                        
                                                        Spacer()
                                                    }
                                                }
                                                .padding(.horizontal)
                                                
                                                Divider()
                                            }
                                            
                                            Text("Average Scores")
                                                .frame(maxWidth: .infinity)
                                                .font(.system(size: 14))
                                                .fontWeight(.bold)
                                            
                                            Divider()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                Text("\(namePlayer1)")
                                                    .font(.system(size: 14))
                                                    .frame(maxWidth: .infinity)
                                                
                                                Spacer()
                                                Divider()
                                                
                                                Text("\(calculateAverageScore(scores: history.player1))")
                                                    .frame(maxWidth: .infinity)
                                                    .font(.system(size: 14))
                                                
                                                Spacer()
                                            }
                                            
                                            Divider()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                Text("\(namePlayer2)")
                                                    .font(.system(size: 14))
                                                    .frame(maxWidth: .infinity)
                                                
                                                Spacer()
                                                Divider()
                                                
                                                Text("\(calculateAverageScore(scores: history.player2))")
                                                    .frame(maxWidth: .infinity)
                                                    .font(.system(size: 14))
                                                
                                                Spacer()
                                                
                                            }
                                            
                                            Divider()
                                            
                                            if !history.player3.isEmpty {
                                                
                                                HStack {
                                                    
                                                    Spacer()
                                                    
                                                    Text("\(namePlayer3)")
                                                        .font(.system(size: 14))
                                                        .frame(maxWidth: .infinity)
                                                    
                                                    Spacer()
                                                    Divider()
                                                    
                                                    Text("\(calculateAverageScore(scores: history.player3))")
                                                        .frame(maxWidth: .infinity)
                                                        .font(.system(size: 14))
                                                    
                                                    Spacer()
                                                    
                                                }
                                                Divider()
                                            }
                                            
                                        }
                                        .padding()
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                    } header: {
                        Text("History")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                    }
                    
//                }
                
                // Troisième tableau
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.yellow.opacity(0.2))
                        .padding(.horizontal)
                    
                    VStack {
                        
                        Text("🎉 TOTAL WINS 🥇")
                            .font(.headline)
                            .padding(.top, 15)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Divider()
                            
                            HStack {
                                
                                Spacer()
                                
                                Text("\(namePlayer1)")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)

                                Spacer()
                                Divider()

                                Text("\(player1Wins)")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)

                                Spacer()
                                
                            }
                            
                            Divider()
                            
                            HStack {
                                
                                Spacer()
                                
                                Text("\(namePlayer2)")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)

                                Spacer()
                                Divider()

                                Text("\(player2Wins)")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)

                                Spacer()
                            }
                            
                            Divider()
                            
                            if !namePlayer3.isEmpty {
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("\(namePlayer3)")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)

                                    Spacer()
                                    Divider()

                                    Text("\(player3Wins)")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)

                                    Spacer()
                                    
                                }
                                
                            }
                        }
                        .padding()
                    }
                }
                
                Image(systemName: "info.bubble")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        showCreditView = true
                    }
                    .padding()
                    .sheet(isPresented: $showCreditView) {
                        CreditView()
                    }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    
    // FUNCTIONS ///////////////////
    
    func calculateAverageScore(scores: [Int]) -> Int {
      guard !scores.isEmpty else { return 0 }
      let sum = scores.reduce(0, +)
      return Int(round(Double(sum) / Double(scores.count)))
    }

    private func newGame() {
        
        print("--------------------------------------------")
        print("func newGame. Done?")
        
        scorePlayer1 = 501
        scorePlayer2 = 501
        scorePlayer3 = 501

        print("DONE")
        
        newGameResetClosure?()

    }

}

// PREVIEWS ///////////////////

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let scoreHistories1: [GameView.ScoreHistory] = [
            GameView.ScoreHistory(player1: [5, 57, 25, 65, 89, 45, 78], player2: [45, 36, 75, 29, 27, 65, 25], player3: [14, 28, 35, 45, 20, 18], winner: "Bob"),
            GameView.ScoreHistory(player1: [15, 5, 2, 25, 29, 35, 8], player2: [25, 6, 15, 19, 37, 62], player3: [4, 18, 31, 15, 29, 17], winner: "Alice")
        ]

        WinnerView(scoreHistories: .constant(scoreHistories1),
                   scorePlayer1: .constant(369),
                   scorePlayer2: .constant(250),
                   scorePlayer3: .constant(0),
                   player1Scores: .constant([10, 55, 35, 15]),
                   player2Scores: .constant([25, 41, 17]),
                   player3Scores: .constant([54, 22, 14]),
                   currentPlayerIndex: .constant(0),
                   winnerName: "Alice",
                   namePlayer1: "Alice",
                   namePlayer2: "Charlie",
                   namePlayer3: "Bob")
    }
}

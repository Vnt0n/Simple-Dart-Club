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
    
    @Binding var scorePlayer1: Int
    @Binding var scorePlayer2: Int
    @Binding var scorePlayer3: Int
    
    @Binding var player1Scores: [Int]
    @Binding var player2Scores: [Int]
    @Binding var player3Scores: [Int]
    
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
                                
                                Text("TOTAL")
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

import SwiftUI

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(scorePlayer1: .constant(250),
                   scorePlayer2: .constant(120),
                   scorePlayer3: .constant(0),
                   player1Scores: .constant([10, 55, 35, 15]),
                   player2Scores: .constant([25, 41, 17]),
                   player3Scores: .constant([54, 22, 14]),
                   currentPlayerIndex: .constant(0),
                   winnerName: "Charlie",
                   namePlayer1: "Alice",
                   namePlayer2: "Bob",
                   namePlayer3: "Charlie")
    }
}


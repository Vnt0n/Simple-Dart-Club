//
//  InformationsView.swift
//  DartClub
//
//  Created by Antoine on 03/04/2024.
//

import SwiftUI

struct InformationsView: View {
    
    @Binding var scoreHistories: [GameView.ScoreHistory]
    
    @Binding var player1Scores: [Int]
    @Binding var player2Scores: [Int]
    @Binding var player3Scores: [Int]
    
    var scorePlayer1: Int
    var scorePlayer2: Int
    var scorePlayer3: Int
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    @State private var winners: [String] = []
    
    var body: some View {
        VStack {
            
            Text("Score Histories")
                .font(.title)
                .padding()
            
            ScrollView {
                
                VStack {
                    
                    // Premier tableau
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue.opacity(0.2))
                            .padding(.horizontal)
                        
                        VStack {
                            if !player1Scores.isEmpty || !player2Scores.isEmpty || !player3Scores.isEmpty {
                                VStack {
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
                                                .font(.system(size: 17))
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
                                }
                                .padding()
                            }
                        }
                    }
                    
                    // Deuxième tableau
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.green.opacity(0.2))
                            .padding(.horizontal)
                        
                        VStack {
                            ForEach(scoreHistories, id: \.self) { history in
                                VStack {

                                    Text("GAME \(scoreHistories.firstIndex(of: history)! + 1)")
                                        .font(.headline)
                                    Text("-")
                                        .padding(.bottom, 15)

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
                                                .font(.system(size: 17))
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
                                }
                                .padding()
                            }
                        }
                        
                    }
                    
                    // Troisième tableau
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.red.opacity(0.2))
                            .padding(.horizontal)
                        
                        VStack {
                            
                            Text("ACTUAL SCORES")
                                .font(.headline)
                                .padding(.top, 15)
                            Text("-")
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Divider()
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("\(namePlayer1)")
                                        .font(.system(size: 17))
                                    
                                    Spacer()
                                    
                                    Text("\(scorePlayer1)")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                }
                                
                                Divider()
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Text("\(namePlayer2)")
                                        .font(.system(size: 17))
                                    
                                    Spacer()
                                    
                                    Text("\(scorePlayer2)")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                
                                if !player3Scores.isEmpty {
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        Text("\(namePlayer3)")
                                            .font(.system(size: 17))
                                        
                                        Spacer()
                                        
                                        Text("\(scorePlayer3)")
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                        
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
        }
    }
}
    
struct InformationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let scoreHistories: [GameView.ScoreHistory] = [
            GameView.ScoreHistory(player1: [5, 57, 25, 65, 89, 45, 78], player2: [45, 36, 75, 29, 27, 65, 25], player3: [14, 28, 35, 45, 20, 18]),
            GameView.ScoreHistory(player1: [15, 5, 2, 25, 29, 35, 8], player2: [25, 6, 15, 19, 37, 62], player3: [4, 18, 31, 15, 29, 17])
        ]
        
        return InformationsView(scoreHistories: .constant(scoreHistories),
                                player1Scores: .constant([10, 55, 35, 15]),
                                player2Scores: .constant([25, 41, 17]),
                                player3Scores: .constant([54, 22, 14]),
                                scorePlayer1: 369,
                                scorePlayer2: 250,
                                scorePlayer3: 150,
                                namePlayer1: "Alice",
                                namePlayer2: "Bob",
                                namePlayer3: "Charlie")
    }
}

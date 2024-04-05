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
                            
                            ForEach(scoreHistories.indices, id: \.self) { index in
                                let history = scoreHistories[index]
                                if !history.winner.isEmpty {
                                    
                                    VStack {
                                        Text("GAME \(index + 1) - Winner: \(history.winner)")
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
        InformationsView(scoreHistories: .constant([]),
                         player1Scores: .constant([]),
                         player2Scores: .constant([]),
                         player3Scores: .constant([]),
                         scorePlayer1: 0,
                         scorePlayer2: 0,
                         scorePlayer3: 0,
                         namePlayer1: "Player 1",
                         namePlayer2: "Player 2",
                         namePlayer3: "Player 3")
    }
}


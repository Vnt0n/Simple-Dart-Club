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
    
    var body: some View {
        VStack {
            
            Text("Score Histories")
                .font(.title)
                .padding()
            
            ScrollView {
            
                VStack {
                    HStack {
                        Text("")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)


                        Text("Player 1")
                            .fontWeight(.bold)
                            .font(.system(size: 13))
                            .frame(maxWidth: .infinity)

                        Text("Player 2")
                            .fontWeight(.bold)
                            .font(.system(size: 13))
                            .frame(maxWidth: .infinity)

                        if !player3Scores.isEmpty {

                            Text("Player 3")
                                .fontWeight(.bold)
                                .font(.system(size: 13))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)

                    ForEach(0..<max(player1Scores.count, player2Scores.count, player3Scores.count), id: \.self) { index in
                        
                        Divider()

                        HStack {
                            
                            Spacer()

                            Text("Turn \(index + 1)")
                                .fontWeight(.bold)
                                .font(.system(size: 13))
                                .frame(maxWidth: .infinity)

                            Divider()

                            Spacer()

                            Text("\(index < player1Scores.count ? "\(player1Scores[index])" : "")")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 14))

                            Divider()

                            Spacer()

                            Text("\(index < player2Scores.count ? "\(player2Scores[index])" : "")")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 14))

                            if !player3Scores.isEmpty {
                                
                                Divider()

                                Spacer()

                                Text("\(index < player3Scores.count ? "\(player3Scores[index])" : "-")")
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black)
                    .padding(.horizontal)
            
                VStack {
                    ForEach(scoreHistories, id: \.self) { history in
                        VStack {
                            Text("GAME \(scoreHistories.firstIndex(of: history)! + 1)")
                                .font(.headline)
                            
                            Text("Player 1: \(history.player1)")
                            Text("Player 2: \(history.player2)")
                            Text("Player 3: \(history.player3)")
                            Text("SCORE CHOISI - \(history.player1[2])")
                        }
                        .padding()
                    }
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                Text("ACTUAL SCORES")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Divider()
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Player 1")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(scorePlayer1)")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                    }
                    Divider()
                    HStack {
                        
                        Spacer()
                        
                        Text("Player 2")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(scorePlayer2)")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Player 3")
                            .font(.system(size: 14))
                        
                        Spacer()
                        
                        Text("\(scorePlayer3)")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                    }
                    
                    Divider()
                }
                .padding()


            }
        }
    }
}


struct InformationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let scoreHistories: [GameView.ScoreHistory] = [
            GameView.ScoreHistory(player1: [5, 57, 25, 65, 89, 45, 78], player2: [45, 36, 75, 29, 27, 65, 25], player3: [14, 28, 35, 45, 20, 18, 43]),
            GameView.ScoreHistory(player1: [120, 220, 320], player2: [130, 230, 330], player3: [160, 240, 340])
        ]
        
        return InformationsView(scoreHistories: .constant(scoreHistories),
                                player1Scores: .constant([10, 55, 35]),
                                player2Scores: .constant([25, 41, 17]),
                                player3Scores: .constant([54, 22, 14]),
                                scorePlayer1: 490,
                                scorePlayer2: 480,
                                scorePlayer3: 470)
    }
}

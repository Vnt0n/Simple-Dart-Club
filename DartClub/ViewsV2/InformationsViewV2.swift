//
//  InformationsView.swift
//  DartClub
//
//  Created by Antoine on 23/04/2024.
//

//import SwiftUI
//import ConfettiSwiftUI
//
//struct InformationsViewV2: View {
//    
//    @State private var counter = 0
//    @State private var isGameStarted = false
//    @State private var showCreditView = false
//    
//    var isThreeHundredOne: Bool
//    var isFiveHundredOne:Bool
//    
//    @State private var numberOfGamesPlayed = 0
//    
//    @Binding var throwsScoresHistories: [GameViewV2.ThrowsScoresHistory]
//    
//    @Binding var player1ThrowsScores: [Int]
//    @Binding var player2ThrowsScores: [Int]
//    @Binding var player3ThrowsScores: [Int]
//    @Binding var player4ThrowsScores: [Int]
//
//    @Binding var totalScorePlayer1: Int
//    @Binding var totalScorePlayer2: Int
//    @Binding var totalScorePlayer3: Int
//    @Binding var totalScorePlayer4: Int
//
//    var namePlayer1: String
//    var namePlayer2: String
//    var namePlayer3: String
//    var namePlayer4: String
//
//    var player1Wins: Int {
//        throwsScoresHistories.filter { $0.winner == namePlayer1 }.count
//    }
//        
//    var player2Wins: Int {
//        throwsScoresHistories.filter { $0.winner == namePlayer2 }.count
//    }
//        
//    var player3Wins: Int {
//        throwsScoresHistories.filter { $0.winner == namePlayer3 }.count
//    }
//    
//    var player4Wins: Int {
//        throwsScoresHistories.filter { $0.winner == namePlayer4 }.count
//    }
//    
//    @Binding var currentPlayerIndex: Int
//
//    var winnerName: String
//    
//    var newGameResetV2Closure: (() -> Void)?
//
//    var body: some View {
//        VStack {
//            
//            VStack {
//                Rectangle()
//                    .fill(Color.white)
//                    .frame(height: 1)
//            }
//            
//            ScrollView {
//                
//                LazyVStack(pinnedViews: .sectionHeaders) {
//                    
//                    Section {
//                        
//                        if !winnerName.isEmpty {
//                            
//                            VStack {
//                                
//                                Text("🥇")
//                                    .padding([.bottom], 10)
//                                    .padding([.top], 50)
//                                    .font(.system(size: 130))
//                                
//                                Text(winnerName)
//                                    .padding([.bottom], 10)
//                                    .font(.system(size: 30, weight: .bold, design: .default))
//                                
//                                Text("You won!")
//                                    .font(.system(size: 50, weight: .bold, design: .default))
//                                    .foregroundColor(.blue)
//                                    .onAppear {
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//                                            self.counter = 1
//                                            
//                                            print("--------------------------------------------")
//                                            print("Winner Name: \(winnerName)")
//                                            
//                                        }
//                                    }
//                                
//                            }
//                            
//                            Button("New game") {
//                                newGameV2()
//                                isGameStarted = true
//                            }
//                            .buttonStyle(.borderedProminent)
//                            .controlSize(.large)
//                            .padding(.bottom, 25)
//                            .navigationDestination(isPresented: $isGameStarted) {
//                                GameViewV2(isThreeHundredOne: isThreeHundredOne, isFiveHundredOne: isFiveHundredOne, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3, namePlayer4: namePlayer4)
//                            }
//                            .confettiCannon(counter: $counter, num: 150, radius: 500.0)
//                            
//                        }
//                        
//                        // Premier tableau
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(Color.blue.opacity(0.2))
//                                .padding(.horizontal)
//                            
//                            VStack {
//                                
//                                Text("CURRENT GAME")
//                                    .fontWeight(.bold)
//                                
//                                Divider()
//                                Spacer()
//                                
//                                if !player1ThrowsScores.isEmpty || !player2ThrowsScores.isEmpty || !player3ThrowsScores.isEmpty || !player4ThrowsScores.isEmpty {
//                                    VStack {
//                                        Spacer()
//
//                                        HStack {
//                                            
//                                            Text("")
//                                                .fontWeight(.bold)
//                                                .frame(maxWidth: .infinity)
//                                            
//                                            Text("\(namePlayer1)")
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 17))
//                                                .frame(maxWidth: .infinity)
//                                                .padding(.bottom, 15)
//                                            
//                                            Spacer()
//                                            
//                                            Text("\(namePlayer2)")
//                                                .fontWeight(.bold)
//                                                .font(.system(size: 17))
//                                                .frame(maxWidth: .infinity)
//                                                .padding(.bottom, 15)
//                                            
//                                            if !namePlayer3.isEmpty {
//                                                
//                                                Spacer()
//                                                
//                                                Text("\(namePlayer3)")
//                                                    .fontWeight(.bold)
//                                                    .font(.system(size: 17))
//                                                    .frame(maxWidth: .infinity)
//                                                    .padding(.bottom, 15)
//                                                
//                                            }
//                                            
//                                            if !namePlayer4.isEmpty {
//                                                
//                                                Spacer()
//                                                
//                                                Text("\(namePlayer4)")
//                                                    .fontWeight(.bold)
//                                                    .font(.system(size: 17))
//                                                    .frame(maxWidth: .infinity)
//                                                    .padding(.bottom, 15)
//                                                
//                                            }
//                                            
//                                        }
//                                        .padding(.horizontal)
//                                        
//                                        ForEach(0..<max(player1ThrowsScores.count, player2ThrowsScores.count, player3ThrowsScores.count, player4ThrowsScores.count), id: \.self) { index in
//                                            
//                                            Divider()
//                                            
//                                            HStack {
//                                                
//                                                Spacer()
//                                                
//                                                Text("Turn \(index + 1)")
//                                                    .fontWeight(.bold)
//                                                    .font(.system(size: 15))
//                                                    .frame(maxWidth: .infinity)
//                                                
//                                                Spacer()
//                                                Divider()
//                                                
//                                                Text("\(index < player1ThrowsScores.count ? "\(player1ThrowsScores[index])" : "-")")
//                                                    .frame(maxWidth: .infinity)
//                                                    .font(.system(size: 17))
//                                                
//                                                Spacer()
//                                                Divider()
//                                                
//                                                Text("\(index < player2ThrowsScores.count ? "\(player2ThrowsScores[index])" : "-")")
//                                                    .frame(maxWidth: .infinity)
//                                                    .font(.system(size: 17))
//                                                
//                                                if !namePlayer3.isEmpty {
//                                                    
//                                                    Spacer()
//                                                    Divider()
//                                                    
//                                                    Text("\(index < player3ThrowsScores.count ? "\(player3ThrowsScores[index])" : "-")")
//                                                        .frame(maxWidth: .infinity)
//                                                        .font(.system(size: 17))
//                                                }
//                                                
//                                                
//                                                if !namePlayer4.isEmpty {
//                                                    
//                                                    Spacer()
//                                                    Divider()
//                                                    
//                                                    Text("\(index < player4ThrowsScores.count ? "\(player4ThrowsScores[index])" : "-")")
//                                                        .frame(maxWidth: .infinity)
//                                                        .font(.system(size: 17))
//                                                }
//
//                                            }
//                                            .padding(.horizontal)
//                                            
//                                            Divider()
//                                            
//                                        }
//                                        
//                                        Divider()
//
//                                        HStack {
//                                            
//                                            Spacer()
//
//                                            Text("Score")
//                                                .font(.system(size: 15))
//                                                .fontWeight(.bold)
//                                                .frame(maxWidth: .infinity)
//                                            
//                                            Spacer()
//                                            Divider()
//                                            
//                                            Text("\(totalScorePlayer1)")
//                                                .font(.system(size: 15))
//                                                .fontWeight(.bold)
//                                                .frame(maxWidth: .infinity)
//                                            
//                                            Spacer()
//                                            Divider()
//                                            
//                                            Text("\(totalScorePlayer2)")
//                                                .font(.system(size: 15))
//                                                .fontWeight(.bold)
//                                                .frame(maxWidth: .infinity)
//                                            
//                                            if !namePlayer3.isEmpty {
//                                                
//                                                Spacer()
//                                                Divider()
//                                                
//                                                Text("\(totalScorePlayer3)")
//                                                    .font(.system(size: 15))
//                                                    .fontWeight(.bold)
//                                                    .frame(maxWidth: .infinity)
//                                                
//                                            }
//                                            
//                                            if !namePlayer4.isEmpty {
//                                                
//                                                Spacer()
//                                                Divider()
//                                                
//                                                Text("\(totalScorePlayer4)")
//                                                    .font(.system(size: 15))
//                                                    .fontWeight(.bold)
//                                                    .frame(maxWidth: .infinity)
//                                                
//                                            }
//                                            
//                                        }
//                                        .padding(.horizontal)
//                                        
//                                        Spacer()
//                                        
//                                        Divider()
//                                        Divider()
//                                        
//                                        Text("Average Throws Score")
//                                            .frame(maxWidth: .infinity)
//                                            .font(.system(size: 14))
//                                            .fontWeight(.bold)
//
//                                        Divider()
//                                        
//                                        HStack {
//                                            
//                                            Spacer()
//
//                                            Text("\(namePlayer1)")
//                                                .font(.system(size: 14))
//                                                .frame(maxWidth: .infinity)
//                                            
//                                            Spacer()
//                                            Divider()
//                                            
//                                            Text("\(calculateAverageThrowsScore(scores: player1ThrowsScores))")
//                                                .frame(maxWidth: .infinity)
//                                                .font(.system(size: 14))
//                                            
//                                            Spacer()
//                                        }
//                                        
//                                        Divider()
//
//                                        HStack {
//                                            
//                                            Spacer()
//
//                                            Text("\(namePlayer2)")
//                                            .font(.system(size: 14))
//                                            .frame(maxWidth: .infinity)
//
//                                            Spacer()
//                                            Divider()
//
//                                            Text("\(calculateAverageThrowsScore(scores: player2ThrowsScores))")
//                                                .frame(maxWidth: .infinity)
//                                                .font(.system(size: 14))
//                                            
//                                            Spacer()
//
//                                        }
//                                        
//                                        if !player3ThrowsScores.isEmpty {
//
//                                            Divider()
//                                            
//                                            HStack {
//                                                         
//                                                Spacer()
//
//                                                Text("\(namePlayer3)")
//                                                    .font(.system(size: 14))
//                                                    .frame(maxWidth: .infinity)
//
//                                                Spacer()
//                                                Divider()
//
//                                                Text("\(calculateAverageThrowsScore(scores: player3ThrowsScores))")
//                                                    .frame(maxWidth: .infinity)
//                                                    .font(.system(size: 14))
//                                                
//                                                Spacer()
//                                                
//                                            }
//                                        }
//                                                                                
//                                        if !player4ThrowsScores.isEmpty {
//
//                                            Divider()
//                                            
//                                            HStack {
//                                                         
//                                                Spacer()
//
//                                                Text("\(namePlayer4)")
//                                                    .font(.system(size: 14))
//                                                    .frame(maxWidth: .infinity)
//
//                                                Spacer()
//                                                Divider()
//
//                                                Text("\(calculateAverageThrowsScore(scores: player4ThrowsScores))")
//                                                    .frame(maxWidth: .infinity)
//                                                    .font(.system(size: 14))
//                                                
//                                                Spacer()
//                                                
//                                            }
//                                        }
//                                    }
//                                }
//                            }.padding()
//                        }
//                        
//                    } header: {
//                        Text("ScoreBoard")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.white)
//                    }
//                    .padding(.bottom, 15)
//                    
//                    if !throwsScoresHistories.isEmpty {
//                        
//                        Section {
//                            
//                            // Deuxième tableau
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .foregroundColor(Color.green.opacity(0.2))
//                                    .padding(.horizontal)
//                                
//                                VStack {
//                                    
//                                    ForEach(throwsScoresHistories.indices, id: \.self) { index in
//                                        let history = throwsScoresHistories[index]
//                                        if !history.winner.isEmpty {
//                                            
//                                            VStack {
//                                                
//                                                Text("GAME \(index + 1)")
//                                                    .fontWeight(.bold)
//                                                    .font(.system(size: 20))
//
//                                                Spacer()
//                                                
//                                                Text("🎉 \(history.winner) won! 🥇")
//                                                    .fontWeight(.bold)
//                                                
//                                                Divider()
//                                                Spacer()
//                                                
//                                                Spacer()
//                                                
//                                                HStack {
//                                                    Text("")
//                                                        .fontWeight(.bold)
//                                                        .frame(maxWidth: .infinity)
//                                                    
//                                                    Text("\(namePlayer1)")
//                                                        .fontWeight(.bold)
//                                                        .font(.system(size: 17))
//                                                        .frame(maxWidth: .infinity)
//                                                        .padding(.bottom, 15)
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text("\(namePlayer2)")
//                                                        .fontWeight(.bold)
//                                                        .font(.system(size: 17))
//                                                        .frame(maxWidth: .infinity)
//                                                        .padding(.bottom, 15)
//                                                    
//                                                    Spacer()
//                                                    
//                                                    if !history.player3.isEmpty {
//                                                        Text("\(namePlayer3)")
//                                                            .fontWeight(.bold)
//                                                            .font(.system(size: 17))
//                                                            .frame(maxWidth: .infinity)
//                                                            .padding(.bottom, 15)
//                                                        
//                                                        Spacer()
//                                                    }
//                                                    
//                                                    Spacer()
//                                                    
//                                                    if !history.player4.isEmpty {
//                                                        Text("\(namePlayer4)")
//                                                            .fontWeight(.bold)
//                                                            .font(.system(size: 17))
//                                                            .frame(maxWidth: .infinity)
//                                                            .padding(.bottom, 15)
//                                                        
//                                                        Spacer()
//                                                        
//                                                    }
//                                                }
//                                                .padding(.horizontal)
//                                                
//                                                ForEach(0..<max(history.player1.count, history.player2.count, history.player3.count, history.player4.count), id: \.self) { index in
//                                                    
//                                                    Divider()
//                                                    
//                                                    HStack {
//                                                        
//                                                        Text("Turn \(index + 1)")
//                                                            .fontWeight(.bold)
//                                                            .font(.system(size: 15))
//                                                            .frame(maxWidth: .infinity)
//                                                        
//                                                        Spacer()
//                                                        Divider()
//                                                        
//                                                        Text("\(index < history.player1.count ? "\(history.player1[index])" : "-")")
//                                                            .frame(maxWidth: .infinity)
//                                                            .font(.system(size: 17))
//                                                        
//                                                        Spacer()
//                                                        Divider()
//                                                        
//                                                        Text("\(index < history.player2.count ? "\(history.player2[index])" : "-")")
//                                                            .frame(maxWidth: .infinity)
//                                                            .font(.system(size: 17))
//                                                        
//                                                        Spacer()
//                                                        Divider()
//                                                        
//                                                        if !history.player3.isEmpty {
//                                                            Text("\(index < history.player3.count ? "\(history.player3[index])" : "-")")
//                                                                .frame(maxWidth: .infinity)
//                                                                .font(.system(size: 17))
//                                                            
//                                                            Spacer()
//                                                            Divider()
//                                                        }
//                                                        
//                                                        if !history.player4.isEmpty {
//                                                            Text("\(index < history.player4.count ? "\(history.player4[index])" : "-")")
//                                                                .frame(maxWidth: .infinity)
//                                                                .font(.system(size: 17))
//                                                                
//                                                            Spacer()
//                                                            
//                                                        }
//                                                    }
//                                                    .padding(.horizontal)
//                                                    
//                                                    Divider()
//                                                }
//                                                
//                                                Text("Average Throws Score")
//                                                    .frame(maxWidth: .infinity)
//                                                    .font(.system(size: 14))
//                                                    .fontWeight(.bold)
//                                                
//                                                Divider()
//                                                
//                                                HStack {
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text("\(namePlayer1)")
//                                                        .font(.system(size: 14))
//                                                        .frame(maxWidth: .infinity)
//                                                    
//                                                    Spacer()
//                                                    Divider()
//                                                    
//                                                    Text("\(calculateAverageThrowsScore(scores: history.player1))")
//                                                        .frame(maxWidth: .infinity)
//                                                        .font(.system(size: 14))
//                                                    
//                                                    Spacer()
//                                                }
//                                                
//                                                Divider()
//                                                
//                                                HStack {
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text("\(namePlayer2)")
//                                                        .font(.system(size: 14))
//                                                        .frame(maxWidth: .infinity)
//                                                    
//                                                    Spacer()
//                                                    Divider()
//                                                    
//                                                    Text("\(calculateAverageThrowsScore(scores: history.player2))")
//                                                        .frame(maxWidth: .infinity)
//                                                        .font(.system(size: 14))
//                                                    
//                                                    Spacer()
//                                                    
//                                                }
//                                                
//                                                Divider()
//                                                
//                                                if !history.player3.isEmpty {
//                                                    
//                                                    HStack {
//                                                        
//                                                        Spacer()
//                                                        
//                                                        Text("\(namePlayer3)")
//                                                            .font(.system(size: 14))
//                                                            .frame(maxWidth: .infinity)
//                                                        
//                                                        Spacer()
//                                                        Divider()
//                                                        
//                                                        Text("\(calculateAverageThrowsScore(scores: history.player3))")
//                                                            .frame(maxWidth: .infinity)
//                                                            .font(.system(size: 14))
//                                                        
//                                                        Spacer()
//                                                        
//                                                    }
//                                                    Divider()
//                                                }
//                                                                                                
//                                                if !history.player4.isEmpty {
//                                                    
//                                                    HStack {
//                                                        
//                                                        Spacer()
//                                                        
//                                                        Text("\(namePlayer4)")
//                                                            .font(.system(size: 14))
//                                                            .frame(maxWidth: .infinity)
//                                                        
//                                                        Spacer()
//                                                        Divider()
//                                                        
//                                                        Text("\(calculateAverageThrowsScore(scores: history.player4))")
//                                                            .frame(maxWidth: .infinity)
//                                                            .font(.system(size: 14))
//                                                        
//                                                        Spacer()
//                                                        
//                                                    }
//                                                    Divider()
//                                                }
//                                            }
//                                            .padding()
//                                            
//                                        }
//                                        
//                                    }
//                                }
//                            }
//                            
//                        } header: {
//                            Text("History")
//                                .font(.title)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.white)
//                        }
//                        
//                    }
//                                        
//                    // Troisième tableau
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundColor(Color.yellow.opacity(0.2))
//                            .padding(.horizontal)
//                        
//                        VStack {
//                            
//                            Text("🎉 VICTORIES 🥇")
//                                .font(.headline)
//                                .padding(.top, 15)
//                            
//                            VStack(alignment: .leading, spacing: 8) {
//                                
//                                Divider()
//                                
//                                HStack {
//                                    
//                                    Spacer()
//                                    
//                                    Text("\(namePlayer1)")
//                                        .font(.system(size: 17))
//                                        .fontWeight(.bold)
//                                        .frame(maxWidth: .infinity)
//
//                                    Spacer()
//                                    Divider()
//
//                                    Text("\(player1Wins)")
//                                        .font(.system(size: 17))
//                                        .fontWeight(.bold)
//                                        .frame(maxWidth: .infinity)
//
//                                    Spacer()
//                                    
//                                }
//                                
//                                Divider()
//                                
//                                HStack {
//                                    
//                                    Spacer()
//                                    
//                                    Text("\(namePlayer2)")
//                                        .font(.system(size: 17))
//                                        .fontWeight(.bold)
//                                        .frame(maxWidth: .infinity)
//
//                                    Spacer()
//                                    Divider()
//
//                                    Text("\(player2Wins)")
//                                        .font(.system(size: 17))
//                                        .fontWeight(.bold)
//                                        .frame(maxWidth: .infinity)
//
//                                    Spacer()
//                                }
//                                                                
//                                if !namePlayer3.isEmpty {
//
//                                    Divider()
//
//                                    HStack {
//                                        
//                                        Spacer()
//                                        
//                                        Text("\(namePlayer3)")
//                                            .font(.system(size: 17))
//                                            .fontWeight(.bold)
//                                            .frame(maxWidth: .infinity)
//
//                                        Spacer()
//                                        Divider()
//
//                                        Text("\(player3Wins)")
//                                            .font(.system(size: 17))
//                                            .fontWeight(.bold)
//                                            .frame(maxWidth: .infinity)
//
//                                        Spacer()
//                                        
//                                    }
//                                    
//                                }
//
//                                if !namePlayer4.isEmpty {
//                                    
//                                    Divider()
//                                    
//                                    HStack {
//                                        
//                                        Spacer()
//                                        
//                                        Text("\(namePlayer4)")
//                                            .font(.system(size: 17))
//                                            .fontWeight(.bold)
//                                            .frame(maxWidth: .infinity)
//
//                                        Spacer()
//                                        Divider()
//
//                                        Text("\(player4Wins)")
//                                            .font(.system(size: 17))
//                                            .fontWeight(.bold)
//                                            .frame(maxWidth: .infinity)
//
//                                        Spacer()
//                                        
//                                    }
//                                    
//                                }
//                            }
//                            .padding()
//                        }
//                    }
//                    Image(systemName: "info.bubble")
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                        .onTapGesture {
//                            showCreditView = true
//                        }
//                        .padding(.bottom, 25)
//                        .padding(.top, 25)
//                        .sheet(isPresented: $showCreditView) {
//                                   CreditView()
//                        }
//                }
//            }
//        }
//    }
//    
//    // FUNCTIONS ///////////////////
//
//    func calculateAverageThrowsScoreV2(scores: [Int]) -> Int {
//      guard !scores.isEmpty else { return 0 }
//      let sum = scores.reduce(0, +)
//      return Int(round(Double(sum) / Double(scores.count)))
//    }
//
//    private func newGameV2() {
//        
//        print("--------------------------------------------")
//        print("func newGameV2. Done?")
//        
//        totalScorePlayer1 = 501
//        totalScorePlayer2 = 501
//        totalScorePlayer3 = 501
//        totalScorePlayer4 = 501
//
//        print("DONE")
//        
//        newGameResetV2Closure?()
//
//    }
//    
//}
//
//
//// PREVIEW ///////////////////
//
//struct InformationsViewV2_Previews: PreviewProvider {
//    static var previews: some View {
//        InformationsViewV2(
//            isThreeHundredOne: true,
//            isFiveHundredOne: false,
//            throwsScoresHistories: .constant([]),
//            player1ThrowsScores: .constant([]),
//            player2ThrowsScores: .constant([]),
//            player3ThrowsScores: .constant([]),
//            player4ThrowsScores: .constant([]),
//            totalScorePlayer1: .constant(0),
//            totalScorePlayer2: .constant(0),
//            totalScorePlayer3: .constant(0),
//            totalScorePlayer4: .constant(0),
//            namePlayer1: "Player 1",
//            namePlayer2: "Player 2",
//            namePlayer3: "Player 3",
//            namePlayer4: "Player 4",
//            currentPlayerIndex: .constant(0),
//            winnerName: "Winner"
//        )
//    }
//}

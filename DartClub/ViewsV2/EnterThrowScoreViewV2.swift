//
//  EnterThrowScoreViewV2.swift
//  DartClub
//
//  Created by Antoine on 23/04/2024.
//

import SwiftUI

struct EnterThrowScoreViewV2: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var currentPlayerIndex: Int

    @State private var firstThrowScore: Int?
    @State private var secondThrowScore: Int?
    @State private var thirdThrowScore: Int?

    @FocusState private var isFocused: Bool
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("\(viewModel.currentGame.players[currentPlayerIndex].name)")
                    .font(.system(size: 45, weight: .bold, design: .default))
                
                Text("Enter your score")
                    .font(.system(size: 30,  design: .default))
                
                TextField("1st throw", value: $firstThrowScore, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 30, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(width: 200)
                    .focused($isFocused)
                    .onAppear {
                        self.isFocused = true
                    }

                TextField("2nd throw", value: $secondThrowScore, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 30, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(width: 200)


                TextField("3rd throw", value: $thirdThrowScore, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 30, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(width: 200)

                Button("OK          ") {
                    
                    if let first = firstThrowScore, let second = secondThrowScore, let third = thirdThrowScore {
                        
                        let scores = [first, second, third]
                        viewModel.addScore(forPlayer: currentPlayerIndex, score: scores)
                        
                    }
                    
                    dismiss()
                    
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
                .disabled(!allFieldsHaveValues)
                
            }
        }
    }

    var allFieldsHaveValues: Bool {
        let scores = [firstThrowScore, secondThrowScore, thirdThrowScore].compactMap { $0 }
        return scores.count == 3 && scores.allSatisfy { $0 <= 60 }
    }
    
}


// ///////////////////////////
// PREVIEW //////////////////

//struct EnterThrowScoreViewV2_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let players = [
//            Player(name: "Alice", scores: []),
//            Player(name: "Bob", scores: []),
//            Player(name: "Charlie", scores: []),
//            Player(name: "Dana", scores: [])
//        ]
//        
//        let gameType = 501
//        let viewModel = GameViewModel(gameType: gameType, playerCount: players.count)
//        viewModel.currentGame.players = players  // Assignez les joueurs avec des noms au modèle de jeu
//        
//        return EnterThrowScoreViewV2(viewModel: viewModel, currentPlayerIndex: 0)
//    }
//}


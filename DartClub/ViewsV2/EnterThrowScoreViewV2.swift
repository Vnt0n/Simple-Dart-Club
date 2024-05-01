//
//  EnterThrowScoreViewV2.swift
//  DartClub
//
//  Created by Antoine on 23/04/2024.
//

import SwiftUI

struct EnterThrowScoreViewV2: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    @Binding var currentPlayerIndex: Int

    @State private var firstThrowScore: Int?
    @State private var secondThrowScore: Int?
    @State private var thirdThrowScore: Int?
    
    @FocusState private var isFocused: Bool
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Spacer()
                
                Text("\(viewModel.currentGame.players[currentPlayerIndex].name)")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .padding(.bottom, 1)

                Text("Enter your score")
                    .font(.system(size: 20,  design: .default))
                
                TextField("1st throw", value: $firstThrowScore, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 23, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(width: 150)
                    .focused($isFocused)
                    .onAppear {
                        self.isFocused = true
                    }

                TextField("2nd throw", value: $secondThrowScore, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 23, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(width: 150)


                TextField("3rd throw", value: $thirdThrowScore, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 23, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(width: 150)

                Button("OK          ") {
                    
                    if let first = firstThrowScore, let second = secondThrowScore, let third = thirdThrowScore {
                        
                        let scores = [first, second, third]
                        viewModel.addScore(forPlayer: currentPlayerIndex, score: scores)
                        currentPlayerIndex = (currentPlayerIndex + 1) % viewModel.currentGame.players.count
                        dismiss()
                        
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
                .disabled(!allFieldsHaveValues)
                
                Spacer()

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

struct EnterThrowScoreViewV2_Previews: PreviewProvider {
    static var previews: some View {
        let gameType = 180  // Define the game type
        let viewModel = GameViewModel(gameType: gameType)  // Initialize the view model with the game type

        // Ensure we have exactly 4 players for the preview
        while viewModel.currentGame.players.count < 4 {
            viewModel.addPlayer()
        }

        // Assign names to players for the preview
        viewModel.currentGame.players[0].name = "Alice"
        viewModel.currentGame.players[1].name = "Bob"
        viewModel.currentGame.players[2].name = "Charlie"
        viewModel.currentGame.players[3].name = "Dana"

        // Create a binding to simulate the currentPlayerIndex interaction
        return EnterThrowScoreViewV2(viewModel: viewModel, currentPlayerIndex: .constant(0))
    }
}

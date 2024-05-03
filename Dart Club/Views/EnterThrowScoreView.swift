//
//  EnterThrowScoreView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct EnterThrowScoreView: View {
    @ObservedObject var viewModel: GameViewModel
    @Binding var currentPlayerIndex: Int
    @State private var throwScores = [Int?](repeating: nil, count: 3)
    @State private var isDouble = [false, false, false]
    @State private var isTriple = [false, false, false]

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
                    .font(.system(size: 20, design: .default))

                ForEach(0..<3) { index in
                    ScoreInputRow(index: index, score: $throwScores[index], isDouble: $isDouble[index], isTriple: $isTriple[index])
                }

                Button("OK          ") {
                    submitScores()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
                .disabled(!allScoresEntered)

                Spacer()
            }
        }
    }

    var allScoresEntered: Bool {
        throwScores.allSatisfy { $0 != nil }
    }

    func submitScores() {
        if allScoresEntered, let first = throwScores[0], let second = throwScores[1], let third = throwScores[2] {
            let scores = [first, second, third]
            viewModel.addScore(forPlayer: currentPlayerIndex, score: scores)
            currentPlayerIndex = (currentPlayerIndex + 1) % viewModel.currentGame.players.count
            dismiss()
        }
    }
}

struct ScoreInputRow: View {
    let index: Int
    @Binding var score: Int?
    @Binding var isDouble: Bool
    @Binding var isTriple: Bool

    var body: some View {
        HStack {
            Spacer()
            
            ToggleScoreButton(systemImageName: "2.square", isActivated: $isDouble, otherIsActivated: $isTriple, score: $score, factor: 2)
            ToggleScoreButton(systemImageName: "3.square", isActivated: $isTriple, otherIsActivated: $isDouble, score: $score, factor: 3)

            TextField("\(ordinal(for: index+1)) throw", value: $score, format: .number)
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding()
                .keyboardType(.decimalPad)
                .frame(width: 130)
                .onChange(of: score) {
                    if score == nil {
                        isDouble = false
                        isTriple = false
                    }
                }
            
            Spacer()
            Spacer()
        }
    }

    private func ordinal(for number: Int) -> String {
        let suffix: [String] = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"]
        let ones = number % 10
        let tens = (number % 100) / 10
        if tens == 1 {
            return "\(number)th"
        } else {
            return "\(number)\(suffix[ones])"
        }
    }
}

struct ToggleScoreButton: View {
    let systemImageName: String
    @Binding var isActivated: Bool
    @Binding var otherIsActivated: Bool
    @Binding var score: Int?
    let factor: Int

    var body: some View {
        Button(action: toggleState) {
            Image(systemName: iconForButton())
                .font(.system(size: 25))
        }
        .foregroundColor(colorForButton())
        .disabled(shouldDisableButton() || otherIsActivated || score == nil)  // Disable if any condition applies
    }

    private func toggleState() {
        guard let currentScore = score, !(currentScore == 25 || currentScore == 50) else { return }
        score = isActivated ? currentScore / factor : currentScore * factor
        isActivated.toggle()
        if isActivated {
            otherIsActivated = false
        }
    }

    private func shouldDisableButton() -> Bool {
        guard let score = score else { return true }
        return score == 25 || score == 50 || !(score <= 50 || (score > 20 && score < 50))
    }

    private func iconForButton() -> String {
        // Return the non-fill icon if the button is disabled
        if shouldDisableButton() || otherIsActivated || score == nil {
            return systemImageName
        } else {
            return isActivated ? "\(systemImageName).fill" : systemImageName
        }
    }

    private func colorForButton() -> Color {
        // Always gray when disabled, blue when active or activable
        if shouldDisableButton() || otherIsActivated || score == nil {
            return .gray
        } else {
            return .blue
        }
    }
}


// ///////////////////////////
// PREVIEW //////////////////

struct EnterThrowScoreView_Previews: PreviewProvider {
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
        return EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(0))
    }
}

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
    @State private var throwScores = Array(repeating: ScoreEntry(score: nil, isModified: false), count: 3)
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
                    ScoreInputRow(index: index, scoreEntry: $throwScores[index], isDouble: $isDouble[index], isTriple: $isTriple[index])
                        .focused($isFocused, equals: index == 0) // Appliquer le modificateur focused
                }

                Button("OK          ") {
                    submitScores()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
                .disabled(!allScoresEntered)
                .onAppear {
                    DispatchQueue.main.async {
                        self.isFocused = true // Définir le focus sur le premier champ à l'apparition de la vue
                    }
                }

//////////////////////////////////////////////////////////////////// DEBUG BUTTON /////////////////////////////////////////////////////////////////

        Button(action: {

            print("--------------------------------------------")
            print("--------------------------------------------")
            print("DEBUG")
            print("--------------------------------------------")
            print("--------------------------------------------")
            print("DOUBLE OUT: \(viewModel.currentGame.isToggledDoubleOut)")
            print(" ")
            print(" ")
            
        }) {
            Image(systemName: "ladybug.circle")
                .accessibilityLabel("Undo")
                .font(.system(size: 25))
        }
                    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                Spacer()
                
            }
        }
    }

    var allScoresEntered: Bool {
        let allFilled = throwScores.allSatisfy { $0.score != nil }
        let allValid = throwScores.allSatisfy { entry in
            guard let score = entry.score else { return false }
            return (0...20).contains(score) || score == 25 || isResultOfDoublingOrTripling(entry)
        }
        return allFilled && allValid
    }
    
    private func isResultOfDoublingOrTripling(_ scoreEntry: ScoreEntry) -> Bool {
        return scoreEntry.isDoubleButtonActivated || scoreEntry.isTripleButtonActivated
    }

    func submitScores() {
        if allScoresEntered {
            // Créer un tableau de tuples pour chaque lancer avec son score et s'il était un double
            let throwDetails = zip(throwScores.compactMap { $0.score }, isDouble).map { (score: $0, isDouble: $1) }
            viewModel.addScore(forPlayer: currentPlayerIndex, throwDetails: throwDetails)
            currentPlayerIndex = (currentPlayerIndex + 1) % viewModel.currentGame.players.count
            dismiss()
        }
    }


}

struct ScoreEntry {
    var score: Int?
    var isModified: Bool
    var isDoubleButtonActivated: Bool = false
    var isTripleButtonActivated: Bool = false
}

struct ScoreInputRow: View {
    let index: Int
    @Binding var scoreEntry: ScoreEntry
    @Binding var isDouble: Bool
    @Binding var isTriple: Bool

    var body: some View {
        
        HStack {
            
            Spacer()
            
            ToggleScoreButton(systemImageName: "2.square", isDoubleButton: true, isActivated: $isDouble, otherIsActivated: $isTriple, scoreEntry: $scoreEntry, factor: 2)

            ToggleScoreButton(systemImageName: "3.square", isDoubleButton: false, isActivated: $isTriple, otherIsActivated: $isDouble, scoreEntry: $scoreEntry, factor: 3)

            TextField("\(ordinal(for: index+1)) throw", value: $scoreEntry.score, format: .number)
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding()
                .keyboardType(.decimalPad)
                .frame(width: 130)
                .onChange(of: scoreEntry.score) {
                    if scoreEntry.score == nil {
                        isDouble = false
                        isTriple = false
                        scoreEntry.isDoubleButtonActivated = false
                        scoreEntry.isTripleButtonActivated = false
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
        let isDoubleButton: Bool
        @Binding var isActivated: Bool
        @Binding var otherIsActivated: Bool
        @Binding var scoreEntry: ScoreEntry
        let factor: Int

        var body: some View {
            Button(action: toggleState) {
                Image(systemName: iconForButton())
                    .font(.system(size: 35))
            }
            .foregroundColor(colorForButton())
            .disabled(shouldDisableButton() || otherIsActivated || scoreEntry.score == nil)
        }

    private func toggleState() {
        guard let currentScore = scoreEntry.score else { return }

        // Si le bouton est actuellement activé, il sera désactivé et vice-versa.
        // Mettre à jour le score selon l'état activé/désactivé du bouton.
        if isActivated {
            // Si le bouton est actuellement activé, divisez le score pour "annuler" l'effet du doublement ou triplement.
            scoreEntry.score = currentScore / factor
            scoreEntry.isModified = false  // Marquer comme non modifié car on "annule" l'effet
        } else {
            // Si le bouton n'est pas activé, multipliez le score pour appliquer l'effet du doublement ou triplement.
            scoreEntry.score = currentScore * factor
            scoreEntry.isModified = true   // Marquer comme modifié car on applique l'effet
        }

        // Basculez l'état d'activation du bouton.
        isActivated.toggle()

        // Assurer que seulement un des boutons peut être activé à la fois.
        if isActivated {
            if isDoubleButton {
                scoreEntry.isDoubleButtonActivated = true
                scoreEntry.isTripleButtonActivated = false
            } else {
                scoreEntry.isTripleButtonActivated = true
                scoreEntry.isDoubleButtonActivated = false
            }
        } else {
            if isDoubleButton {
                scoreEntry.isDoubleButtonActivated = false
            } else {
                scoreEntry.isTripleButtonActivated = false
            }
        }
    }

    private func shouldDisableButton() -> Bool {
        guard let score = scoreEntry.score else { return true }

        if scoreEntry.isDoubleButtonActivated || scoreEntry.isTripleButtonActivated {
            return false
        }

        if score == 25 && isDoubleButton {
            // Activer le bouton double
            return false
        }
        
        if score < 0 || score > 20 {
            return true
        }

        return false
    }

    private func iconForButton() -> String {
          if shouldDisableButton() || otherIsActivated || scoreEntry.score == nil {
              return systemImageName
          } else {
              return isActivated ? "\(systemImageName).fill" : systemImageName
          }
      }
    
    private func colorForButton() -> Color {
        if shouldDisableButton() || otherIsActivated || scoreEntry.score == nil {
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

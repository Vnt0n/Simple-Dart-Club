import SwiftUI

struct EnterThrowScoreView: View {
    @ObservedObject var viewModel: GameViewModel
    @Binding var currentPlayerIndex: Int
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    @State private var displayedPlayerName: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("\(displayedPlayerName)")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .padding(.bottom, 1)
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Text("Enter your score")
                        .font(.system(size: 20, design: .default))
                }
                ForEach(0..<3) { index in
                    ScoreInputRow(index: index, scoreEntry: $viewModel.throwScores[index], isDouble: $viewModel.isDouble[index], isTriple: $viewModel.isTriple[index])
                        .focused($isFocused, equals: index == 0)
                }
                .padding(UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
                .offset(x: UIDevice.current.userInterfaceIdiom == .pad ? 80 : 0)

                Button("OK") {
                    viewModel.submitScores()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
                .disabled(!viewModel.allScoresEntered())
                .onAppear {
                    DispatchQueue.main.async {
                        self.isFocused = true
                        displayedPlayerName = viewModel.currentGame.players[viewModel.currentPlayerIndex].name
                        viewModel.resetThrowScores() // Réinitialise les scores de lancer et les états
                    }
                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ScoreInputRow: View {
    let index: Int
    @Binding var scoreEntry: ScoreEntry
    @Binding var isDouble: Bool
    @Binding var isTriple: Bool
    @FocusState private var textFieldFocus: Bool

    var body: some View {
        HStack {
            Spacer()
            ToggleScoreButton(systemImageName: "2.square", isDoubleButton: true, isActivated: $isDouble, otherIsActivated: $isTriple, scoreEntry: $scoreEntry, factor: 2)
                .onChange(of: isDouble) {
                    textFieldFocus = false
                }

            ToggleScoreButton(systemImageName: "3.square", isDoubleButton: false, isActivated: $isTriple, otherIsActivated: $isDouble, scoreEntry: $scoreEntry, factor: 3)
                .onChange(of: isTriple) {
                    textFieldFocus = false
                }

            TextField("\(Locale.current.language.languageCode?.identifier == "en" ? ordinal(for: index+1) : "\(index+1)") throw", value: $scoreEntry.score, format: .number)
                .font(.system(size: 22))
                .multilineTextAlignment(.center)
                .padding(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 15)
                .keyboardType(.decimalPad)
                .frame(width: 130)
                .focused($textFieldFocus)
                .onChange(of: scoreEntry.score) {
                    if scoreEntry.score == nil {
                        isDouble = false
                        isTriple = false
                        scoreEntry.isDoubleButtonActivated = false
                        scoreEntry.isTripleButtonActivated = false
                    }
                }
                .onTapGesture {
                    if scoreEntry.score != nil {
                        scoreEntry.score = nil
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
        print("--------------------------------------------")
        print("ordinal (PRIVATE) FUNCTION (EnterThrowScoreView)")
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
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(colorForButton())
        .disabled(shouldDisableButton() || otherIsActivated || scoreEntry.score == nil)
    }

    private func toggleState() {
        print("--------------------------------------------")
        print("toggleState (PRIVATE) FUNCTION (EnterThrowScoreView)")
        guard let currentScore = scoreEntry.score else { return }

        if isActivated {
            scoreEntry.score = currentScore / factor
            scoreEntry.isModified = false
        } else {
            scoreEntry.score = currentScore * factor
            scoreEntry.isModified = true
        }

        isActivated.toggle()

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
        print("--------------------------------------------")
        print("shouldDisableButton (PRIVATE) FUNCTION (EnterThrowScoreView)")
        guard let score = scoreEntry.score else { return true }

        if scoreEntry.isDoubleButtonActivated || scoreEntry.isTripleButtonActivated {
            return false
        }

        if score == 25 && isDoubleButton {
            return false
        }

        if score <= 0 || score > 20 {
            return true
        }

        return false
    }

    private func iconForButton() -> String {
        print("--------------------------------------------")
        print("iconForButton (PRIVATE) FUNCTION (EnterThrowScoreView)")
        if shouldDisableButton() || otherIsActivated || scoreEntry.score == nil {
            return systemImageName
        } else {
            return isActivated ? "\(systemImageName).fill" : systemImageName
        }
    }

    private func colorForButton() -> Color {
        print("--------------------------------------------")
        print("colorForButton (PRIVATE) FUNCTION (EnterThrowScoreView)")
        if shouldDisableButton() || otherIsActivated || scoreEntry.score == nil {
            return .gray
        } else {
            return .blue
        }
    }
}

extension View {
    @ViewBuilder
    func conditionalStack<Content: View>(
        isHorizontal: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        if isHorizontal {
            HStack { content() }
        } else {
            VStack { content() }
        }
    }
}


// ///////////////////////////
// PREVIEW //////////////////

struct EnterThrowScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let gameType = 180
        let viewModel = GameViewModel(gameType: gameType)

        while viewModel.currentGame.players.count < 4 {
            viewModel.addPlayer()
        }

        viewModel.currentGame.players[0].name = "Alice"
        viewModel.currentGame.players[1].name = "Bob"
        viewModel.currentGame.players[2].name = "Charlie"
        viewModel.currentGame.players[3].name = "Dana"

        viewModel.currentGame.isToggledDoubleOut = true

        return Group {
            EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(0))
                .previewDisplayName("English")
                .environment(\.locale, Locale(identifier: "en"))

            EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(1))
                .previewDisplayName("French")
                .environment(\.locale, Locale(identifier: "fr"))

            EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(0))
                .previewDisplayName("Spanish")
                .environment(\.locale, Locale(identifier: "es"))

            EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(1))
                .previewDisplayName("German")
                .environment(\.locale, Locale(identifier: "de"))

            EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(0))
                .previewDisplayName("Chinese")
                .environment(\.locale, Locale(identifier: "zh-Hans"))

            EnterThrowScoreView(viewModel: viewModel, currentPlayerIndex: .constant(1))
                .previewDisplayName("Japanese")
                .environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

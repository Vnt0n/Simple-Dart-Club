//
//  EnterThrowScoreView.swift
//  Simple Dart Club
//
//  Created by Antoine on 29/07/2024.
//

import SwiftUI

struct EnterThrowScoreView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss

    let buttonNumbers = [
        1, 2, 3, 4,
        5, 6, 7, 8,
        9, 10, 11, 12,
        13, 14, 15, 16,
        17, 18, 19, 20,
        21, 0, 25
    ]
    
    @State private var currentThrowIndex = 0
    @State private var isMultiplierEnabled = false
    @State private var isTripleEnabled = true
    @State private var selectedNumber: Int? = nil
    @State private var growScale: CGFloat = 1.0

    var body: some View {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        VStack {
            Text("\(viewModel.currentGame.players[viewModel.currentPlayerIndex].name)")
                .font(.title2)
            Text("Throw \(currentThrowIndex + 1)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .scaleEffect(growScale)
                .animation(.easeInOut(duration: 0.2), value: growScale)
            
            Text("Remaining Score: \(viewModel.tempRemainingScore)")
                .padding(.bottom, 20)

            // Grid of buttons
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 15) {
                ForEach(buttonNumbers, id: \.self) { number in
                    Button(action: {
                        withAnimation(.none) {
                            if number != 21 {
                                viewModel.throwScores[currentThrowIndex].score = number
                                isMultiplierEnabled = true
                                isTripleEnabled = number != 25
                                selectedNumber = number
                                if number == 0 {
                                    nextThrow()
                                }
                            }
                        }
                    }) {
                        Text("\(number == 21 ? "" : "\(number)")")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(selectedNumber == number ? Color.blue : Color.clear)
                            .foregroundColor(selectedNumber == number ? .white : .blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .cornerRadius(8)
                            .opacity(number == 21 ? 0 : 1)
                    }
                    .disabled(number == 21)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, isPad ? 200 : 40)

            Spacer().frame(height: 40)

            // Multiplier buttons
            HStack(spacing: isPad ? 35 : 20) {
                
                Button(action: {
                    print("--------------------------------------------")
                    print("BUTTON undoLastThrow")
                    undoLastThrow()
                }) {
                    Image(systemName: "arrow.uturn.backward.circle")
                        .accessibilityLabel("Undo")
                        .font(.system(size: 25))
                }
                .disabled(currentThrowIndex == 0)
                .foregroundColor(currentThrowIndex == 0 ? .gray : .white)
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    nextThrow()
                }) {
                    Text("x1")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .foregroundColor(isMultiplierEnabled ? .white : .gray)
                        .background(isMultiplierEnabled ? Color.blue : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isMultiplierEnabled ? Color.white : Color.gray, lineWidth: 2)
                        )
                }
                .disabled(!isMultiplierEnabled)
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    applyMultiplier(2)
                }) {
                    Text("x2")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .foregroundColor(isMultiplierEnabled ? .white : .gray)
                        .background(isMultiplierEnabled ? Color.blue : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isMultiplierEnabled ? Color.white : Color.gray, lineWidth: 2)
                        )
                }
                .disabled(!isMultiplierEnabled)
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    applyMultiplier(3)
                }) {
                    Text("x3")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .foregroundColor((isMultiplierEnabled && isTripleEnabled) ? .white : .gray)
                        .background((isMultiplierEnabled && isTripleEnabled) ? Color.blue : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke((isMultiplierEnabled && isTripleEnabled) ? Color.white : Color.gray, lineWidth: 2)
                        )
                }
                .disabled(!isMultiplierEnabled || !isTripleEnabled)
                .buttonStyle(PlainButtonStyle())
                
            }
            .padding(.bottom, 20)
            .padding(.trailing, isPad ? 60 : 45)
        }
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.checkScoreAfterThrow()  // Appel de la fonction lorsque la vue apparaît
        }
        .onChange(of: viewModel.dismissEnterThrowScoreView) {
                    if viewModel.dismissEnterThrowScoreView {
                        dismiss()  // Dismiss la vue si le jeu est terminé
                    }
                }
    }
    
    private func applyMultiplier(_ multiplier: Int) {
        if let score = viewModel.throwScores[currentThrowIndex].score {
            viewModel.throwScores[currentThrowIndex].score = score * multiplier
            if multiplier == 2 {
                viewModel.throwScores[currentThrowIndex].isDoubleButtonActivated = true
                viewModel.throwScores[currentThrowIndex].isModified = true
            } else if multiplier == 3 {
                viewModel.throwScores[currentThrowIndex].isTripleButtonActivated = true
                viewModel.throwScores[currentThrowIndex].isModified = true
            }
            nextThrow()
        }
    }

    private func nextThrow() {
        withAnimation(.none) {
            isMultiplierEnabled = false
            isTripleEnabled = true
            selectedNumber = nil
                       
            if currentThrowIndex < 2 {
                currentThrowIndex += 1
                growEffect()
                // Vérifier si le joueur a gagné après ce lancer
                viewModel.checkScoreAfterThrow()
            } else {
                viewModel.submitScores()
                dismiss()
            }
        }
    }
    
    private func undoLastThrow() {
        withAnimation(.none) {
            if currentThrowIndex > 0 {
                currentThrowIndex -= 1
                viewModel.throwScores[currentThrowIndex] = ScoreEntry(score: nil, isModified: false)
                isMultiplierEnabled = false
                isTripleEnabled = true
                selectedNumber = nil
                growEffect()
            }
        }
    }

    private func growEffect() {
        withAnimation(.easeInOut(duration: 0.2)) {
            growScale = 1.5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                growScale = 1.0
            }
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
            EnterThrowScoreView(viewModel: viewModel)
                .previewDisplayName("English")
                .environment(\.locale, Locale(identifier: "en"))

            EnterThrowScoreView(viewModel: viewModel)
                .previewDisplayName("French")
                .environment(\.locale, Locale(identifier: "fr"))

            EnterThrowScoreView(viewModel: viewModel)
                .previewDisplayName("Spanish")
                .environment(\.locale, Locale(identifier: "es"))

            EnterThrowScoreView(viewModel: viewModel)
                .previewDisplayName("German")
                .environment(\.locale, Locale(identifier: "de"))

            EnterThrowScoreView(viewModel: viewModel)
                .previewDisplayName("Chinese")
                .environment(\.locale, Locale(identifier: "zh-Hans"))

            EnterThrowScoreView(viewModel: viewModel)
                .previewDisplayName("Japanese")
                .environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

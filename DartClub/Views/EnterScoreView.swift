//
//  EnterScoreView.swift
//  DartClub
//
//  Created by Antoine on 28/03/2024.
//

import SwiftUI

struct EnterScoreView: View {
    
    var playerName: String
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    @Binding var throwsPlayer1: Int
    @Binding var throwsPlayer2: Int
    @Binding var throwsPlayer3: Int
    
    @Binding var player1Scores: [Int]
    @Binding var player2Scores: [Int]
    @Binding var player3Scores: [Int]
    
    @Environment(\.dismiss) var dismiss
    @State private var score: Int?
    @FocusState private var isFocused: Bool
    
    var onScoreEntered: (String) -> Void
    
    var body: some View {
        NavigationStack {
            Text(playerName)
                .font(.system(size: 45, weight: .bold, design: .default))
            Text("Enter your score")
                .font(.system(size: 30, weight: .bold, design: .default))
            TextField("", value: $score, format: .number)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 50, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
                .padding()
                .keyboardType(.decimalPad)
                .frame(width: 200)
                .focused($isFocused)
                .onAppear {
                    self.isFocused = true
                    print("--------------------------------------------")
                    print("EnterScoreView")
                }
        }
 
        Button("OK          ") {
            
            onScoreEntered(score != nil ? "\(score!)" : "")
            dismiss()
            
            switch playerName {
                case namePlayer1:
                    throwsPlayer1 += 1
                case namePlayer2:
                    throwsPlayer2 += 1
                case namePlayer3:
                    throwsPlayer3 += 1
                default:
                    break
                }
            
            if let enteredScore = score {
                    switch playerName {
                        case namePlayer1:
                            player1Scores.append(enteredScore)
                        case namePlayer2:
                            player2Scores.append(enteredScore)
                        case namePlayer3:
                            player3Scores.append(enteredScore)
                        default:
                            break
                    }
                
                }
            print("--------------------------------------------")
            print("OK BUTTON EnterScoreView")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .disabled(score == nil || score! > 180)
    }
}


// PREVIEWS ///////////////////

struct EnterScoreView_Previews: PreviewProvider {
    static var previews: some View {
        EnterScoreView(playerName: "Antoine", namePlayer1: "Antoine", namePlayer2: "Julien", namePlayer3: "JJ", throwsPlayer1: .constant(1), throwsPlayer2: .constant(1), throwsPlayer3: .constant(1), player1Scores: .constant([]), player2Scores: .constant([]), player3Scores: .constant([])) { _ in }
    }
}

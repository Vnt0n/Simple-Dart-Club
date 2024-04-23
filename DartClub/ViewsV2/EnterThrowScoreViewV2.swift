//
//  EnterThrowScoreViewV2.swift
//  DartClub
//
//  Created by Antoine on 23/04/2024.
//

import SwiftUI

struct EnterThrowScoreViewV2: View {
    
    var playerName: String
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    var namePlayer4: String

    @Binding var throwsPlayer1: Int
    @Binding var throwsPlayer2: Int
    @Binding var throwsPlayer3: Int
    @Binding var throwsPlayer4: Int

    @Binding var player1ThrowsScores: [Int]
    @Binding var player2ThrowsScores: [Int]
    @Binding var player3ThrowsScores: [Int]
    @Binding var player4ThrowsScores: [Int]

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
                    print("enterThrowScoreView")
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
                case namePlayer4:
                    throwsPlayer4 += 1
                default:
                    break
                }
            
            if let enteredThrowScore = score {
                    switch playerName {
                        case namePlayer1:
                            player1ThrowsScores.append(enteredThrowScore)
                        case namePlayer2:
                            player2ThrowsScores.append(enteredThrowScore)
                        case namePlayer3:
                            player3ThrowsScores.append(enteredThrowScore)
                        case namePlayer4:
                            player4ThrowsScores.append(enteredThrowScore)
                        default:
                            break
                    }
                
                }
            print("--------------------------------------------")
            print("OK BUTTON enterThrowScoreView")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .disabled(score == nil || score! > 180)
    }
}


// PREVIEWS ///////////////////

struct enterThrowScoreViewV2_Previews: PreviewProvider {
    static var previews: some View {
        EnterThrowScoreViewV2(playerName: "Antoine", namePlayer1: "Antoine", namePlayer2: "Julien", namePlayer3: "JJ", namePlayer4: "MC", throwsPlayer1: .constant(1), throwsPlayer2: .constant(1), throwsPlayer3: .constant(1), throwsPlayer4: .constant(1), player1ThrowsScores: .constant([]), player2ThrowsScores: .constant([]), player3ThrowsScores: .constant([]), player4ThrowsScores: .constant([])) { _ in }
    }
}

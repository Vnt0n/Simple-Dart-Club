//
//  EnterThrowScoreViewV2.swift
//  DartClub
//
//  Created by Antoine on 23/04/2024.
//

import SwiftUI

struct EnterThrowScoreViewV2: View {
      
    var players: [Player]

    @Binding var currentPlayerIndex: Int

    @Environment(\.dismiss) var dismiss
    @State private var score: Int?
    @FocusState private var isFocused: Bool
    
//    var onScoreEntered: (String) -> Void
    
    var body: some View {
        NavigationStack {
            Text(players[currentPlayerIndex].name)
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
            
            currentPlayerIndex = (currentPlayerIndex + 1) % players.count

            dismiss()

//            onScoreEntered(score != nil ? "\(score!)" : "")
//
//            switch players[currentPlayerIndex] {
//                case players[0]:
//                    throwsPlayer1 += 1
//                case players[1]:
//                    throwsPlayer2 += 1
//                case players[2]:
//                    throwsPlayer3 += 1
//                case players[3]:
//                    throwsPlayer4 += 1
//                default:
//                    break
//                }
            
//            if let enteredThrowScore = score {
//                    switch players {
//                        case players[0]:
//                            player1ThrowsScores.append(enteredThrowScore)
//                        case players[1]:
//                            player2ThrowsScores.append(enteredThrowScore)
//                        case players[2]:
//                            player3ThrowsScores.append(enteredThrowScore)
//                        case players[3]:
//                            player4ThrowsScores.append(enteredThrowScore)
//                        default:
//                            break
//                    }
//                
//                }
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

//struct enterThrowScoreViewV2_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterThrowScoreViewV2(playerName: "Antoine", namePlayer1: "Antoine", namePlayer2: "Julien", namePlayer3: "JJ", namePlayer4: "MC", throwsPlayer1: .constant(1), throwsPlayer2: .constant(1), throwsPlayer3: .constant(1), throwsPlayer4: .constant(1), player1ThrowsScores: .constant([]), player2ThrowsScores: .constant([]), player3ThrowsScores: .constant([]), player4ThrowsScores: .constant([])) { _ in }
//    }
//}

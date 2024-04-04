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
    
    @Environment(\.dismiss) var dismiss
    @State private var score: Int?
    @FocusState private var isFocused: Bool
    
    var onScoreEntered: (String) -> Void
    
    var body: some View {
        NavigationStack {
            Text(playerName)
            Text("Enter your score")
            TextField("", value: $score, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
                .keyboardType(.decimalPad)
                .frame(width: 100)
                .focused($isFocused)
                .onAppear {
                    self.isFocused = true
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
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .disabled(score == nil)
    }
}

struct EnterScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let playerName = "Player 1"
        let namePlayer1 = "Player 1"
        let namePlayer2 = "Player 2"
        let namePlayer3 = "Player 3"
        @State var throwsPlayer1 = 1
        @State var throwsPlayer2 = 1
        @State var throwsPlayer3 = 1
        @State var score: Int?
        
        EnterScoreView(playerName: playerName,
                       namePlayer1: namePlayer1,
                       namePlayer2: namePlayer2,
                       namePlayer3: namePlayer3,
                       throwsPlayer1: $throwsPlayer1,
                       throwsPlayer2: $throwsPlayer2,
                       throwsPlayer3: $throwsPlayer3) { enteredScore in
        }
    }
}

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
    
    @Environment(\.dismiss) var dismiss
    @State private var score: Int?
    @FocusState private var isFocused: Bool

    
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
            dismiss()
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .disabled(score == nil)
    }
}

struct EnterScoreView_Previews: PreviewProvider {
    static var previews: some View {
        EnterScoreView(playerName: "Player", namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "player3")
    }
}

//
//  EnterScoreView.swift
//  DartClub
//
//  Created by Antoine on 28/03/2024.
//

import SwiftUI

struct EnterScoreView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var score: Int?
    @FocusState private var isFocused: Bool

    
    var body: some View {
        NavigationStack {
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

#Preview {
    EnterScoreView()
}

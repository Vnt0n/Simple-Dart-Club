//
//  EnterThrowScoreViewV2.swift
//  DartClub
//
//  Created by Antoine on 23/04/2024.
//

import SwiftUI

struct EnterThrowScoreViewV2: View {
    @ObservedObject var viewModel: GameViewModel
    var currentPlayerIndex: Int

    @State private var firstThrowScore: Int?
    @State private var secondThrowScore: Int?
    @State private var thirdThrowScore: Int?
    
    var body: some View {
        NavigationStack {
            VStack {
                // UI components for entering scores
                Button("Submit Scores") {
                    if let first = firstThrowScore, let second = secondThrowScore, let third = thirdThrowScore {
                        let scores = [first, second, third]
                        viewModel.addScore(forPlayer: currentPlayerIndex, score: scores)
                    }
                }
                .disabled(!allFieldsHaveValues)
            }
        }
    }

    var allFieldsHaveValues: Bool {
        let scores = [firstThrowScore, secondThrowScore, thirdThrowScore].compactMap { $0 }
        return scores.count == 3 && scores.allSatisfy { $0 <= 60 }
    }
}


//
//  NEW_EnterThrowScoreView.swift
//  Simple Dart Club
//
//  Created by Antoine on 29/07/2024.
//

//
//  EnteThrowScoreView_V2.swift
//  Simple Dart Club
//
//  Created by Antoine on 26/07/2024.
//

import SwiftUI

struct EnterThrowScoreView_V2: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    let buttonNumbers = [
        1, 2, 3, 4,
        5, 6, 7, 8,
        9, 10, 11, 12,
        13, 14, 15, 16,
        17, 18, 19, 20,
        0, 25
    ]

    var body: some View {
        VStack {
            Text("\(viewModel.currentGame.players[viewModel.currentPlayerIndex].name)")
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("Enter your score")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            // Grid of buttons
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 15) {
                ForEach(buttonNumbers, id: \.self) { number in
                    Button(action: {
                        // Action for button press
                    }) {
                        Text("\(number)")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer().frame(height: 40)
            
            // Multiplier buttons
            HStack(spacing: 20) {
                ForEach(1...3, id: \.self) { multiplier in
                    Button(action: {
                        // Action for multiplier button press
                    }) {
                        Text("x\(multiplier)")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
    }
}



// ///////////////////////////
// PREVIEW //////////////////

struct EnterThrowScoreView_V2_Previews: PreviewProvider {
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
            EnterThrowScoreView_V2(viewModel: viewModel)
                .previewDisplayName("English")
                .environment(\.locale, Locale(identifier: "en"))

            EnterThrowScoreView_V2(viewModel: viewModel)
                .previewDisplayName("French")
                .environment(\.locale, Locale(identifier: "fr"))

            EnterThrowScoreView_V2(viewModel: viewModel)
                .previewDisplayName("Spanish")
                .environment(\.locale, Locale(identifier: "es"))

            EnterThrowScoreView_V2(viewModel: viewModel)
                .previewDisplayName("German")
                .environment(\.locale, Locale(identifier: "de"))

            EnterThrowScoreView_V2(viewModel: viewModel)
                .previewDisplayName("Chinese")
                .environment(\.locale, Locale(identifier: "zh-Hans"))

            EnterThrowScoreView_V2(viewModel: viewModel)
                .previewDisplayName("Japanese")
                .environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

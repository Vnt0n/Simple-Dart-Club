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

struct EnteThrowScoreView_V2: View {
//    @ObservedObject var viewModel: GameViewModel
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
//                Text("\(viewModel.currentGame.players[viewModel.currentPlayerIndex].name)")
                Text("TEST")
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


#Preview {
    EnteThrowScoreView_V2()
}

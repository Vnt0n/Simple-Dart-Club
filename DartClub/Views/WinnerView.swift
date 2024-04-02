//
//  Contentview.swift
//  DartClub
//
//  Created by Antoine on 29/03/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct WinnerView: View {
    
    @State private var counter = 0
    @State private var isGameStarted = false
    
    @Binding var currentPlayerIndex: Int
    
    var playerNames: [String]
    
    @Binding var scorePlayer1: Int
    @Binding var scorePlayer2: Int
    @Binding var scorePlayer3: Int

    var namePlayer: String
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("0")
                    .padding([.bottom], 10)
                    .font(.system(size: 140, weight: .bold, design: .default))
                Text(namePlayer)
                    .padding([.bottom], 10)
                Button(action: {
                    counter += 1
                }) {
                    Text("You won!")
                        .font(.system(size: 50, weight: .bold, design: .default))
                }
                .confettiCannon(counter: $counter, num: 150, radius: 500.0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.counter += 1
                    }
                }
            }
            
            Button("New game") {
                newGame()
                isGameStarted = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .navigationDestination(isPresented: $isGameStarted) {
                GameView(namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
            }
        }
    }
    
    private func newGame() {
        scorePlayer1 = 501
        scorePlayer2 = 501
        scorePlayer3 = 501
//        currentPlayerIndex = (currentPlayerIndex + 1) % playerNames.count
    }
}


struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        let currentPlayerIndex = Binding.constant(0)
        let playerNames = ["Player1", "Player2", "Player3"]
        let scorePlayer1 = Binding.constant(501)
        let scorePlayer2 = Binding.constant(501)
        let scorePlayer3 = Binding.constant(501)
        
        return WinnerView(currentPlayerIndex: currentPlayerIndex,
                          playerNames: playerNames,
                          scorePlayer1: scorePlayer1,
                          scorePlayer2: scorePlayer2,
                          scorePlayer3: scorePlayer3,
                          namePlayer: "Player1",
                          namePlayer1: "Player1",
                          namePlayer2: "Player2",
                          namePlayer3: "Player3")
    }
}

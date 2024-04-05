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
    
    @State private var winnerNamesList: [String] = []
       
    var playerNames: [String]
    
    @Binding var scorePlayer1: Int
    @Binding var scorePlayer2: Int
    @Binding var scorePlayer3: Int
    @Binding var currentPlayerIndex: Int

    var winnerName: String
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
    
    var newGameResetClosure: (() -> Void)?

    var body: some View {
        NavigationStack {
            VStack {
                Text("0")
                    .padding([.bottom], 10)
                    .font(.system(size: 140, weight: .bold, design: .default))
                Text(winnerName)
                    .padding([.bottom], 10)
                    Text("You won!")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(.blue)
                        .confettiCannon(counter: $counter, num: 150, radius: 500.0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                self.counter = 1
                                winnerNamesList.append(winnerName)
                            }
                        }
                HStack {
                    Text("\(namePlayer1)")
                        .bold()
                    Text("\(scorePlayer1) -")
                    Text("\(namePlayer2)")
                        .bold()
                    Text("\(scorePlayer2)")
                    if !namePlayer3.isEmpty {
                        Text("-")
                        Text("\(namePlayer3)")
                            .bold()
                        Text("\(scorePlayer3)")
                    }
                }
                .padding()
            }
            
            Button("New game") {
                newGame()
                isGameStarted = true
                newGameResetClosure?()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .navigationDestination(isPresented: $isGameStarted) {
                GameView(namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func newGame() {
        scorePlayer1 = 501
        scorePlayer2 = 501
        scorePlayer3 = 501
        print("--------------------------------------------")
        print("NEW GAME BUTTON")
        newGameResetClosure?()

    }

}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(
            playerNames: ["Alice", "Bob", "Charlie"],
            scorePlayer1: .constant(0),
            scorePlayer2: .constant(0),
            scorePlayer3: .constant(0),
            currentPlayerIndex: .constant(1),
            winnerName: "Bob",
            namePlayer1: "Alice",
            namePlayer2: "Bob",
            namePlayer3: "Charlie"
        )
    }
}

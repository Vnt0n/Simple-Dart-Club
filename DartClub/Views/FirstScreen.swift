//
//  SwiftUIView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct FirstScreen: View {

    @State private var player1: String = ""
    @State private var player2: String = ""
    @State private var player3: String = ""

    @State private var showPlayer3 = false
    @FocusState private var isFocusedPlayer3: Bool 


    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {

                Spacer()

                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280)

                Spacer()

                Text("Player 1")

                TextField("", text: $player1).TextFieldStyling()
                    .onSubmit {
                        print("OK PLAYER 1")
                        player1 = $player1.wrappedValue
                        print("Le joueur 1 est \(player1)")
                      }

                Spacer()

                Text("Player 2")

                TextField("", text: $player2).TextFieldStyling()
                    .onSubmit {
                        print("OK PLAYER 2")
                        player2 = $player2.wrappedValue
                        print("Le joueur 1 est TOUJOURS \(player1)")
                        print("Le joueur 2 est \(player2)")
                      }

                Spacer()

                if showPlayer3 {
                    Text("Player 3")

                    TextField("", text: $player3).TextFieldStyling()
                        .focused($isFocusedPlayer3)
                        .onAppear {
                            isFocusedPlayer3 = true
                        }
                        .onSubmit {
                            print("OK PLAYER 3")
                            player3 = $player3.wrappedValue
                            print("Le joueur 1 est ENCORE ET TOUJOURS \(player1)")
                            print("Le joueur 2 est TOUJOURS \(player2)")
                            print("Le joueur 3 est \(player3)")
                          }

                    Spacer()

                } else {

                    Button("+ Add a player") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showPlayer3 = true
                        }
                    }
                    Spacer()
                }

                Spacer()

            }   .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold, design: .default))
                .shadow(radius: 10)
                .navigationBarBackButtonHidden(true)
         }
    }
}

#Preview {
    FirstScreen()
}

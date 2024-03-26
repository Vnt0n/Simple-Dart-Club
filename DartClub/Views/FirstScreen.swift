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
    @FocusState private var isFocusedPlayer2: Bool
    @FocusState private var isFocusedPlayer3: Bool

    @State private var isNameOneSubmitted = false
    @State private var isNameTwoSubmitted = false
    @State private var isNameThreeSubmitted = false


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

                if !isNameOneSubmitted {
                    Text("Player 1")
                    
                    TextField("", text: $player1).TextFieldStyling()
                        .onSubmit {
                            player1 = $player1.wrappedValue
                            isNameOneSubmitted = true
                            isFocusedPlayer2 = true
                        }
                } else {
                    Text(player1)
                }

                Spacer()
                
                if !isNameTwoSubmitted {

                    Text("Player 2")
                    TextField("", text: $player2)
                        .TextFieldStyling()
                        .focused($isFocusedPlayer2)
                        .onSubmit {
                            player2 = $player2.wrappedValue
                            isNameTwoSubmitted = true
                        }

                    Spacer()

                } else {
                    Text(player2)
                }

                Spacer()

                if !isNameThreeSubmitted {

                    if showPlayer3 {
                        Text("Player 3")

                        TextField("", text: $player3)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer3)
                            .onAppear {
                                isFocusedPlayer3 = true
                            }
                            .onSubmit {
                                player3 = $player3.wrappedValue
                                isNameThreeSubmitted = true
                            }

                        Spacer()

                    } else {
                        Button("+ Add a player") {
                            if !player2.isEmpty {
                                 withAnimation(.easeInOut(duration: 0.5)) {
                                    showPlayer3 = true
                                    isNameTwoSubmitted = true
                                }
                            }
                        }
                    }
                    Spacer()
                    
                } else {
                    Text(player3)
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

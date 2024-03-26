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

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                
                Spacer()

                Text("Player 1")
                
                TextField("", text: $player1).TextFieldStyling()
                                
                Spacer()
                
                Text("Player 2")
                
                TextField("", text: $player2).TextFieldStyling()

                Spacer()

                if showPlayer3 {
                    Text("Player 3")

                    TextField("", text: $player3).TextFieldStyling()
                    
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

//
//  SwiftUIView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct TEST: View {
    @State private var player1: String = ""
    @State private var isNameSubmitted = false

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                
                if !isNameSubmitted {
                    Text("Player 1")
                    
                    TextField("", text: $player1)
                        .TextFieldStyling()
                        .padding(.horizontal, 50)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 350)
                        .multilineTextAlignment(.center)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .onSubmit {
                            isNameSubmitted = true
                        }
                } else {
                    Text(player1)
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold, design: .default))
            .shadow(radius: 10)
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    TEST()
}

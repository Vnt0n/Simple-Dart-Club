//
//  SwiftUIView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct FirstScreen: View {
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                
                Spacer()

                Text("Player 1")
                
                TextField(
                    "",
                    text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 50)
                .textFieldStyle(.roundedBorder)
                .frame(width: 350)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .foregroundColor(.black)
                                
                Spacer()
                
                Text("Player 2")
                
                TextField(
                    "",
                    text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 50)
                .textFieldStyle(.roundedBorder)
                .frame(width: 350)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .foregroundColor(.black)

                Spacer()

                Text("+ Add a player")
               
                Spacer()

            }   .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold, design: .default))
                .shadow(radius: 10)

        }
    }
    
}

#Preview {
    FirstScreen()
}

//
//  ContentView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea(.all)
            VStack {
                
                Text("Dart   ")
                    .font(Font.custom("FightThis", size: 150))
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                    .padding([.trailing], 40)
                Text("Club   ")
                    .font(Font.custom("FightThis", size: 150))
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                    .padding([.trailing], 40)
                Text(" ")
                    .font(Font.custom("FightThis", size: 40))
                Text("Beta")
                    .font(Font.custom("FightThis", size: 50))
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    HomeView()
}

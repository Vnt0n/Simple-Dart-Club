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
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                Text("Club   ")
                    .font(Font.custom("FightThis", size: 150))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    HomeView()
}

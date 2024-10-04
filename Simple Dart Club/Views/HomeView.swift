//
//  HomeView.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
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
                    .padding(.bottom, -40)
                    .padding(.top, -40)
                
                Text("Simple  ")
                    .font(Font.custom("FightThis", size: 30))
                    .shadow(color: Color.red, radius: 10)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                    .padding([.trailing], 30)
                
                Text("Club   ")
                    .font(Font.custom("FightThis", size: 150))
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                    .padding([.trailing], 40)
                    .padding(.top, -60)
                    .padding(.bottom, 40)

            }
        }
        .statusBarHidden(true)
    }
}


// ///////////////////////////
// PREVIEW //////////////////

#Preview {
    HomeView()
}

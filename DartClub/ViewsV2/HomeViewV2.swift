//
//  HomeViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct HomeViewV2: View {
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
                Text("Beta V3")
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20, design: .default))
                    .shadow(color: Color.red, radius: 15)
            }
        }
    }
}


// ///////////////////////////
// PREVIEW //////////////////

#Preview {
    HomeViewV2()
}

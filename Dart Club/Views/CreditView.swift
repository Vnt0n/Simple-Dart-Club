//
//  CreditView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct CreditView: View {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {

        ZStack {
            VStack {
                
                Text("Dart   ")
                    .font(Font.custom("FightThis", size: 50))
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                    .padding([.trailing], 40)
                    .padding(.top, 30)
                
                Text("Club   ")
                    .font(Font.custom("FightThis", size: 50))
                    .shadow(color: Color.red, radius: 15)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .rotationEffect(Angle(degrees: 347))
                    .frame(maxWidth: .infinity)
                    .padding([.trailing], 40)
                
                Spacer()

                Text("An app provided by")
                    .font(
                        .system(size: 20)
                        .weight(.bold))
                
                Spacer()

                
                Link("github.com/Vnt0n", destination: URL(string: "https://github.com/Vnt0n")!)
//                .lineSpacing(10)
//                .multilineTextAlignment(.center)
                
                Spacer()

                Text("Beta V.3.0")
                    .font(
                        .system(size: 10))
                
                Spacer()
                
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                        .font(.system(size: 18))
                }
                .padding()
                .frame(maxWidth: 200)
                
                Spacer()
                
            }
            .frame(maxWidth: 300)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    CreditView()
}

//
//  CreditViewV2.swift
//  DartClub
//
//  Created by Antoine on 26/04/2024.
//

import SwiftUI

struct CreditViewV2: View {
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

                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque hendrerit non lectus ut auctor. Aliquam cursus a enim quis vehicula. Mauris quis sem interdum, lobortis odio vitae, suscipit ipsum. Mauris volutpat augue pulvinar arcu aliquam sodales maximus vitae urna. Suspendisse congue aliquet risus tempor scelerisque.")
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                
                Spacer()

                Text("Beta V.3.0")
                    .font(
                        .system(size: 10))
                
                Spacer()

            }
            .frame(maxWidth: 300)
        }
        
    }
}

#Preview {
    CreditViewV2()
}

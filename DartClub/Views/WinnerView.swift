//
//  Contentview.swift
//  DartClub
//
//  Created by Antoine on 29/03/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct WinnerView: View {
    
    @State private var counter = 0
    var namePlayer: String
    
    var body: some View {
        VStack {
            Text("0")
                .padding([.bottom], 10)
                .font(.system(size: 140, weight: .bold, design: .default))
            Text(namePlayer)
                .padding([.bottom], 10)
            Button(action: {
                counter += 1
            }) {
                Text("You won!")
                    .font(.system(size: 50, weight: .bold, design: .default))
            }
            .confettiCannon(counter: $counter, num: 150, radius: 500.0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.counter += 1
                }
            }
        }
    }
}

#Preview {
    WinnerView(namePlayer: "namePlayer")
}

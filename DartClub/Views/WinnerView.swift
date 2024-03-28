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
    
    var body: some View {
        Button(action: {
            counter += 1
        }) {
            Text("You won!")
                .font(.system(size: 50))
        }
        .confettiCannon(counter: $counter, num: 100, radius: 500.0)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.counter += 1
            }
        }
    }
}

#Preview {
    WinnerView()
}

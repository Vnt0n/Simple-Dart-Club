//
//  TestView.swift
//  DartClub
//
//  Created by Antoine on 29/03/2024.
//

import SwiftUI

struct TestView: View {
    
    @State private var isButtonClicked = false
    
    var body: some View {
                
        NavigationStack {
            Button("OK          ") {
                isButtonClicked = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .navigationDestination(isPresented: $isButtonClicked) {
                WinnerView(namePlayer1: "")
            }
        }
    }
}

#Preview {
    TestView()
}

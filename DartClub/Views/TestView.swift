//
//  TestView.swift
//  DartClub
//
//  Created by Antoine on 29/03/2024.
//

import SwiftUI

struct TestView: View {
    
    @State private var isButtonClicked = false
    @State private var namePlayer1 = ""

    
    var body: some View {
                
        NavigationStack {
            TextField("Enter Player Name", text: $namePlayer1)
                            .textFieldStyle(.roundedBorder)
                            .padding()
            Button("OK          ") {
                isButtonClicked = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .navigationDestination(isPresented: $isButtonClicked) {
                WinnerView(namePlayer1: namePlayer1)
            }
        }
    }
}

#Preview {
    TestView()
}

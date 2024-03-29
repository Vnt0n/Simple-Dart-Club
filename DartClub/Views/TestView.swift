//
//  TestView.swift
//  DartClub
//
//  Created by Antoine on 29/03/2024.
//

import SwiftUI

struct TestView: View {
    
    @State private var isButtonClicked = false
    @State private var namePlayer = ""

    
    var body: some View {
                
        NavigationStack {
            TextField("Enter Player Name", text: $namePlayer)
                            .textFieldStyle(.roundedBorder)
                            .padding()
            Button("OK          ") {
                isButtonClicked = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .navigationDestination(isPresented: $isButtonClicked) {
                WinnerView(namePlayer: namePlayer)
            }
        }
    }
}

#Preview {
    TestView()
}

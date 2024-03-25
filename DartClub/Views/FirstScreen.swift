//
//  SwiftUIView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct FirstScreen: View {
    
    var body: some View {
        NavigationView {
            NavigationLink("Back") {
                HomeView()
            }
        }
    }
}

#Preview {
    FirstScreen()
}

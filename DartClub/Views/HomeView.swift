//
//  ContentView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
       
            Image("dartClub-cover")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
        }
    }
      
}

#Preview {
    HomeView()
}

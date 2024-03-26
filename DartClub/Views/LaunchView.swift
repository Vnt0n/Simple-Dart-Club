//
//  LaunchView.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        HomeView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
            .background(
                NavigationLink(
                    destination: FirstScreen(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
            )
    }
}



#Preview {
    LaunchView()
}

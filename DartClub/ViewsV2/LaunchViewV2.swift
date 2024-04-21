//
//  LaunchViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct LaunchViewV2: View {
  @State private var isActive: Bool = false

  var body: some View {
    NavigationStack {
      HomeViewV2()
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isActive = true
          }
        }
        .navigationDestination(isPresented: $isActive) {
          FirstViewV2()
        }
    }
    .preferredColorScheme(.light)
  }
}

#Preview {
    LaunchViewV2()
}

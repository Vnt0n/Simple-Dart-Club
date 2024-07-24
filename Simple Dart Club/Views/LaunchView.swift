//
//  LaunchView.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct LaunchView: View {
  @State private var isActive: Bool = false

  var body: some View {
    NavigationStack {
      HomeView()
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isActive = true
          }
        }
        .navigationDestination(isPresented: $isActive) {
          FirstView()
        }
    }
  }
}


// ///////////////////////////
// PREVIEW //////////////////

#Preview {
    LaunchView()
}

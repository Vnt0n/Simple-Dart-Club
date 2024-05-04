//
//  Dart_ClubApp.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

@main
struct Dart_ClubApp: App {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

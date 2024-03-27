//
//  DartClubApp.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI
import SwiftData

@main
struct DartClubApp: App {
    var body: some Scene {
        WindowGroup {
                LaunchView()
        }
        .modelContainer(for: Player.self)
    }
}

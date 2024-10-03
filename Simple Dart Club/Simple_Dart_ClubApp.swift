//
//  Dart_ClubApp.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

@main
struct Simple_Dart_ClubApp: App {
    @AppStorage("appLanguage") var appLanguage: AppLanguage = {
        // Si une langue est déjà stockée, elle est retournée, sinon la langue du système est utilisée
        if let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage"), let language = AppLanguage(rawValue: savedLanguage) {
            return language
        }
        // Utilise la langue système si aucune langue n'est stockée
        if let systemLanguage = Locale.preferredLanguages.first, let language = AppLanguage(rawValue: systemLanguage.prefix(2).description) {
            return language
        }
        // Par défaut, anglais si aucune langue n'est trouvée
        return .english
    }()

    var body: some Scene {
        WindowGroup {
            FirstView()
                .environment(\.locale, .init(identifier: appLanguage.rawValue))
        }
    }
}

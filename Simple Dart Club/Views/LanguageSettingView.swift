//
//  LanguageSetting.swift
//  Simple Dart Club
//
//  Created by Antoine on 03/10/2024.
//

import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case english = "en"
    case french = "fr"
    case german = "de"
    case spanish = "es"
    case japanese = "ja"
    case chinese = "zh-Hans"
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .french: return "Français"
        case .german: return "Deutsch"
        case .spanish: return "Español"
        case .japanese: return "日本語"
        case .chinese: return "简体中文"
        }
    }
}

struct LanguageSettingView: View {
    @AppStorage("appLanguage") private var appLanguageCode: String = Locale.preferredLanguages.first?.prefix(2).description ?? "en"
    @Environment(\.dismiss) var dismiss
    
    private var appLanguage: AppLanguage {
        AppLanguage(rawValue: appLanguageCode) ?? .english
    }

    var body: some View {
        VStack(alignment: .leading) {

            List {
                ForEach(AppLanguage.allCases) { language in
                    HStack {
                        Text(language.displayName)
                            .font(.title2)

                        Spacer()
                        
                        if appLanguage == language {
                            Image(systemName: "largecircle.fill.circle")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appLanguageCode = language.rawValue
                    }
                }
            }
            .frame(maxHeight: 350)

            Button(action: {
                dismiss()
            }) {
                Text("OK")
                    .font(.title3)
                    .bold()
                    .padding()
                    .frame(width: 120)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

#Preview {
    LanguageSettingView()
}

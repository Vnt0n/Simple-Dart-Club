//
//  SettingsView.swift
//  DartClub
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isToggled = false

    
    var body: some View {


        VStack {
            Toggle(isOn: $isToggled) {
                Text("Double Out")
            }
            .padding()
            
            Toggle(isOn: $isToggled) {
                Text("Activer la fonctionnalité")
            }
            .padding()
            
            Toggle(isOn: $isToggled) {
                Text("Activer la fonctionnalité")
            }
            .padding()
        }
        .foregroundColor(.black)
    }
}

#Preview {
    SettingsView()
}

//
//  Styling.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI


//  TextField

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 50)
            .textFieldStyle(.roundedBorder)
            .frame(width: 350)
            .multilineTextAlignment(.center)
            .disableAutocorrection(true)
            .foregroundColor(.black)
    }
}

extension View {
    public func TextFieldStyling() -> some View {
        modifier(TextFieldStyle())
    }
}

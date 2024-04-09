//
//  Styling.swift
//  DartClub
//
//  Created by Antoine on 26/03/2024.
//

import SwiftUI

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

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}

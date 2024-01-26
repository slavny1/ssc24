//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 26/1/2024.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 1) // Border
            )
    }
}

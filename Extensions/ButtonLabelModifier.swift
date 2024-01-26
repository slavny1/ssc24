//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 26/1/2024.
//

import SwiftUI

struct ButtonLabelModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
    }
}

//
//  TextField-NumExt.swift
//  SwiftStudentChallenge
//
//  Created by Вячеслав Горев on 25/12/2023.
//

import SwiftUI
import Combine

extension CustomTextField {
    func numericOnly(input: Binding<String>) -> some View {
        self.modifier(NumericOnly(input: input))
    }
}

struct NumericOnly: ViewModifier {
    @Binding var input: String
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(input)) { newValue in
                let filtered = newValue.filter { "-0123456789.".contains($0) }
                if filtered != newValue {
                    self.input = filtered
                }
            }
    }
}

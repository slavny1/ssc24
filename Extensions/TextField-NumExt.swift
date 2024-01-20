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
                let filtered = newValue
                    .replacingOccurrences(of: ",", with: ".")
                    .filter { "-0123456789,.".contains($0)
                    }
                if filtered != newValue {
                    self.input = filtered
                }
                
                // Ensure only one dot in the string
                if filtered.components(separatedBy: ".").count > 2 {
                    self.input = String(filtered.dropLast())
                }
                
                // Limit total characters to 7
                if filtered.count > 9 {
                    self.input = String(filtered.prefix(7))
                } else if filtered != newValue {
                    self.input = filtered
                }
            }
    }
}

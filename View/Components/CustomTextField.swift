//
//  SwiftUIView.swift
//  
//
//  Created by Вячеслав Горев on 25/12/2023.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var title: String

    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    var body: some View {
        HStack {
            TextField(title, text: $text)
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                }
            }
        }
    }
}

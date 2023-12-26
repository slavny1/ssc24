//
//  SwiftUIView.swift
//
//
//  Created by Вячеслав Горев on 26/12/2023.
//

import SwiftUI

struct CircleView: View {
    
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            ForEach(0..<180) { dot in
                if dot == 90 {
                    Text("N")
                        .offset(y: (width - 170) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.red)
                } else if dot == 0 {
                    Text("S")
                        .offset(y: (width - 170) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                        .font(.system(size: 24, weight: .semibold))
                } else if dot == 45 {
                    Text("W")
                        .offset(y: (width - 170) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                        .font(.system(size: 24, weight: .semibold))
                } else if dot == 135 {
                    Text("E")
                        .offset(y: (width - 170) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                        .font(.system(size: 24, weight: .semibold))
                }
                Rectangle()
                    .foregroundStyle(dot == 90 ? Color.red : Color.primary)
                    .frame(width: dot % 15 == 0 ? 2 : 1, height: dot % 15 == 0 ? 15 : 10)
                    .offset(y: (width - 110) / 2)
                    .rotationEffect(.init(degrees: Double(dot) * 2))
                if dot % 15 == 0 {
                    Text("\(dot >= 90 ? abs(180 - dot * 2) : abs(180 + dot * 2))")
                        .offset(y: (width - 50) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                }
            }
            Circle()
                .frame(width: 5)
        }
    }
}

#Preview {
    CircleView()
}

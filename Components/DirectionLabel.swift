//
//  SwiftUIView.swift
//  
//
//  Created by Viacheslav on 18/01/24.
//

import SwiftUI

struct DirectionLabel: View {
    let text: String
    let rotation: Double
    let dot: Double
    let width: CGFloat

    var body: some View {
        HStack {
            Text(text)
                .rotationEffect(.init(degrees: rotation))
        }
        .offset(y: (width - 65) / 2)
        .rotationEffect(.init(degrees: dot))
        .font(.system(size: 24, weight: .semibold))
    }
}

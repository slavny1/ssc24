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
        .offset(y: (width - 170) / 2)
        .rotationEffect(.init(degrees: dot * 2))
        .font(.system(size: 24, weight: .semibold))
    }
}

//
//  SwiftUIView.swift
//
//
//  Created by Viacheslav on 18/01/24.
//

import SwiftUI

struct DirectionLabel: View {

    let rotation: Double
    let dot: Int
    let width: CGFloat

    var body: some View {
        HStack {
            switch dot {
            case 0:
                labelWithText("S", rotation: -rotation)
            case 90:
                labelWithText("W", rotation: 270 - rotation)
            case 180:
                labelWithText("N", rotation: 180 - rotation)
                    .foregroundColor(.red)
            case 270:
                labelWithText("E", rotation: 90 - rotation)
            case let d where d % 30 == 0:
                labelWithText("\(abs(180 - d))", rotation: 360 - Double(d) - rotation, fontSize: 16, fontWeight: .light)
            default:
                EmptyView()
            }
        }
        .offset(y: (width - 30))
        .rotationEffect(.degrees(Double(dot)))
    }

    private func labelWithText(_ text: String, rotation: Double, fontSize: CGFloat = 24, fontWeight: Font.Weight = .semibold) -> some View {
        Text(text)
            .rotationEffect(.degrees(rotation))
            .font(.system(size: fontSize, weight: fontWeight))
    }
}

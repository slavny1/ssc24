//
//  SwiftUIView.swift
//
//
//  Created by Вячеслав Горев on 26/12/2023.
//

import SwiftUI
import SwiftData

struct CircleView: View {
    @Binding var north: Double

    let width = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            ForEach(0..<180) { dot in
                if dot == 90 {
                    DirectionLabel(text: "N", rotation: 180 - north, dot: Double(dot), width: width)
                    .foregroundColor(.red)
                } else if dot == 0 {
                    DirectionLabel(text: "S", rotation: -north, dot: Double(dot), width: width)
                } else if dot == 45 {
                    DirectionLabel(text: "W", rotation: 270 - north, dot: Double(dot), width: width)
                } else if dot == 135 {
                    DirectionLabel(text: "E", rotation: 90 - north, dot: Double(dot), width: width)
                }

                Rectangle()
                    .foregroundStyle(dot == 90 ? Color.red : Color.primary)
                    .frame(width: dot % 15 == 0 ? 2 : 1, height: dot % 15 == 0 ? 15 : 10)
                    .offset(y: (width - 110) / 2)
                    .rotationEffect(.init(degrees: Double(dot) * 2))

                if dot % 15 == 0 {
                    HStack {
                        Text("\(dot >= 90 ? abs(180 - dot * 2) : abs(180 + dot * 2))")
                            .rotationEffect(.init(degrees: 360 - Double(dot) * 2 - north))
                    }
                    .offset(y: (width - 50) / 2)
                    .rotationEffect(.init(degrees: Double(dot) * 2))
                }
            }
            Circle()
                .frame(width: 5)
        }
    }
}

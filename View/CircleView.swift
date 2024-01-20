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
    var anglesArray: [Int]
    
    let width = UIScreen.main.bounds.width
    @State var firstNorth = 0
    
    var body: some View {
        ZStack {
            
            ForEach(0..<360) { dot in
                if dot == 180 {
                    DirectionLabel(text: "N", rotation: 180 - north, dot: Double(dot), width: width)
                        .foregroundColor(.red)
                } else if dot == 0 {
                    DirectionLabel(text: "S", rotation: -north, dot: Double(dot), width: width)
                } else if dot == 90 {
                    DirectionLabel(text: "W", rotation: 270 - north, dot: Double(dot), width: width)
                } else if dot == 270 {
                    DirectionLabel(text: "E", rotation: 90 - north, dot: Double(dot), width: width)
                } else if dot % 30 == 0 {
                    HStack {
                        Text("\(dot >= 180 ? abs(180 - dot) : abs(180 + dot))")
                            .font(.system(size: 16, weight: .light))
                            .rotationEffect(.degrees(360 - Double(dot) - north))
                    }
                    .offset(y: (width - 65) / 2)
                    .rotationEffect(.degrees(Double(dot)))
                }
                
                if anglesArray.contains(dot) {
                    Circle()
                        .foregroundStyle(Color.red)
                        .frame(width: 4, height: 4)
                        .offset(y: (width - 150) / 2)
                        .rotationEffect(.degrees(180 - Double(firstNorth) + Double(dot)))
                }
                
                if dot % 2 == 0 {
                    Rectangle()
                        .foregroundStyle(dot == 180 ? Color.red : Color.primary)
                        .frame(width: dot % 30 == 0 ? 2 : 1, height: dot % 30 == 0 ? 15 : 10)
                        .offset(y: dot % 15 == 0 ? (width - 125) / 2 : (width - 130) / 2)
                        .rotationEffect(.degrees(Double(dot)))
                }
            }
            Text("\((360 - north), specifier: "%.0f")°")
                .font(.system(size: 36, weight: .regular))
                .rotationEffect(.degrees(-north))
        }
        .onAppear() {
            firstNorth = Int(north)
        }
    }
}

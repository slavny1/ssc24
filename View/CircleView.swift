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
                    HStack {
                        Text("N")
                            .rotationEffect(.init(degrees: 180 - north))
                    }
                    .offset(y: (width - 170) / 2)
                    .rotationEffect(.init(degrees: Double(dot) * 2))
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.red)
                } else if dot == 0 {
                    HStack {
                        Text("S")
                            .rotationEffect(.init(degrees: -north))
                    }
                        .offset(y: (width - 170) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                        .font(.system(size: 24, weight: .semibold))
                } else if dot == 45 {
                    HStack {
                        Text("W")
                            .rotationEffect(.init(degrees: 270 - north))
                    }
                        .offset(y: (width - 170) / 2)
                        .rotationEffect(.init(degrees: Double(dot) * 2))
                        .font(.system(size: 24, weight: .semibold))
                } else if dot == 135 {
                    HStack {
                        Text("E")
                            .rotationEffect(.init(degrees: 90 - north))
                    }
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
                    HStack {
                        Text("\(360 - dot * 2)")
                            .rotationEffect(.init(degrees: 360 - Double(dot) * 2 - north))
                    }
                    .offset(y: (width - 50) / 2)
                    .rotationEffect(.init(degrees: Double(dot) * 2))
                }
                //                if anglesArray.contains(dot) || anglesArray.contains(dot + 1) {
                //                    Rectangle()
                //                        .foregroundStyle(Color.red)
                //                        .frame(width: 2, height: 15)
                //                        .offset(y: (width - 110) / 2)
                //                        .rotationEffect(.init(degrees: Double(dot) * 2))
                //                }
            }
            Circle()
                .frame(width: 5)
        }
    }

}

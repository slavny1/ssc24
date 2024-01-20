//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

extension ContentView {

    private var maxWidth: CGFloat { min(UIScreen.main.bounds.width / 2, 195) }
    
    func initializeAnglesArray() {
        if let home = points.first(where: { $0.home }) {
            anglesArray = points
                .filter{ !$0.home }
                .map {
                    Int(viewModel.calculateAdjustedAngle(
                        pointOne: home,
                        pointTwo: $0)
                    )
                }
        }
    }
    
    func drawCompass() -> some View {
        ZStack {
            ForEach(0..<360) { dot in
                
                DirectionLabel(rotation: viewModel.north, dot: dot, width: maxWidth)
                
                if anglesArray.contains(dot) {
                    Circle()
                        .foregroundStyle(Color.red)
                        .frame(width: 4, height: 4)
                        .offset(y: (maxWidth - 75))
                        .rotationEffect(.degrees(Double(firstNorth) + Double(dot)))
                }
                
                if dot % 2 == 0 {
                    Rectangle()
                        .foregroundStyle(dot == 180 ? Color.red : Color.primary)
                        .frame(width: dot % 30 == 0 ? 2 : 1, height: dot % 30 == 0 ? 15 : 10)
                        .offset(y: dot % 15 == 0 ? (maxWidth - 60) : (maxWidth - 63))
                        .rotationEffect(.degrees(Double(dot)))
                }
            }
        }
        .rotationEffect(Angle(degrees: viewModel.north))
    }
    
    func drawHeadingLabel() -> some View {
        ZStack {
            Triangle()
                .fill(Color.red)
                .frame(width: 15, height: 15)
                .offset(y: (maxWidth - 305))
            Text(headingLabel(for: viewModel.north))
                .font(.system(size: 36, weight: .regular))
        }
    }
    
    private func headingLabel(for heading: Double) -> String {
        let degrees = String(format: "%.0f", heading) + "°"
        
        switch heading {
        case 337...360, 0..<24:
            return degrees + " N"
        case 24..<69:
            return degrees + " NW"
        case 69..<114:
            return degrees + " W"
        case 114..<159:
            return degrees + " SW"
        case 159..<204:
            return degrees + " S"
        case 204..<249:
            return degrees + " SE"
        case 249..<294:
            return degrees + " E"
        case 294..<337:
            return degrees + " NE"
        default:
            return degrees
        }
    }
}

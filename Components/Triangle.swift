//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Define the triangle points
        let topPoint = CGPoint(x: rect.width / 2, y: rect.origin.y)
        let bottomLeftPoint = CGPoint(x: rect.origin.x, y: rect.maxY)
        let bottomRightPoint = CGPoint(x: rect.maxX, y: rect.maxY)

        // Move to the top point
        path.move(to: topPoint)

        // Add lines to form the triangle
        path.addLine(to: bottomLeftPoint)
        path.addLine(to: bottomRightPoint)
        path.addLine(to: topPoint)

        return path
    }
}

//
//  File.swift
//
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

extension ContentView {

    private var maxWidth: CGFloat { min(UIScreen.main.bounds.width / 2, 195) }

    /// Initializes the `anglesArray` property based on the angles between the home point and other non-home points. The function calculates the adjusted angles between the home point and each non-home point in the `points` array and populates the `anglesArray` with the resulting angles.
    /// Warning: The function relies on the existence of a home point in the `points` array to perform calculations. Ensure that the `points` array contains a home point, and the `viewModel` is appropriately configured.
    func initializeAnglesArray() {
        if let home = points.first(where: { $0.home }) {
            anglesArray = points
                .filter{ !$0.home }
                .map {
                    Int(round(viewModel.calculateAdjustedAngle(
                        pointOne: home,
                        pointTwo: $0)
                    ))
                }
        }
    }

    func drawCompass() -> some View {
        ZStack {
            ForEach(0..<360) { dot in

                DirectionLabel(rotation: viewModel.north, dot: dot, width: maxWidth)

                if anglesArray.contains(dot) {

                    // Rotation effect for a circle calculated from initial north position and point's angle in anglesArray which is calculated from phone heading and north.

                    // TODO: There is might be bug. Need to test with bearing more than 180 degrees. Might be need truncated 360.

                    Circle()
                        .foregroundStyle(Color.red)
                        .frame(width: 5)
                        .offset(y: (maxWidth - 75))
                        .rotationEffect(.degrees(Double(firstNorth) + Double(dot)))
                }

                if dot % 2 == 0 {
                    Rectangle()
                        .foregroundStyle(dot == 180 ? Color.red : Color.primary)
                        .frame(width: dot % 30 == 0 ? 2 : 1, height: dot % 30 == 0 ? 15 : 10)
                        .offset(y: dot % 30 == 0 ? (maxWidth - 60) : (maxWidth - 63))
                        .rotationEffect(.degrees(Double(dot)))
                }
            }
        }
        .rotationEffect(.degrees(viewModel.north))
    }

    // Small little triangle to point phone's Heading
    func drawHeadingLabel() -> some View {
        ZStack {
            Triangle()
                .fill(Color.red)
                .frame(width: 15, height: 15)
                .offset(y: (maxWidth - 305))
            if let index = anglesArray.firstIndex(of: currentHeading) {
                VStack {
                    if let profileImageData = points.filter({ $0.home == false })[index].profileImage, let uiImage = UIImage(data: profileImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: maxWidth)
                            .clipShape(Circle())
                    } else {
                        Text(headingLabel(for: 360 - viewModel.north))
                            .font(.system(size: 24, weight: .regular))
                        Rectangle()
                            .frame(width: 100, height: 1)
                        let label = points.filter { $0.home == false } [index].name
                        Text(label)
                            .font(.system(size: 24, weight: .regular))
                    }
                }
            } else {
                Text(headingLabel(for: 360 - viewModel.north))
                    .font(.system(size: 36, weight: .regular))
            }
        }
    }

    private func headingLabel(for heading: Double) -> String {
        let degrees = String(format: "%.0f", heading) + "°"

        switch heading {
        case 337...360, 0..<24:
            return degrees + " N"
        case 24..<69:
            return degrees + " NE"
        case 69..<114:
            return degrees + " E"
        case 114..<159:
            return degrees + " SE"
        case 159..<204:
            return degrees + " S"
        case 204..<249:
            return degrees + " SW"
        case 249..<294:
            return degrees + " W"
        case 294..<337:
            return degrees + " NW"
        default:
            return degrees
        }
    }
}

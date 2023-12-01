//
//  Point.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 01/12/23.
//

import Foundation
import SwiftUI

final class Point {

    private let latitude: Double
    private let longtitude: Double

    var name: String = "random name"
    var home: Bool = false

    lazy var latRad = makeRadians(latitude)
    lazy var longRad = makeRadians(longtitude)

    init(latitude: Double, longtitude: Double) {
        self.latitude = latitude
        self.longtitude = longtitude
    }

    private func makeRadians(_ coordinate: Double) -> Double {
        return coordinate * .pi / 180
    }
}


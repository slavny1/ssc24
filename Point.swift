//
//  Point.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 01/12/23.
//

import Foundation
import SwiftUI

final class Point: Identifiable {

    var lat: Double
    var lng: Double

    var name: String

    lazy var latRad = makeRadians(lat)
    lazy var lngRad = makeRadians(lng)

    init(lat: Double, lng: Double, name: String) {
        self.lat = lat
        self.lng = lng
        self.name = name
    }

    private func makeRadians(_ coordinate: Double) -> Double {
        return coordinate * .pi / 180
    }
}

var points = [
    Point(lat: 52.10268847827439, lng: 23.729019036688, name: "Brest"),
//    Point(lat: 52.10268847827439, lng: -23.729019036688, name: "Brest with neg lng"),
//    Point(lat: -52.10268847827439, lng: 23.729019036688, name: "Brest with neg lat"),
//    Point(lat: -52.10268847827439, lng: -23.729019036688, name: "Brest with neg coord"),
//    Point(lat: 90, lng: 0, name: "North Pole")
]

var home = Point(lat: 40.8375713597235, lng: 14.302335735241893, name: "Naples")


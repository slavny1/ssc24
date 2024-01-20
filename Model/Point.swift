//
//  Point.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 01/12/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Point: Identifiable {
    
    @Attribute (.unique) var name: String
    
    var lat: Double
    var lng: Double
    
    var home: Bool

    init(lat: Double, lng: Double, name: String, home: Bool) {
        self.lat = lat
        self.lng = lng
        self.name = name
        self.home = home
    }
}

//var home = Point(lat: 40.8375713597235, lng: 14.302335735241893, name: "Naples")

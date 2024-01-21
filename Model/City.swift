//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import Foundation

struct City: Codable {
    
    var country: String
    var name: String
    var lat: String
    var lng: String
    
    init(country: String, name: String, lat: String, lng: String) {
        self.country = country
        self.name = name
        self.lat = lat
        self.lng = lng
    }
}

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
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case lat
        case lng
    }
}

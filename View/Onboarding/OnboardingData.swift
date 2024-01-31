//
//  File.swift
//  
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import Foundation

struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let primaryText: String
    let secondaryText: String
    let image: String

    static let list: [OnboardingData] = [
        OnboardingData(id: 0, primaryText: "Hey, I'm Slava!", secondaryText: "I'm excited to introduce an app that's designed for Swift Studen Challenge 2024 and helps you feel closer to your friends and family", image: "Hello"),
        OnboardingData(id: 1, primaryText: "Navigate to Friends with Ease", secondaryText: "Inspired by the compass guiding Muslims to Mecca, this app helps you always head in the right direction to those you care about", image: "Navigate"),
        OnboardingData(id: 2, primaryText: "Enter your current location", secondaryText: "I don't use networking to retrieve your location because of contest rules. Choose your city from the list or enter coordinates manually", image: "Family"),
        OnboardingData(id: 3, primaryText: "Ready to Navigate!", secondaryText: "Naples is set as your first friend location because I live here :)\nAdd more locations of your friends anytime!", image: "Welcome")
    ]
}

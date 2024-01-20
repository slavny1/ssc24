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

    static let list: [OnboardingData] = [
        OnboardingData(id: 0, primaryText: "Hey, I'm Slava!", secondaryText: "I'm excited to introduce an app that's designed to help you feel closer to your friends and family"),
        OnboardingData(id: 1, primaryText: "Navigate to Friends with Ease", secondaryText: "Inspired by the compass guiding Muslims to Mecca, our app helps you always head in the right direction to those you care about"),
        OnboardingData(id: 2, primaryText: "Offline Mode for Contest Submission", secondaryText: "Please fill in your home coordinates or choose from a list of locations"),
        OnboardingData(id: 3, primaryText: "Ready to Navigate!", secondaryText: "Naples is set as your first friend location because I live here :)\nAdd more locations anytime!")
    ]
}

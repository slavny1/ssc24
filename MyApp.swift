//
//  MyApp.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 19/11/23.
//

import SwiftUI

@main
struct MyApp: App {
    
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                NavigationStack {
                    ContentView()
                        .navigationTitle("Bussola mi")
                }
            } else {
                TabOnboardingView(completionHandler: {
                    hasCompletedOnboarding = true
                })
            }
        }
        .modelContainer(for: [Point.self])
    }
}

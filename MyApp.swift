//
//  MyApp.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 19/11/23.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationTitle("Bussola mi")
            }
        }
        .modelContainer(for: [Point.self])
    }
}

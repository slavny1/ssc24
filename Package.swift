// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Strings",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "Strings",
            targets: ["AppModule"],
            bundleIdentifier: "slavny1.SwiftStudentChallenge",
            teamIdentifier: "3523U23689",
            displayVersion: "1.2",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .location),
            accentColor: .asset("AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .lifestyle
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources/world_cities.json")
            ]
        )
    ]
)
// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aloha",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [
        .executableTarget(
            name: "aloha",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .testTarget(
            name: "alohaTests",
            dependencies: ["aloha"]),
    ]
)

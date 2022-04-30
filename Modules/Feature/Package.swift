// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "TransactionFeature", targets: ["TransactionFeature"])
    ],
    dependencies: [
        .package(name: "Core", path: "./Core"),
        .package(name: "Service", path: "./Service"),
        .package(name: "SharedUI", path: "./SharedUI")
    ],
    targets: [
        .target(name: "TransactionFeature", dependencies: [
            "Core",
            "SharedUI",
            .product(name: "FormatterService", package: "Service")
        ])
    ]
)
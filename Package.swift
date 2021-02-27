// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HHIBAN",
    products: [
        .library(
            name: "HHIBAN",
            targets: ["HHIBAN"]),
    ],
    dependencies: [
        .package(url: "https://github.com/HHuckebein/ISO3166-1Alpha2", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "HHIBAN",
            dependencies: ["ISO3166-1Alpha2"]),
        .testTarget(
            name: "HHIBANTests",
            dependencies: ["HHIBAN"]),
    ]
)

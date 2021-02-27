// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HHIBAN",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v10),
        .watchOS(.v5),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "HHIBAN",
            targets: ["HHIBAN"]),
    ],
    dependencies: [
        .package(name: "ISO3166_1Alpha2",
                 url: "https://github.com/HHuckebein/ISO3166-1Alpha2",
                 from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "HHIBAN",
            dependencies: ["ISO3166_1Alpha2"]),
        .testTarget(
            name: "HHIBANTests",
            dependencies: ["HHIBAN"]),
    ]
)

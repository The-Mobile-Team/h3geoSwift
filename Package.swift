// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "h3geoSwift",
    products: [
        .library(
            name: "h3geoSwift",
            targets: ["h3SwiftWrapper", "h3_C_Lib"]),
    ],
    targets: [
        .target(
            name: "h3_C_Lib",
            path: "Sources/h3_C_Lib",
            publicHeadersPath: "include" // Specify the public headers path
        ),
        .target(
            name: "h3SwiftWrapper",
            dependencies: ["h3_C_Lib"],
            path: "Sources/h3SwiftWrapper"
        )
    ]
)

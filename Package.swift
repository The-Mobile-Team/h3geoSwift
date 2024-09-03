// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "h3geoSwift",
    platforms: [
      .iOS("16.0")
    ],
    products: [
        .library(
            name: "h3geoSwift",
            targets: ["h3SwiftWrapper", "h3_C_Lib"]),
    ],
    targets: [
        .target(
            name: "h3_C_Lib",
            publicHeadersPath: "include" // Specify the public headers path
        ),
        .target(
            name: "h3SwiftWrapper",
            dependencies: ["h3_C_Lib"]
        )
    ]
)

//let package = Package(
//    name: "UIModule",
//    platforms: [
//      .iOS("16.0")
//    ],
//    products: [
//        // Products define the executables and libraries a package produces, and make them visible to other packages.
//        .library(
//            name: "UIModule",
//            targets: ["UIModule"])
//    ],
//    dependencies: [
//       .package(name: "SnapSDK", url: "https://github.com/Snapchat/snap-kit-spm", .upToNextMajor(from: "2.5.0")),
//       .package(name: "SDWebImage", url: "https://github.com/SDWebImage/SDWebImage.git", .upToNextMajor(from: "5.10.0")),
//       .package(name: "SnapKit", url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
//    ],
//    targets: [
//        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
//        // Targets can depend on other targets in this package, and on products in packages this package depends on.
//        .target(
//            name: "UIModule",
//            dependencies: ["SnapSDK", "SDWebImage", "SnapKit"]),
//        .testTarget(
//            name: "UIModuleTests",
//            dependencies: ["UIModule"])
//    ]
//)

// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIExtension",
    platforms: [
        .iOS(.v17),
        .watchOS(.v6)
    ],  
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftUIExtension",
            targets: ["SwiftUIExtension"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/Gaea-iOS/MobileCore.git",
            revision: "72d456f141489369b42bbc2f2367a774116059ac"
        ),
        .package(
            url: "https://github.com/apple/swift-collections.git",
                .upToNextMinor(from: "1.2.1")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftUIExtension",
            dependencies: [
                .product(name: "MobileCore", package: "MobileCore"),
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "SwiftUIExtensionTests",
            dependencies: ["SwiftUIExtension"]
        ),
    ]
)

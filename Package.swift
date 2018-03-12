// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommandsUtil",
    products: [
        .library(
            name: "CommandsUtil",
            targets: ["CommandsUtil"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/johnsundell/files.git",
            from: "2.0.0"
        )
    ],
    targets: [
        .target(
            name: "CommandsUtil",
            dependencies: ["Files"],
            path: "Sources"
        ),
        .testTarget(
            name: "CommandsUtilTests",
            dependencies: ["CommandsUtil", "Files"]
        ),
    ]
)

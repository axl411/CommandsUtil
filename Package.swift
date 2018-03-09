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
            url: "https://github.com/johnsundell/files.git"
        )
    ],
    targets: [
        .target(
            name: "CommandsUtil",
            path: "Sources",
            dependencies: ["Files"]
        ),
        .testTarget(
            name: "CommandsUtilTests",
            dependencies: ["CommandsUtil", "Files"]
        ),
    ]
)

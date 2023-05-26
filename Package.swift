// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "DocumentKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "DocumentKit",
            targets: ["DocumentKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DocumentKit",
            dependencies: []
        ),
        .testTarget(
            name: "DocumentKitTests",
            dependencies: ["DocumentKit"]
        )
    ]
)

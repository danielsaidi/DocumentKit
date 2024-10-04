// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DocumentKit",
    platforms: [
        .iOS(.v14),
        .visionOS(.v1)
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

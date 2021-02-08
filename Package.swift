// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftValidation",
    products: [
        .library(name: "SwiftValidation", targets: ["SwiftValidation"])
    ],
    targets: [
        .target(name: "SwiftValidation", dependencies: []),
        .testTarget(name: "SwiftValidationTests", dependencies: ["SwiftValidation"])
    ]
)

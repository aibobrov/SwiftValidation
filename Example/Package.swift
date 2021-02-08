// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Example",
    products: [
        .library(name: "Example", targets: ["Example"])
    ],
    dependencies: [
        .package(name: "SwiftValidation", path: "..")
    ],
    targets: [
        .target(name: "Example", resources: [.process("user.json")]),
        .testTarget(name: "ExampleTests",
                    dependencies: ["Example", "SwiftValidation"],
                    resources: [.process("user.json")])
    ]
)

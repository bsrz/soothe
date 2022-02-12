// swift-tools-version:5.5

import PackageDescription

extension String {
    static let storage = "Storage"

    static func test(for target: String) -> String { target + "Tests" }

    static let octokit = "OctoKit"
}

extension Target.Dependency {
    static let storage: Self = .init(stringLiteral: .storage)
}

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: .storage, targets: [.storage])
    ],
    dependencies: [
        .package(name: .octokit, url: "https://github.com/nerdishbynature/octokit.swift", from: "0.11.0"),
    ],
    targets: [
        .target(name: .storage, resources: [.process("Resources")]),
        .testTarget(name: .test(for: .storage), dependencies: [.storage])
    ]
)

// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Boomerang",
    platforms: [
        .iOS(.v11), .tvOS(.v11), .macOS(.v10_15), .watchOS(.v5)
    ],

    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "Boomerang", targets: ["Boomerang"]),
        .library(name: "RxBoomerang", targets: ["RxBoomerang"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Boomerang",
            dependencies: [], path: "Sources/Core"),
        .target(
        name: "RxBoomerang",
        dependencies: ["Boomerang", "RxSwift", "RxCocoa", "RxDataSources"], path: "Sources/Rx")
    ],
    swiftLanguageVersions: [.v5]
)

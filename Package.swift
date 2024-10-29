// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxStefan",
    products: [
        .library(
            name: "RxStefan",
            targets: ["RxStefan"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/appunite/Stefan",
            from: "0.4.1"
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            from: "6.8.0"
        )
    ],
    targets: [
        .target(
            name: "RxStefan",
            dependencies: [
                .product(
                    name: "RxCocoa",
                    package: "RxSwift"
                ),
                .product(
                    name: "RxSwift",
                    package: "RxSwift"
                ),
                .product(
                    name: "Stefan",
                    package: "Stefan"
                )
            ]
        ),
        .testTarget(
            name: "RxStefanTests",
            dependencies: ["RxStefan"]
        ),
    ]
)

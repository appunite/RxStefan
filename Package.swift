// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxStefan",
    products: [
        .library(
            name: "RxStefan",
            targets: ["RxStefan"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            exact: "6.5.0"
        ),
        .package(
            url: "https://github.com/appunite/Stefan",
            exact: "0.4.0"
        )
    ],
    targets: [
        .target(
            name: "RxStefan",
            dependencies: [
                .product(
                    name: "RxSwift",
                    package: "RxSwift"
                ),
                .product(
                    name: "RxCocoa",
                    package: "RxSwift"
                )
            ]
        ),
        .testTarget(
            name: "RxStefanTests",
            dependencies: ["RxStefan"]),
    ]
)

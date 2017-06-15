// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
  name: "vapor-redis-performance",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .executable(name: "vapor-redis-performance", targets: ["vapor-redis-performance"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/vapor/redis.git", .upToNextMajor(from: "2.0.0")),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "vapor-redis-performance",
      dependencies: ["Redis"]),
    .testTarget(
      name: "vapor-redis-performanceTests",
      dependencies: ["vapor-redis-performance"]),
  ]
)

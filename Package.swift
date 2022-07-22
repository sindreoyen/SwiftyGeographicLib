// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftyGeographicLib",
  platforms: [.macOS(.v12)],
  products: [
    .library(
      name: "SwiftyGeographicLib",
      targets: ["SwiftyGeographicLib"]),
  ],
  dependencies: [
    .package(name: "CGeographicLib", url: "https://github.com/firecrestHorizon/CGeographicLib.git", branch: "main")
  ],
  targets: [
    .target(
      name: "SwiftyGeographicLib",
      dependencies: ["CGeographicLib"]),
    .testTarget(
      name: "SwiftyGeographicLibTests",
      dependencies: ["SwiftyGeographicLib"]),
  ]
)

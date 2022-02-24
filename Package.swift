// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftyGeographicLib",
  platforms: [.macOS(.v11)],
  products: [
    .library(
      name: "SwiftyGeographicLib",
      targets: ["SwiftyGeographicLib"]),
  ],
  dependencies: [
    //.package(name: "CGeographicLib", url: "https://github.com/firecrestHorizon/CGeographicLib.git", from: "0.1.0"),
    .package(name: "CGeographicLib", url: "/Users/kieran/codeProjects/HorizonGTS/CGeographicLib", branch: "main")
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

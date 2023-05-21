// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "Swime",
  platforms: [
    .iOS("14.7"),
    .watchOS("7.1.0"),
    .macOS(.v10_15),
    .tvOS("14.7")
  ],
  products: [
    .library(name: "Swime", targets: ["Swime"])
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", from: "3.1.2"),
    .package(url: "https://github.com/Quick/Nimble", from: "9.2.1")
  ],
  targets: [
    .target(
      name: "Swime",
      path: "./Sources"
   ),
    .testTarget(
      name: "SwimeTests",
      dependencies: [
        "Swime",
        "Quick",
        "Nimble"
      ]
    )
  ]
)

// swift-tools-version: 5.5

import PackageDescription

let settings: [SwiftSetting] = [
	 .unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"])
]

let package = Package(
	name: "MainOffender",
	platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
	products: [
		.library(name: "MainOffender", targets: ["MainOffender"]),
	],
	targets: [
		.target(name: "MainOffender", swiftSettings: settings),
		.testTarget(
			name: "MainOffenderTests",
			dependencies: ["MainOffender"],
			swiftSettings: settings
		),
	]
)

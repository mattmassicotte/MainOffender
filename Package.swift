// swift-tools-version: 5.8

import PackageDescription

let package = Package(
	name: "MainOffender",
	platforms: [
		.macOS(.v10_15),
		.macCatalyst(.v13),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6),
	],
	products: [
		.library(name: "MainOffender", targets: ["MainOffender"]),
	],
	targets: [
		.target(name: "MainOffender"),
		.testTarget(
			name: "MainOffenderTests",
			dependencies: ["MainOffender"]
		),
	]
)

let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency"),
	.enableUpcomingFeature("GlobalActorIsolatedTypesUsability"),
]

for target in package.targets {
	var settings = target.swiftSettings ?? []
	settings.append(contentsOf: swiftSettings)
	target.swiftSettings = settings
}

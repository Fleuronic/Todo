// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "Presentation",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "Presentation",
			targets: [
				"Metrics",
				"Assets",
				"Styles"
			]
		)
	],
	dependencies: [
		.package(name: "Model", path: "../Model"),
		.package(url: "https://github.com/Fleuronic/Metric.git", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Telemetric.git", branch: "main")
	],
	targets: [
		.target(
			name: "Metrics",
			dependencies: [
				"Metric"
			]
		),
		.target(
			name: "Assets",
			dependencies: [
				"Telemetric",
				"Metrics"
			],
			resources: [.process("Resources")]
		),
		.target(
			name: "Styles",
			dependencies: [
				"Model",
				"Telemetric",
				"Assets",
				"Metrics"
			]
		)
	]
)

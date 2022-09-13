// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "Features",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "Root",
			targets: ["Root"]
		),
		.library(
			name: "Welcome",
			targets: ["Welcome"]
		),
		.library(
			name: "Todo",
			targets: ["Todo"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/square/workflow-swift", from: "1.0.0-rc.1"),
		.package(url: "https://github.com/Fleuronic/BackStackContainer", .branch("main")),
		.package(url: "https://github.com/Fleuronic/Ergo", .branch("main")),
		.package(url: "https://github.com/Fleuronic/Geometric", .branch("main")),
		.package(url: "https://github.com/Fleuronic/Telemetric", .branch("main")),
		.package(url: "https://github.com/Lighter-swift/Lighter", from: "1.0.0"),
		.package(name: "Model", path: "../Model"),
		.package(name: "EmailableAPI", path: "../Emailable API"),
		.package(name: "Presentation", path: "../Presentation")
	],
	targets: [
		.target(
			name: "Root",
			dependencies: [
				"BackStackContainer",
				"Todo",
				"Welcome"
			]
		),
		.testTarget(
			name: "RootTests",
			dependencies: [
				.product(name: "WorkflowTesting", package: "workflow-swift"),
				"Root"
			]
		),
		.target(
			name: "Welcome",
			dependencies: [
				"Ergo",
				"Geometric",
				"Telemetric",
				"Model",
				"EmailableAPI",
				"Presentation"
			]
		),
		.testTarget(
			name: "WelcomeTests",
			dependencies: [
				.product(name: "WorkflowTesting", package: "workflow-swift"),
				"Welcome"
			]
		),
		.target(
			name: "Todo",
			dependencies: [
				"Ergo",
				"BackStackContainer",
				"Lighter",
				"Geometric",
				"Telemetric",
				"Model",
				"Presentation"
			]
		),
		.testTarget(
			name: "TodoTests",
			dependencies: [
				.product(name: "WorkflowTesting", package: "workflow-swift"),
				"Todo"
			]
		)
	]
)

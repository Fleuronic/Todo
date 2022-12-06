// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "Features",
	platforms: [
		.iOS(.v16)
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
		.package(name: "Model", path: "../Model"),
		.package(name: "EmailableAPI", path: "../APIs/Emailable API"),
		.package(name: "Presentation", path: "../Presentation"),
		.package(url: "https://github.com/square/workflow-swift", from: "1.0.0-rc.1"),
		.package(url: "https://github.com/Fleuronic/BackStackContainer", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Ergo", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Geometric", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Telemetric", branch: "main")
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

// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "Model",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "Model",
			targets: ["Model"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Coffin", branch: "main"),
		.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0")
	],
	targets: [
		.target(
			name: "Model",
			dependencies: [
				"Coffin",
				"Identity"
			]
		),
		.testTarget(
			name: "ModelTests",
			dependencies: ["Model"]
		)
	]
)

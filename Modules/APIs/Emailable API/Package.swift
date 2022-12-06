// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "EmailableAPI",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "EmailableAPI",
			targets: ["EmailableAPI"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Emissary", branch: "main")
	],
	targets: [
		.target(
			name: "EmailableAPI",
			dependencies: ["Emissary"]
		),
		.testTarget(
			name: "EmailableAPITests",
			dependencies: ["EmailableAPI"]
		)
	]
)

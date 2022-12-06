// Copyright © Fleuronic LLC. All rights reserved.

public struct Username {
	public let rawValue: String

	public init(rawValue: String) {
		self.rawValue = rawValue.contains(.atSign) ? .init(rawValue.dropFirst()) : rawValue
	}
}

// MARK: -
public extension Username {
	var displayValue: String {
		rawValue.isEmpty ? .init() : "\(Character.atSign)\(rawValue)"
	}

	static var empty: Self {
		.init(rawValue: "")
	}

	static var regex: Regex<AnyRegexOutput> {
		try! Regex("[A-Za-z0-9_]")
	}
}

// MARK: -
extension Username: Equatable {}

extension Username: Codable {}

// MARK: -
private extension Character {
	static let atSign: Self = "@"
}

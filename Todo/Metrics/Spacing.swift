// Copyright © Fleuronic LLC. All rights reserved.

import CoreGraphics

public enum Spacing {}

// MARK: -
public extension Spacing {
	struct Horizontal {
		public let value: CGFloat
	}

	struct Vertical {
		public let value: CGFloat
	}
}

// MARK: -
public extension Spacing.Horizontal {
	static let zero: Self = 0
	static let `default`: Self = 8
}

// MARK: -
extension Spacing.Horizontal: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension Spacing.Vertical {
	static let zero: Self = 0
	static let `default`: Self = 8
}

// MARK: -
extension Spacing.Vertical: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

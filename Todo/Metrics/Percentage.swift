// Copyright © Fleuronic LLC. All rights reserved.

import CoreGraphics

public struct Percentage {
	let value: CGFloat
}

// MARK: -
public extension Percentage {
	static let full: Self = 1.0
	static let zero: Self = 0.0
}

// MARK: -
extension Percentage: Equatable {}

extension Percentage: ExpressibleByFloatLiteral {
	public init(floatLiteral: FloatLiteralType) {
		value = .init(floatLiteral)
	}
}

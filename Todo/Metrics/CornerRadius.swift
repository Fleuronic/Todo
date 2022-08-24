// Copyright © Fleuronic LLC. All rights reserved.

import UIKit

public enum Corner {}

public extension Corner {
	struct Radius {
		let value: CGFloat
	}
}

// MARK: -
extension Corner.Radius: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension UIView {
	var cornerRadius: Corner.Radius {
		get { .init(value: layer.cornerRadius) }
		set { layer.cornerRadius = newValue.value }
	}
}

// Copyright © Fleuronic LLC. All rights reserved.

import UIKit

public struct Opacity {
	let value: CGFloat
}

// MARK: -
public extension Opacity {
	static let full: Self = 1.0
}

// MARK: -
extension Opacity: ExpressibleByFloatLiteral {
	public init(floatLiteral: FloatLiteralType) {
		value = .init(floatLiteral)
	}
}

// MARK: -
public extension UIView {
	var opacity: Opacity {
		get { .init(value: alpha) }
		set { alpha = newValue.value }
	}
}

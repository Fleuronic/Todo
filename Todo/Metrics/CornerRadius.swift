// Copyright © Fleuronic LLC. All rights reserved.

import UIKit

public struct CornerRadius {
	let value: CGFloat
}

// MARK: -
extension CornerRadius: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension UIView {
	var cornerRadius: CornerRadius {
		get { .init(value: layer.cornerRadius) }
		set { layer.cornerRadius = newValue.value }
	}
}

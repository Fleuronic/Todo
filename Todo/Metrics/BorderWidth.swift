// Copyright © Fleuronic LLC. All rights reserved.

import UIKit

public struct BorderWidth {
	let value: CGFloat
}

// MARK: -
extension BorderWidth: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension UIView {
	var borderWidth: BorderWidth {
		get { .init(value: layer.borderWidth) }
		set { layer.borderWidth = newValue.value }
	}
}

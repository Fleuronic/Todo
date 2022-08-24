// Copyright © Fleuronic LLC. All rights reserved.

import UIKit

public enum Border {}

public extension Border {
	struct Width {
		let value: CGFloat
	}
}

// MARK: -
extension Border.Width: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension UIView {
	var borderWidth: Border.Width {
		get { .init(value: layer.borderWidth) }
		set { layer.borderWidth = newValue.value }
	}
}

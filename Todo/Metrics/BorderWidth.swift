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
	func borderWidth(_ width: (Border.Width.Type) -> Border.Width) -> Self {
		layer.borderWidth = width(Border.Width.self).value
		return self
	}

	func borderColor(_ color: (Colors.Border.Type) -> ColorAsset) -> Self {
		layer.borderColor = color(Colors.Border.self).color.cgColor
		return self
	}
}

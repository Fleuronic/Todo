// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import Layoutless

public struct Insets {
	public let value: CGFloat
}

// MARK: -
public extension Insets {
	struct Horizontal {
		public let value: CGFloat
	}

	struct Vertical {
		public let value: CGFloat
	}
}

// MARK: -
extension Insets: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral: integerLiteral)
	}
}

// MARK: -
public extension Insets.Horizontal {
	static let `default`: Self = 8
}

// MARK: -
extension Insets.Horizontal: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral: integerLiteral)
	}
}

// MARK: -
public extension Insets.Vertical {
	static let `default`: Self = 8
}


// MARK: -
extension Insets.Vertical: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral: integerLiteral)
	}
}

// MARK: -
public extension LayoutProtocol where Node: Anchorable {
	func insetBy(
		insets: Insets? = nil,
		horizontalInsets: Insets.Horizontal = 0,
		verticalInsets: Insets.Vertical = 0
	) -> Layout<UIView> {
		insetBy(
			insets: insets,
			horizontalInsets: horizontalInsets.value,
			verticalInsets: verticalInsets.value
		)
	}

	func insetBy(
		insets: Insets? = nil,
		horizontalInsets: CGFloat = 0,
		verticalInsets: CGFloat = 0
	) -> Layout<UIView> {
		let horizontal = insets?.value ?? horizontalInsets
		let vertical = insets?.value ?? verticalInsets
		return insetting(
			leftBy: horizontal,
			rightBy: horizontal,
			topBy: vertical,
			bottomBy: vertical
		)
	}

	func fillingParent(
		insets: Insets? = nil,
		horizontalInsets: Insets.Horizontal = 0,
		verticalInsets: Insets.Vertical = 0,
		relativeToSafeArea: Bool = false
	) -> Layout<ChildNode<Node>> {
		fillingParent(
			insets: insets,
			horizontalInsets: horizontalInsets.value,
			verticalInsets: verticalInsets.value,
			relativeToSafeArea: relativeToSafeArea
		)
	}

	func fillingParent(
		insets: Insets? = nil,
		horizontalInsets: CGFloat = 0,
		verticalInsets: CGFloat = 0,
		relativeToSafeArea: Bool = false
	) -> Layout<ChildNode<Node>> {
		let horizontal = Length(floatLiteral: Float(insets?.value ?? horizontalInsets))
		let vertical = Length(floatLiteral: Float(insets?.value ?? verticalInsets))
		return stickingToParentEdges(
			left: horizontal,
			right: horizontal,
			top: vertical,
			bottom: vertical,
			relativeToSafeArea: relativeToSafeArea
		)
	}
}

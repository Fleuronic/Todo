// Copyright © Fleuronic LLC. All rights reserved.

import CoreGraphics
import Layoutless
import Metric

public extension LayoutProtocol where Node: Anchorable {
	func insetBy(
		insets: Insets? = nil,
		horizontalInsets: Insets.Horizontal = 0,
		verticalInsets: Insets.Vertical = 0
	) -> Layout<some Anchorable & LayoutNode> {
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
	) -> Layout<some Anchorable & LayoutNode> {
		let horizontal = insets?.value ?? horizontalInsets
		let vertical = insets?.value ?? verticalInsets
		return insetting(
			leftBy: horizontal,
			rightBy: horizontal,
			topBy: vertical,
			bottomBy: vertical
		)
	}
}

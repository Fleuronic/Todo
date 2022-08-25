// Copyright © Fleuronic LLC. All rights reserved.

import Layoutless
import Metric

public extension LayoutProtocol where Node: Anchorable {
	func sizing(toHeight height: Height) -> Layout<Node> {
		let length = Length(floatLiteral: Float(height.value))
		return sizing(toHeight: length)
	}
}

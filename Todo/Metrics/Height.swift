import CoreGraphics
import Layoutless

public struct Height {
	let value: CGFloat
}

// MARK: -
extension Height: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension LayoutProtocol where Node: Anchorable {
	func sizing(toHeight height: Height) -> Layout<Node> {
		let length = Length(floatLiteral: Float(height.value))
		return sizing(toHeight: length)
	}
}

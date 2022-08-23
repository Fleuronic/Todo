import CoreGraphics
import Layoutless

public struct Width {
	let value: CGFloat
}

// MARK: -
extension Width: ExpressibleByIntegerLiteral {
	public init(integerLiteral: IntegerLiteralType) {
		value = .init(integerLiteral)
	}
}

// MARK: -
public extension LayoutProtocol where Node: Anchorable {
	func sizing(toWidth width: Width) -> Layout<Node> {
		let length = Length(floatLiteral: Float(width.value))
		return sizing(toWidth: length)
	}
}

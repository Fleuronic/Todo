import Layoutless

@resultBuilder public struct LayoutBuilder {
	static func buildBlock(_ layouts: AnyLayout?...) -> [AnyLayout] {
		layouts.compactMap { $0 }
	}
}

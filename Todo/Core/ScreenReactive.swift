import ReactiveKit
import Bond

@dynamicMemberLookup struct ScreenReactive<Base: ScreenProxy> {
	private let base: Base

	init(base: Base) {
		self.base = base
	}

	subscript<T>(dynamicMember keyPath: KeyPath<Base.Screen, T>) -> SafeSignal<T> {
		base.source(for: keyPath)
	}

	subscript<T>(dynamicMember keyPath: KeyPath<Base.Screen, Event<T>>) -> Bond<T> {
		base.target(for: keyPath)
	}
}

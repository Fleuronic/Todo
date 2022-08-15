import ReactiveSwift

@dynamicMemberLookup struct ScreenReactive<Base: ScreenProxy> {
	private let base: Base

	init(base: Base) {
		self.base = base
	}

	subscript<T>(dynamicMember keyPath: KeyPath<Base.Screen, T>) -> SignalProducer<T, Never> {
		base.source(for: keyPath)
	}

	subscript<T>(dynamicMember keyPath: KeyPath<Base.Screen, Event<T>>) -> BindingTarget<T> {
		base.target(for: keyPath)
	}
}

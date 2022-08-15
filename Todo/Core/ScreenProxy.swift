import WorkflowUI
import ReactiveSwift

protocol ScreenProxy {
	associatedtype Screen: WorkflowUI.Screen

	func source<T>(for keyPath: KeyPath<Screen, T>) -> SignalProducer<T, Never>
	func target<T>(for keyPath: KeyPath<Screen, Event<T>>) -> BindingTarget<T>
}

extension ScreenProxy {
	var reactive: ScreenReactive<Self> {
		.init(base: self)
	}
}


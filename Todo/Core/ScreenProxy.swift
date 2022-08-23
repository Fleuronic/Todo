import WorkflowUI
import ReactiveKit
import Bond

protocol ScreenProxy<Screen> {
	associatedtype Screen: WorkflowUI.Screen

	func source<T>(for keyPath: KeyPath<Screen, T>) -> SafeSignal<T>
	func target<T>(for keyPath: KeyPath<Screen, Event<T>>) -> Bond<T>
}

extension ScreenProxy {
	var reactive: ScreenReactive<Self> {
		.init(base: self)
	}
}

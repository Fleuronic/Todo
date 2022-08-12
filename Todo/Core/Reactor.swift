import WorkflowUI
import ReactiveSwift

@dynamicMemberLookup protocol Reactor {
	associatedtype Screen: WorkflowUI.Screen

	subscript<T>(dynamicMember keyPath: KeyPath<Screen, T>) -> SignalProducer<T, Never> { get }
	subscript<T>(dynamicMember keyPath: KeyPath<Screen, Event<T>>) -> BindingTarget<T> { get }
}

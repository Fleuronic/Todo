import WorkflowUI
import Combine

protocol ScreenProxy {
	associatedtype Screen: WorkflowUI.Screen

	func publisher<T>(for keyPath: KeyPath<Screen, T>) -> AnyPublisher<T, Never>
	func sink<T>(for keyPath: KeyPath<Screen, Event<T>>) -> Subscribers.Sink<T, Never>
}

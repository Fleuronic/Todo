import WorkflowUI

protocol ReactiveScreen: Screen {
	associatedtype View: ReactiveView<Self>
}

// MARK: -
extension ReactiveScreen {
	func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
		ReactiveViewController<Self, View>.description(for: self, environment: environment)
	}
}

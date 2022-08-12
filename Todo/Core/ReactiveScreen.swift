import WorkflowUI

protocol ReactiveScreen: Screen where View.Screen == Self {
	associatedtype View: ReactiveView
}

// MARK: -
extension ReactiveScreen {
	func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
		ReactiveViewController<View>.description(for: self, environment: environment)
	}
}

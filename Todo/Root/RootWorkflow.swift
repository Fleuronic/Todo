import Workflow
import WorkflowUI

extension Root {
	struct Workflow {}
}

// MARK: -
extension Root.Workflow {
	enum Action {
		case logIn(name: String)
		case logOut
	}
}

// MARK: -
extension Root.Workflow: Workflow {
	typealias Rendering = BackStackScreen<AnyScreen>
	typealias Output = Never

	enum State {
		case welcome
		case todo(name: String)
	}

	func makeInitialState() -> State {
		.welcome
	}

	func render(state: State, context: RenderContext<Self>) -> Rendering {
		let welcomeItem = welcomeItem(in: context)

		switch state {
		case .welcome:
			return .init(items: [welcomeItem])
		case let .todo(name):
			let todoItems = todoItems(with: name, in: context)
			return .init(items: [welcomeItem] + todoItems)
		}
	}
}

// MARK: -
private extension Root.Workflow {
	func welcomeItem(in context: RenderContext<Self>) -> BackStackItem {
		.init(
			screen: Welcome.Workflow()
				.mapOutput(action)
				.rendered(in: context)
				.asAnyScreen(),
			barVisibility: .hidden
		)
	}

	func todoItems(with name: String, in context: RenderContext<Self>) -> [BackStackItem] {
		Todo.Workflow(name: name)
			.mapOutput(action)
			.rendered(in: context)
	}

	func action(for welcomeOutput: Welcome.Workflow.Output) -> Action {
		switch welcomeOutput {
		case let .user(name):
			return .logIn(name: name)
		}
	}

	func action(for todoOutput: Todo.Workflow.Output) -> Action {
		switch todoOutput {
		case .end:
			return .logOut
		}
	}
}

// MARK: -
extension Root.Workflow.Action: WorkflowAction {
	typealias WorkflowType = Root.Workflow

	func apply(toState state: inout Root.Workflow.State) -> Root.Workflow.Output? {
		switch self {
		case let .logIn(name):
			state = .todo(name: name)
		case .logOut:
			state = .welcome
		}
		return nil
	}
}

// MARK: -
extension Root.Workflow.State: Equatable {}

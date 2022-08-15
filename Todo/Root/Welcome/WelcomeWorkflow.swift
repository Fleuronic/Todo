import Workflow

extension Welcome {
	struct Workflow {}
}

// MARK: -
extension Welcome.Workflow {
	enum Action: WorkflowAction {
		case updateName(String)
		case logIn
	}
}

// MARK: -
extension Welcome.Workflow: Workflow {
	typealias Rendering = Welcome.Screen

	struct State {
		var name = ""
	}

	enum Output {
		case user(name: String)
	}

	func makeInitialState() -> State {
		.init()
	}

	func render(state: State, context: RenderContext<Self>) -> Rendering {
		let sink = context.makeSink(of: Action.self)
		return screen(state: state, sink: sink)
	}
}

// MARK: -
private extension Welcome.Workflow {
	func screen(state: State, sink: Sink<Action>) -> Welcome.Screen {
		.init(
			name: state.name,
			nameTextEdited: { sink.send(.updateName($0)) },
			loginTapped: { sink.send(.logIn) }
		)
	}
}

// MARK: -
extension Welcome.Workflow.Action {
	typealias WorkflowType = Welcome.Workflow

	func apply(toState state: inout Welcome.Workflow.State) -> Welcome.Workflow.Output? {
		switch self {
		case let .updateName(name):
			state.name = name
		case .logIn:
			return .user(name: state.name)
		}
		return nil
	}
}

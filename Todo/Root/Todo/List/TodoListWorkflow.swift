import Workflow

extension Todo.List {
	struct Workflow {
		let name: String
		let todos: [Todo]
	}
}

// MARK: -
extension Todo.List.Workflow {
	enum Action: WorkflowAction {
		case selectTodo(index: Int)
		case createTodo
		case finish
	}
}

// MARK: -
extension Todo.List.Workflow: Workflow {
	typealias Rendering = BackStackItem

	struct State {}

	enum Output {
		case selectedTodo(index: Int)
		case todoCreation
		case end
	}

	func makeInitialState() -> State {
		.init()
	}

	func render(state: State, context: RenderContext<Self>) -> Rendering {
		let sink = context.makeSink(of: Action.self)
		return item(state: state, sink: sink)
	}
}

// MARK: -
private extension Todo.List.Workflow {
	func screen(state: State, sink: Sink<Action>) -> Todo.List.Screen {
		.init(todoTitles: todos.map(\.title)) {
			sink.send(.selectTodo(index: $0))
		}
	}

	func item(state: State, sink: Sink<Action>) -> BackStackItem {
		.init(
			screen: screen(state: state, sink: sink).asAnyScreen(),
			barContent: .init(
				title: Strings.Todo.List.title(name),
				leftItem: .button(
					.back { sink.send(.finish) }
				),
				rightItem: .button(
					.init(content: .text(Strings.Todo.List.Title.Button.newTodo)) { sink.send(.createTodo) }
				)
			)
		)
	}
}

// MARK: -
extension Todo.List.Workflow.State {
	enum Step {
		case list
		case editTodo(index: Int)
	}
}

// MARK: -
extension Todo.List.Workflow.Action {
	typealias WorkflowType = Todo.List.Workflow

	func apply(toState state: inout Todo.List.Workflow.State) -> Todo.List.Workflow.Output? {
		switch self {
		case let .selectTodo(index):
			return .selectedTodo(index: index)
		case .createTodo:
			return .todoCreation
		case .finish:
			return .end
		}
	}
}

// MARK: -
extension Todo.List.Workflow.Output: Equatable {}

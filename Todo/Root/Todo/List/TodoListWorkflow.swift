import Workflow

extension Todo.List {
	struct Workflow {
		let name: String
	}
}

// MARK: -
extension Todo.List.Workflow {
	enum Action: WorkflowAction {
		case finish
		case selectTodo(index: Int)
		case saveChanges(index: Int, Todo)
		case discardChanges
	}
}

// MARK: -
extension Todo.List.Workflow: Workflow {
	typealias Rendering = [BackStackItem]

	struct State {
		var todos: [Todo]
		var step: Step
	}

	enum Output {
		case end
	}

	func makeInitialState() -> State {
		.init(
			todos: [
				.init(
					title: "Take the cat for a walk",
					note: "Cats really need their outside sunshine time. Don't forget to walk Charlie. Hamilton is less excited about the prospect."
				)
			],
			step: .list
		)
	}

	func render(state: State, context: RenderContext<Self>) -> Rendering {
		let listItem = listItem(with: state, in: context)

		switch state.step {
		case .list:
			return [listItem]
		case let .editTodo(index):
			let editTodoItem = editItem(forTodoAt: index, with: state, in: context)
			return [listItem, editTodoItem]
		}
	}
}

// MARK: -
private extension Todo.List.Workflow {
	func listScreen(with state: State, in context: RenderContext<Self>) -> Todo.List.Screen {
		let sink = context.makeSink(of: Action.self)

		return .init(
			todoTitles: state.todos.map(\.title),
			todoSelected: { index in
				sink.send(.selectTodo(index: index))
			}
		)
	}


	func listItem(with state: State, in context: RenderContext<Self>) -> BackStackItem {
		let sink = context.makeSink(of: Action.self)

		return .init(
			screen: listScreen(with: state, in: context)
				.asAnyScreen(),
			barContent: .init(
				title: "Welcome \(name)",
				leftItem: .button(
					.back { sink.send(.finish) }
				)
			)
		)
	}

	func editItem(forTodoAt index: Int, with state: State, in context: RenderContext<Self>) -> BackStackItem {
		Todo.Edit.Workflow(initialTodo: state.todos[index])
			.mapOutput { action(forTodoAt: index, editOutput: $0) }
			.rendered(in: context)
	}

	func action(forTodoAt index: Int, editOutput: Todo.Edit.Workflow.Output) -> Action {
		switch editOutput {
		case let .save(todo):
			return .saveChanges(index: index, todo)
		case .cancellation:
			return .discardChanges
		}
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
		case .finish:
			return .end
		case let .selectTodo(index):
			state.step = .editTodo(index: index)
		case let .saveChanges(index, todo):
			state.todos[index] = todo
			fallthrough
		case .discardChanges:
			state.step = .list
		}

		return nil
	}
}

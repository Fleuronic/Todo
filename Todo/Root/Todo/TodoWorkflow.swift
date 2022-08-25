import Workflow

extension Todo {
	struct Workflow {
		let name: String
	}
}

// MARK: -
extension Todo.Workflow {
	enum ListAction {
		case editTodo(index: Int)
		case createTodo
		case finish
	}

	enum EditAction {
		case saveTodo(Todo, index: Int)
		case cancel
	}
}

// MARK: -
extension Todo.Workflow: Workflow {
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
					note: "Cats really need their outside sunshine time. Don’t forget to walk Charlie. Hamilton is less excited about the prospect."
				)
			],
			step: .list
		)
	}

	func render(state: State, context: RenderContext<Todo.Workflow>) -> Rendering {
		let listItem = listItem(with: state, in: context)

		switch state.step {
		case .list:
			return [listItem]
		case let .editTodo(index):
			let editItem = editItem(with: state, in: context, editingTodoAt: index)
			return [listItem, editItem]
		}
	}
}

// MARK: -
private extension Todo.Workflow {
	func listItem(with state: State, in context: RenderContext<Self>) -> BackStackItem {
		Todo.List.Workflow(name: name, todos: state.todos)
			.mapOutput(action)
			.rendered(in: context)
	}

	func editItem(with state: State, in context: RenderContext<Self>, editingTodoAt index: Int) -> BackStackItem {
		Todo.Edit.Workflow(initialTodo: state.todos[index])
			.mapOutput { action(for: $0, editingTodoAt: index) }
			.rendered(in: context)
	}

	func action(for listOutput: Todo.List.Workflow.Output) -> ListAction {
		switch listOutput {
		case let .selectedTodo(index: index):
			return .editTodo(index: index)
		case .todoCreation:
			return .createTodo
		case .end:
			return .finish
		}
	}

	func action(for editOutput: Todo.Edit.Workflow.Output, editingTodoAt index: Int) -> EditAction {
		switch editOutput {
		case let .editedTodo(todo):
			return .saveTodo(todo, index: index)
		case .cancellation:
			return .cancel
		}
	}
}

// MARK: -
extension Todo.Workflow.State {
	enum Step {
		case list
		case editTodo(index: Int)
	}
}

// MARK: -
extension Todo.Workflow.ListAction: WorkflowAction {
	typealias WorkflowType = Todo.Workflow

	func apply(toState state: inout Todo.Workflow.State) -> Todo.Workflow.Output? {
		switch self {
		case let .editTodo(index):
			state.step = .editTodo(index: index)
		case .createTodo:
			state.todos.append(
				.init(
					title: "New Todo",
					note: ""
				)
			)
		case .finish:
			return .end
		}
		return nil
	}
}

// MARK: -
extension Todo.Workflow.EditAction: WorkflowAction {
	typealias WorkflowType = Todo.Workflow

	func apply(toState state: inout Todo.Workflow.State) -> Todo.Workflow.Output? {
		switch self {
		case let .saveTodo(todo, index):
			state.todos[index] = todo
			fallthrough
		case .cancel:
			state.step = .list
		}
		return nil
	}
}

// MARK: -
extension Todo.Workflow.State: Equatable {}

// MARK: -
extension Todo.Workflow.State.Step: Equatable {}

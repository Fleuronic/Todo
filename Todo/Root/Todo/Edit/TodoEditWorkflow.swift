import Workflow
import WorkflowUI

extension Todo.Edit {
	struct Workflow {
		let initialTodo: Todo
	}
}

// MARK: -
extension Todo.Edit.Workflow {
	enum Action: WorkflowAction {
		case updateTitle(String)
		case updateNote(String)
		case saveChanges
		case discardChanges
	}
}

// MARK: -
extension Todo.Edit.Workflow: Workflow {
	typealias Rendering = BackStackItem

	struct State {
		var todo: Todo
	}

	enum Output {
		case save(Todo)
		case cancellation
	}

	func makeInitialState() -> State {
		.init(todo: initialTodo)
	}

	func render(state: State, context: RenderContext<Self>) -> Rendering {
		item(with: state, in: context)
	}
}

// MARK: -
private extension Todo.Edit.Workflow {
	func screen(with state: State, in context: RenderContext<Self>) -> Todo.Edit.Screen {
		let sink = context.makeSink(of: Action.self)

		return .init(
			title: state.todo.title,
			note: state.todo.note,
			titleTextEdited: { text in
				sink.send(.updateTitle(text))
			}, noteTextEdited: { text in
				sink.send(.updateNote(text))
			}
		)
	}

	func item(with state: State, in context: RenderContext<Self>) -> BackStackItem {
		let sink = context.makeSink(of: Action.self)

		return .init(
			screen: screen(with: state, in: context).asAnyScreen(),
			barContent: .init(
				title: "Edit",
				leftItem: .button(
					.back { sink.send(.discardChanges) }
				),
				rightItem: .button(
					.init(content: .text("Save")) { sink.send(.saveChanges) }
				)
			)
		)
	}
}

// MARK: -
extension Todo.Edit.Workflow.Action {
	typealias WorkflowType = Todo.Edit.Workflow

	func apply(toState state: inout Todo.Edit.Workflow.State) -> Todo.Edit.Workflow.Output? {
		switch self {
		case let .updateTitle(title):
			state.todo.title = title
		case let .updateNote(note):
			state.todo.note = note
		case .saveChanges:
			return .save(state.todo)
		case .discardChanges:
			return .cancellation
		}
		return nil
	}
}

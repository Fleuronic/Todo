import XCTest
import WorkflowTesting
import WorkflowUI
@testable import Todo

class TodoWorkflowTests: XCTestCase {
	func testSelectedTodo() throws {
		let name = "Jordan"
		let title = "Title"
		let note = "Note"
		let todos = [Todo(title: title, note: note)]
		let index = 0

		Todo.Workflow(name: name)
			.renderTester(
				initialState: .init(
					todos: todos,
					step: .list
				)
			)
			.expectWorkflow(
				type: Todo.List.Workflow.self,
				producingRendering: .init(
					screen: Todo.List.Screen(
						todoTitles: [],
						rowSelected: { _ in }
					).asAnyScreen()
				),
				producingOutput: .selectedTodo(index: index)
			)
			.render { items in
				XCTAssertEqual(items.count, 1)
			}
			.assert(
				state: .init(
					todos: todos,
					step: .editTodo(index: index)
				)
			)
	}

	func testEditedTodo() throws {
		let name = "Jordan"
		let title = "Title"
		let note = "Note"
		let updatedTitle = "Updated Title"
		let updatedNote = "Updated Note"
		let todos = [Todo(title: title, note: note)]
		let index = 0

		Todo.Workflow(name: name)
			.renderTester(
				initialState: .init(
					todos: todos,
					step: .editTodo(index: index)
				)
			)
			.expectWorkflow(
				type: Todo.List.Workflow.self,
				producingRendering: .init(
					screen: Todo.List.Screen(
						todoTitles: [],
						rowSelected: { _ in }
					).asAnyScreen()
				)
			)
			.expectWorkflow(
				type: Todo.Edit.Workflow.self,
				producingRendering: .init(
					screen: Todo.Edit.Screen(
						title: title,
						note: note,
						titleTextEdited: { _ in },
						noteTextEdited: { _ in }
					).asAnyScreen()
				),
				producingOutput: .editedTodo(
					.init(
						title: updatedTitle,
						note: updatedNote
					)
				)
			)
			.render { items in
				XCTAssertEqual(items.count, 2)
			}
			.assert(
				state: .init(
					todos: [
						.init(
							title: updatedTitle,
							note: updatedNote
						)
					],
					step: .list
				)
			)
	}
}

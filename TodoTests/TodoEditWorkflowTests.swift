import XCTest
import WorkflowTesting
@testable import Todo

class TodoEditWorkflowTests: XCTestCase {
	func testActions() throws {
		let title = "Title"
		let note = "Note"
		let updatedTitle = "Updated Title"
		let updatedNote = "Updated Note"

		Todo.Edit.Workflow.Action
			.tester(withState: .init(todo: .init(title: title, note: note)))
			.verifyState { state in
				XCTAssertEqual(state.todo.title, title)
				XCTAssertEqual(state.todo.note, note)
			}
			.send(action: .updateTitle(updatedTitle))
			.assertNoOutput()
			.verifyState { state in
				XCTAssertEqual(state.todo.title, updatedTitle)
				XCTAssertEqual(state.todo.note, note)
			}
			.send(action: .updateNote(updatedNote))
			.assertNoOutput()
			.verifyState { state in
				XCTAssertEqual(state.todo.title, updatedTitle)
				XCTAssertEqual(state.todo.note, updatedNote)
			}
			.send(action: .discardChanges)
			.verifyOutput { output in
				XCTAssertEqual(output, .cancellation)
			}
			.send(action: .saveChanges)
			.verifyOutput { output in
				switch output {
				case let .editedTodo(todo):
					XCTAssertEqual(todo.title, updatedTitle)
					XCTAssertEqual(todo.note, updatedNote)
				default:
					XCTFail()
				}
			}
	}
}

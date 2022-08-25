import XCTest
import WorkflowTesting
@testable import Todo

class TodoListWorkflowTests: XCTestCase {
	func testActions() throws {
		let index = 7
		Todo.List.Workflow.Action
			.tester(withState: .init())
			.send(action: .finish)
			.verifyOutput { output in
				XCTAssertEqual(output, .end)
			}
			.send(action: .selectTodo(index: index))
			.verifyOutput { output in
				XCTAssertEqual(output, .selectedTodo(index: index))
			}
			.send(action: .createTodo)
			.verifyOutput { output in
				XCTAssertEqual(output, .todoCreation)
			}
	}
}

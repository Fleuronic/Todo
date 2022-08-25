import XCTest
import Workflow
import WorkflowTesting
@testable import Todo
@testable import WorkflowUI

class AppTests: XCTestCase {
	func testAppFlow() throws {
		let name = "Jordan"
		let updatedTodoTitle = "Updated Title"

		try logIn(with: name)
		try selectFirstTodo()
		try editTodoTitle(to: updatedTodoTitle)
		try saveChanges()
		try verifyTodoTitleUpdated(to: updatedTodoTitle)
	}
}

private extension AppTests {
	var items: [BackStackItem] {
		workflowHost.rendering.value.items
	}

	func logIn(with name: String) throws {
		XCTAssertEqual(items.count, 1)

		let welcomeScreen = try XCTUnwrap(items[0].screen.wrappedScreen as? Welcome.Screen)
		welcomeScreen.nameTextEdited(name)
		welcomeScreen.loginTapped(())
	}

	func selectFirstTodo() throws {
		XCTAssertEqual(items.count, 2)
		XCTAssertNotNil(items[0].screen.wrappedScreen as? Welcome.Screen)

		let todoListScreen = try XCTUnwrap(items[1].screen.wrappedScreen as? Todo.List.Screen)
		XCTAssertEqual(todoListScreen.todoTitles.count, 1)

		todoListScreen.rowSelected(0)
	}

	func editTodoTitle(to title: String) throws {
		XCTAssertEqual(items.count, 3)
		XCTAssertNotNil(items[0].screen.wrappedScreen as? Welcome.Screen)
		XCTAssertNotNil(items[1].screen.wrappedScreen as? Todo.List.Screen)

		let todoEditScreen = try XCTUnwrap(items[2].screen.wrappedScreen as? Todo.Edit.Screen)
		todoEditScreen.titleTextEdited(title)
	}

	func saveChanges() throws {
		XCTAssertEqual(items.count, 3)
		XCTAssertNotNil(items[0].screen.wrappedScreen as? Welcome.Screen)
		XCTAssertNotNil(items[1].screen.wrappedScreen as? Todo.List.Screen)
		XCTAssertNotNil(items[2].screen.wrappedScreen as? Todo.Edit.Screen)

		guard case let .visible(barContent) = items[2].barVisibility else { XCTFail(); return }
		guard case let .button(saveButton) = barContent.rightItem else { XCTFail(); return }
		guard case let .text(saveButtonText) = saveButton.content else { XCTFail(); return }

		XCTAssertEqual(saveButtonText, Strings.Todo.Edit.Title.Button.save)

		saveButton.handler()
	}

	func verifyTodoTitleUpdated(to title: String) throws {
		XCTAssertEqual(items.count, 2)
		XCTAssertNotNil(items[0].screen.wrappedScreen as? Welcome.Screen)

		let todoListScreen = try XCTUnwrap(items[1].screen.wrappedScreen as? Todo.List.Screen)
		XCTAssertEqual(todoListScreen.todoTitles.count, 1)
		XCTAssertEqual(todoListScreen.todoTitles[0], title)
	}
}

private let workflowHost = WorkflowHost(workflow: Root.Workflow())

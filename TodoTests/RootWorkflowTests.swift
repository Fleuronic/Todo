import XCTest
import WorkflowTesting
@testable import Todo
@testable import WorkflowUI

class RootWorkflowTests: XCTestCase {
	func testActions() throws {
		let name = "Jordan"
		Root.Workflow.Action
			.tester(withState: .welcome)
			.send(action: .logIn(name: name))
			.assertNoOutput()
			.verifyState { state in
				XCTAssertEqual(state, .todo(name: name))
			}
			.send(action: .logOut)
			.assertNoOutput()
			.verifyState { state in
				XCTAssertEqual(state, .welcome)
			}
	}
	
	func testLoggedInUser() throws {
		let name = "Jordan"
		try Root.Workflow()
			.renderTester(initialState: .welcome)
			.expectWorkflow(
				type: Welcome.Workflow.self,
				producingRendering: .init(
					name: name,
					nameTextEdited: { _ in },
					loginTapped: {}
				),
				producingOutput: .user(name: name)
			)
			.render { rendering in
				let items = rendering.items
				XCTAssertEqual(items.count, 1)
				
				let welcomeScreen = try XCTUnwrap(items[0].screen.wrappedScreen as? Welcome.Screen)
				XCTAssertEqual(welcomeScreen.name, name)
			}
			.assert(state: .todo(name: name))
	}
}

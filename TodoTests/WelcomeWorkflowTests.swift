import XCTest
import WorkflowTesting
@testable import Todo

class WelcomeWorkflowTests: XCTestCase {
	func testActions() throws {
		let name = "Jordan"
		Welcome.Workflow.Action
			.tester(withState: .init())
			.send(action: .logIn)
			.assertNoOutput()
			.verifyState { state in
				XCTAssertTrue(state.name.isEmpty)
			}
			.send(action: .updateName(name))
			.assertNoOutput()
			.verifyState { state in
				XCTAssertEqual(state.name, name)
			}
			.send(action: .logIn)
			.verifyOutput { output in
				XCTAssertEqual(output, .user(name: name))
			}
	}

	func testRenderingNameTextEdited() throws {
		let name = "Jordan"
		Welcome.Workflow()
			.renderTester()
			.render { screen in
				screen.nameTextEdited(name)
			}
			.verifyState { state in
				XCTAssertEqual(state.name, name)
			}
	}

	func testRenderingLoginTapped() throws {
		let name = "Jordan"
		Welcome.Workflow()
			.renderTester()
			.render { screen in
				XCTAssertTrue(screen.name.isEmpty)
				screen.loginTapped(())
			}
			.assertNoOutput()
		Welcome.Workflow()
			.renderTester(initialState: .init(name: name))
			.render { screen in
				screen.loginTapped(())
			}
			.verifyOutput { output in
				XCTAssertEqual(output, .user(name: name))
			}
	}
}

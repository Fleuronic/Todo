// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UIWindow
import class UIKit.UIScreen
import class WorkflowUI.WorkflowHostingController
import protocol UIKit.UIApplicationDelegate
import protocol Workflow.AnyWorkflowConvertible
import protocol WorkflowUI.Screen

protocol AppDelegate: UIApplicationDelegate {
	associatedtype AppWorkflow: AnyWorkflowConvertible where AppWorkflow.Rendering: Screen

	var workflow: AppWorkflow { get }
}

// MARK: -
extension AppDelegate {
	func makeWindow() -> UIWindow {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.makeKeyAndVisible()
		window.rootViewController = WorkflowHostingController(workflow: workflow)
		return window
	}
}

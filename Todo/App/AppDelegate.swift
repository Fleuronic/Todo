import UIKit
import WorkflowUI

@UIApplicationMain final class AppDelegate: UIResponder {
	var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		let viewController = ContainerViewController(workflow: Root.Workflow())

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()

		return true
	}
}

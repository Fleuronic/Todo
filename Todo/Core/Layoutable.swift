import UIKit
import WorkflowUI
import Layoutless

protocol Layoutable {
	associatedtype Screen: WorkflowUI.Screen

	func layout(with screen: some ScreenProxy<Screen>) -> AnyLayout
}

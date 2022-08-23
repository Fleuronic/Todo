import UIKit
import WorkflowUI
import Layoutless

protocol ReactiveView: UIView {
	associatedtype Screen: WorkflowUI.Screen

	init(screen: some ScreenProxy<Screen>)
}

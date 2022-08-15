import UIKit
import WorkflowUI

protocol ReactiveView: UIView {
	associatedtype Screen: WorkflowUI.Screen

	init<T: ScreenProxy>(screen: T) where T.Screen == Screen
}

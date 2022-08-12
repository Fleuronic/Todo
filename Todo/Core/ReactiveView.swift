import UIKit
import WorkflowUI

protocol ReactiveView: UIView {
	associatedtype Screen: WorkflowUI.Screen

	init<T: Reactor>(reactor: T) where T.Screen == Screen
}

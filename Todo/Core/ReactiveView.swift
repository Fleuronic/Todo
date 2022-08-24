import UIKit
import WorkflowUI
import Layoutless

class ReactiveView<Screen: WorkflowUI.Screen>: UIView {
	init(screen: some ScreenProxy<Screen>) {
		super.init(frame: .zero)
		layout(with: screen).layout(in: self)
	}

	required init(coder: NSCoder) {
		fatalError()
	}

	func layout(with screen: some ScreenProxy<Screen>) -> AnyLayout {
		EmptyLayout()
	}
}

import UIKit
import Layoutless
import Telemetric

extension Todo.List {
	final class View: UIView {}
}

// MARK: -
extension Todo.List.View: Stacking {
	typealias Screen = Todo.List.Screen

	@VerticallyStacked<Self> func content(screen: some ScreenProxy<Screen>) -> Layout<UIStackView> {
		UILabel
			.text(screen.prompt)
			.centered
		UITableView
			.cellsText(screen.todoTitles)
			.rowSelected(screen.rowSelected)
	}
}

// MARK: -
extension Todo.List.Screen: ReactiveScreen {
	typealias View = Todo.List.View
}

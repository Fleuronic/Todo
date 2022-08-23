import UIKit
import ReactiveKit
import Bond
import Layoutless

extension Todo.List {
	final class View: UI.View {
		private let titleLabel = UILabel(style: .title)
		private let tableView = UITableView()

		init(screen: some ScreenProxy<Screen>) {
			super.init(frame: .zero)

			screen.todoTitles
				.diff()
				.bind(to: tableView, cellType: UITableViewCell.self) { cell, title in
					cell.textLabel?.text = title
				}
			screen.rowSelected <~ tableView.reactive.selectedRowIndexPath.map(\.row)
		}

		required init(coder: NSCoder) {
			fatalError()
		}

		override var subviewsLayout: AnyLayout {
			stack(.vertical) {
				titleLabel
				tableView
			}.fillingParent()
		}
	}
}

// MARK: -
extension Todo.List.View: ReactiveView {
	typealias Screen = Todo.List.Screen
}

// MARK: -
extension Todo.List.Screen: ReactiveScreen {
	typealias View = Todo.List.View
}

// MARK: -
private extension Style where View == UILabel {
	static let title = Self {
		$0.text = "What do you have to do?"
	}.centered
}

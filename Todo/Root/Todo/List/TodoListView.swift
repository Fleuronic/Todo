import UIKit
import ReactiveKit
import Bond
import Layoutless

extension Todo.List {
	final class View: UI.View {
		private let titleLabel = UILabel()
		private let tableView = UITableView()

		init<T: ScreenProxy>(screen: T) where T.Screen == Screen {
			super.init(frame: .zero)

			backgroundColor = .white
			titleLabel.text = "What do you have to do?"
			titleLabel.textAlignment = .center
			tableView.reactive.selectedRowIndexPath.map(\.row) ~> screen.reactive.rowSelected
			
			screen.reactive.todoTitles
				.diff()
				.bind(to: tableView, cellType: UITableViewCell.self) { cell, title in
					cell.textLabel?.text = title
				}
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError()
		}

		override var subviewsLayout: AnyLayout {
			stack(.vertical)(
				titleLabel,
				tableView
			).fillingParent()
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

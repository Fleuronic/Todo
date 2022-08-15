import UIKit
import ReactiveKit
import Bond

extension Todo.List {
	final class View: UIView {
		private lazy var titleLabel: UILabel = {
			let label = UILabel()
			label.text = "What do you have to do?"
			label.textAlignment = .center
			addSubview(label)
			return label
		}()

		private lazy var tableView: UITableView = {
			let tableView = UITableView()
			addSubview(tableView)
			return tableView
		}()

		init<T: ScreenProxy>(screen: T) where T.Screen == Screen {
			super.init(frame: .zero)

			backgroundColor = .white
			tableView.reactive.selectedRowIndexPath.map(\.row).bind(to: screen.reactive.rowSelected)
			screen.reactive.todoTitles.diff().bind(to: tableView, cellType: UITableViewCell.self) { cell, title in
				cell.textLabel?.text = title
			}
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError()
		}

		// MARK: UIView
		override public func layoutSubviews() {
			super.layoutSubviews()

			titleLabel.frame = .init(
				x: bounds.minX,
				y: bounds.minY,
				width: bounds.maxX,
				height: 44
			)

			let yOffset = titleLabel.frame.maxY + 8

			tableView.frame = .init(
				x: bounds.minX,
				y: yOffset,
				width: bounds.maxX,
				height: bounds.maxY - yOffset
			)
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

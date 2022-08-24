import UIKit
import ReactiveKit
import Bond
import Layoutless

extension Todo.List {
	final class View: ReactiveView<Screen> {
		override func layout(with screen: some ScreenProxy<Screen>) -> AnyLayout {
			let titleLabel = UILabel(style: .title)
			let tableView = UITableView()

			screen.todoTitles
				.diff()
				.bind(to: tableView, cellType: UITableViewCell.self) { cell, title in
					cell.textLabel?.text = title
				}
			screen.rowSelected <~ tableView.reactive.selectedRowIndexPath.map(\.row)

			return stack(.vertical) {
				titleLabel
				tableView
			}.fillingParent()
		}
	}
}

// MARK: -
extension Todo.List.Screen: ReactiveScreen {
	typealias View = Todo.List.View
}

// MARK: -
private extension Style where View == UILabel {
	static let title = Self {
		$0.text = Strings.Todo.List.prompt
	}.centered
}

import UIKit
import ReactiveSwift

extension Todo.List {
	final class View: UIView {
		private let todoTitles = MutableProperty<[String]>([])
		private let selectRow: Signal<Int, Never>
		private let selectRowObserver: Signal<Int, Never>.Observer

		private lazy var titleLabel: UILabel = {
			let label = UILabel()
			label.text = "What do you have to do?"
			label.textAlignment = .center
			addSubview(label)
			return label
		}()

		private lazy var tableView: UITableView = {
			let tableView = UITableView()
			tableView.delegate = self
			tableView.dataSource = self
			addSubview(tableView)
			return tableView
		}()

		init<T: ScreenProxy>(screen: T) where T.Screen == Screen {
			(selectRow, selectRowObserver) = Signal<Int, Never>.pipe()

			super.init(frame: .zero)

			backgroundColor = .white

			todoTitles <~ screen.reactive.todoTitles
			tableView.reactive.reloadData <~ todoTitles.map { _ in }
			screen.reactive.rowSelected <~ selectRow
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
extension Todo.List.View: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		selectRowObserver.send(value: indexPath.row)
	}
}

extension Todo.List.View: UITableViewDataSource {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		todoTitles.value.count
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = todoTitles.value[indexPath.row]
		return cell
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

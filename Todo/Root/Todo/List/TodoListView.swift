import UIKit
import ReactiveSwift

extension Todo.List {
	final class View: UIView, ReactiveView {
		typealias Screen = Todo.List.Screen

		private let todoTitles = MutableProperty<[String]>([])
		private let selectTodo: Signal<Int, Never>
		private let selectTodoObserver: Signal<Int, Never>.Observer

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

		init<T: Reactor>(reactor: T) where T.Screen == Screen {
			(selectTodo, selectTodoObserver) = Signal<Int, Never>.pipe()

			super.init(frame: .zero)

			backgroundColor = .white

			todoTitles <~ reactor.todoTitles
			tableView.reactive.reloadData <~ todoTitles.map { _ in }
			reactor.todoSelected <~ selectTodo
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
		selectTodoObserver.send(value: indexPath.row)
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
extension Todo.List.Screen: ReactiveScreen {
	typealias View = Todo.List.View
}

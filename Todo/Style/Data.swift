import UIKit
import ReactiveKit

extension UITableView {
	func rowSelected<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == Int {
		_ = target.bind(signal: reactive.selectedRowIndexPath.map(\.row))
		return self
	}

	static func cellsText<Source: SignalProtocol>(_ source: Source) -> UITableView where Source.Element == [String], Source.Error == Never {
		let tableView = UITableView()
		_ = source.diff().bind(to: tableView, cellType: UITableViewCell.self) { $0.textLabel?.text = $1 }
		return tableView
	}
}

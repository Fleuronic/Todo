import UIKit
import WorkflowUI

/**
 Wrapper view controller for being hosted in a backstack. Handles updating the bar button items.
 */
final class ScreenWrapperViewController<ScreenType: Screen>: UIViewController {
	let key: AnyHashable
	let environment: ViewEnvironment

	let contentViewController: DescribedViewController

	init(item: BackStackScreen<ScreenType>.Item, environment: ViewEnvironment) {
		self.key = item.key
		self.environment = environment
		self.contentViewController = DescribedViewController(screen: item.screen, environment: environment)

		super.init(nibName: nil, bundle: nil)

		update(barVisibility: item.barVisibility)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		addChild(contentViewController)
		view.addSubview(contentViewController.view)
		contentViewController.didMove(toParent: self)
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		contentViewController.view.frame = view.bounds
	}

	func update(item: BackStackScreen<ScreenType>.Item, environment: ViewEnvironment) {
		contentViewController.update(screen: item.screen, environment: environment)
		update(barVisibility: item.barVisibility)
	}

	func matches(item: BackStackScreen<ScreenType>.Item) -> Bool {
		return item.key == key
			&& type(of: item.screen) == ScreenType.self
	}

	private func update(barVisibility: BackStackScreen<ScreenType>.BarVisibility) {
		navigationItem.setHidesBackButton(true, animated: false)

		guard case .visible(let barContent) = barVisibility else {
			return
		}

		switch barContent.leftItem {
		case .none:
			if navigationItem.leftBarButtonItem != nil {
				navigationItem.setLeftBarButton(nil, animated: true)
			}

		case .button(let button):
			if let leftItem = navigationItem.leftBarButtonItem as? CallbackBarButtonItem {
				leftItem.update(with: button)
			} else {
				navigationItem.setLeftBarButton(CallbackBarButtonItem(button: button), animated: true)
			}
		}

		switch barContent.rightItem {
		case .none:
			if navigationItem.rightBarButtonItem != nil {
				navigationItem.setRightBarButton(nil, animated: true)
			}

		case .button(let button):
			if let rightItem = navigationItem.rightBarButtonItem as? CallbackBarButtonItem {
				rightItem.update(with: button)
			} else {
				navigationItem.setRightBarButton(CallbackBarButtonItem(button: button), animated: true)
			}
		}

		let title: String
		switch barContent.title {
		case .none:
			title = ""
		case .text(let text):
			title = text
		}
		navigationItem.title = title
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: -

extension ScreenWrapperViewController {
	final class CallbackBarButtonItem: UIBarButtonItem {
		var handler: () -> Void

		init(button: BackStackScreen<ScreenType>.BarContent.Button) {
			self.handler = {}

			super.init()
			self.target = self
			self.action = #selector(onTapped)
			update(with: button)
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		func update(with button: BackStackScreen<ScreenType>.BarContent.Button) {
			switch button.content {
			case .text(let title):
				self.title = title

			case .icon(let image):
				self.image = image
			}

			handler = button.handler
		}

		@objc private func onTapped() {
			handler()
		}
	}
}

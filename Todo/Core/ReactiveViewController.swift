import UIKit
import WorkflowUI
import ReactiveKit
import Bond

class ReactiveViewController<Screen: WorkflowUI.Screen, View: ReactiveView<Screen>>: ScreenViewController<Screen> {
	private typealias Context = (Screen, ViewEnvironment)

	private let context = Subject<Context, Never>()

	private var contentView: View!

	required init(screen: Screen, environment: ViewEnvironment) {
		super.init(screen: screen, environment: environment)
		contentView = .init(screen: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	override func screenDidChange(from previousScreen: Screen, previousEnvironment: ViewEnvironment) {
		super.screenDidChange(from: previousScreen, previousEnvironment: previousEnvironment)
		context.send((screen, environment))
	}
}

// MARK: -
extension ReactiveViewController: ScreenProxy {
	subscript<T>(dynamicMember keyPath: KeyPath<Screen, T>) -> SafeSignal<T> {
		context
			.map { $0.0[keyPath: keyPath] }
			.prepend(screen[keyPath: keyPath])
	}

	subscript<T>(dynamicMember keyPath: KeyPath<Screen, Event<T>>) -> Bond<T> {
		.init(target: self) { base, value in
			base.screen[keyPath: keyPath](value)
		}
	}
}

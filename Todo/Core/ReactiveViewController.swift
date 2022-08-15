import WorkflowUI
import ReactiveKit
import Bond

class ReactiveViewController<View: ReactiveView>: ScreenViewController<View.Screen> {
	private typealias Context = (View.Screen, ViewEnvironment)

	private let context = PassthroughSubject<Context, Never>()

	private var contentView: View!

	required init(screen: View.Screen, environment: ViewEnvironment) {
		super.init(screen: screen, environment: environment)
		contentView = .init(screen: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(contentView)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		contentView.frame = view.bounds.inset(by: view.safeAreaInsets)
	}

	override func screenDidChange(from previousScreen: View.Screen, previousEnvironment: ViewEnvironment) {
		super.screenDidChange(from: previousScreen, previousEnvironment: previousEnvironment)
		context.send((screen, environment))
	}
}

// MARK: -
extension ReactiveViewController: ScreenProxy {
	func source<T>(for keyPath: KeyPath<View.Screen, T>) -> SafeSignal<T> {
		context
			.map { $0.0[keyPath: keyPath] }
			.prepend(screen[keyPath: keyPath])
	}

	func target<T>(for keyPath: KeyPath<View.Screen, Event<T>>) -> Bond<T> {
		.init(target: self) { base, value in
			base.screen[keyPath: keyPath](value)
		}
	}
}

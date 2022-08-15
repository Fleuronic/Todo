import WorkflowUI
import ReactiveSwift

class ReactiveViewController<View: ReactiveView>: ScreenViewController<View.Screen> {
	private typealias Context = (View.Screen, ViewEnvironment)

	private let context: Signal<Context, Never>
	private let observer: Signal<Context, Never>.Observer

	private var contentView: View!

	required init(screen: View.Screen, environment: ViewEnvironment) {
		(context, observer) = Signal<Context, Never>.pipe()
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
		observer.send(value: (screen, environment))
	}
}

// MARK: -
extension ReactiveViewController: ScreenProxy {
	func source<T>(for keyPath: KeyPath<View.Screen, T>) -> SignalProducer<T, Never> {
		context
			.map { $0.0 }
			.map(keyPath)
			.producer
			.prefix(value: screen[keyPath: keyPath])
	}

	func target<T>(for keyPath: KeyPath<View.Screen, Event<T>>) -> BindingTarget<T> {
		.init(lifetime: reactive.lifetime, action: screen[keyPath: keyPath])
	}
}

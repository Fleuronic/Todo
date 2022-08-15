import UIKit
import Combine
import CombineCocoa

extension Welcome {
	final class View: UIView {
		private var cancellables = Set<AnyCancellable>()

		private lazy var welcomeLabel: UILabel = {
			let label = UILabel()
			label.text = "Welcome! Please Enter Your Name"
			label.textAlignment = .center
			addSubview(label)
			return label
		}()

		private lazy var nameField: UITextField = {
			let textField = UITextField()
			textField.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
			addSubview(textField)
			return textField
		}()

		private lazy var loginButton: UIButton = {
			let button = UIButton()
			button.setTitle("Login", for: .normal)
			button.backgroundColor = UIColor(red: 41 / 255, green: 150 / 255, blue: 204 / 255, alpha: 1.0)
			addSubview(button)
			return button
		}()

		init<T: ScreenProxy>(screen: T) where T.Screen == Screen {
			super.init(frame: .zero)

			let name = screen.publisher(for: \.name)
			let canLogIn = name.map(\.isEmpty).map(!)
			let loginButtonAlpha = canLogIn.map { $0 ? 1 : 0.5 as CGFloat }

			name.map { $0 as String? }
				.assign(to: \.text, on: nameField)
				.store(in: &cancellables)
			canLogIn
				.assign(to: \.isEnabled, on: loginButton)
				.store(in: &cancellables)
			loginButtonAlpha
				.assign(to: \.alpha, on: loginButton)
				.store(in: &cancellables)
			nameField.textPublisher
				.compactMap { $0 }
				.removeDuplicates()
				.subscribe(screen.sink(for: \.nameTextEdited))
			loginButton.tapPublisher
				.subscribe(screen.sink(for: \.loginTapped))
		}

		required init?(coder: NSCoder) {
			fatalError()
		}

		override public func layoutSubviews() {
			super.layoutSubviews()

			let inset: CGFloat = 12
			let height: CGFloat = 44
			var yOffset = (bounds.size.height - (2 * height + inset)) / 2

			welcomeLabel.frame = .init(
				x: bounds.origin.x,
				y: bounds.origin.y,
				width: bounds.size.width,
				height: yOffset
			)

			nameField.frame = .init(
				x: bounds.origin.x,
				y: yOffset,
				width: bounds.size.width,
				height: height
			).insetBy(dx: inset, dy: 0.0)

			yOffset += height + inset

			loginButton.frame = .init(
				x: bounds.origin.x,
				y: yOffset,
				width: bounds.size.width,
				height: height
			).insetBy(dx: inset, dy: 0.0)
		}
	}
}

// MARK: -
extension Welcome.View: ReactiveView {
	typealias Screen = Welcome.Screen
}

// MARK: -
extension Welcome.Screen: ReactiveScreen {
	typealias View = Welcome.View
}

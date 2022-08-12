import UIKit
import ReactiveSwift
import ReactiveCocoa

extension Welcome {
	final class View: UIView, ReactiveView {
		typealias Screen = Welcome.Screen

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

		init<T: Reactor>(reactor: T) where T.Screen == Screen {
			super.init(frame: .zero)

			let canLogIn = reactor.name.map(\.isEmpty).negate()

			nameField.reactive.text <~ reactor.name
			loginButton.reactive.isEnabled <~ canLogIn
			loginButton.reactive.alpha <~ canLogIn.map { $0 ? 1 : 0.5 }

			reactor.nameTextEdited <~ nameField.reactive.editedText
			reactor.loginTapped <~ loginButton.reactive.tap
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
extension Welcome.Screen: ReactiveScreen {
	typealias View = Welcome.View
}

import UIKit
import Layoutless

extension Welcome {
	final class View: UI.View {
		private let welcomeLabel = UILabel()
		private let nameField = UITextField()
		private let loginButton = UIButton()

		init<T: ScreenProxy>(screen: T) where T.Screen == Screen {
			super.init(frame: .zero)

			let name = screen.reactive.name
			let canLogIn = name.map(\.isEmpty).map(!)
			let loginButtonAlpha = canLogIn.map { $0 ? 1 : 0.5 as CGFloat }

			welcomeLabel.text = "Welcome! Please Enter Your Name"
			welcomeLabel.textAlignment = .center

			nameField <~ name
			nameField.reactive.text.ignoreNils().removeDuplicates() ~> screen.reactive.nameTextEdited
			nameField.backgroundColor = UIColor(white: 0.92, alpha: 1.0)

			loginButton.setTitle("Login", for: .normal)
			loginButton.backgroundColor = UIColor(red: 41 / 255, green: 150 / 255, blue: 204 / 255, alpha: 1.0)
			loginButton.reactive.isEnabled <~ canLogIn
			loginButton.reactive.alpha <~ loginButtonAlpha
			loginButton.reactive.tap ~> screen.reactive.loginTapped
		}

		required init?(coder: NSCoder) {
			fatalError()
		}

		override var subviewsLayout: AnyLayout {
			stack(.vertical)(
				UIView().addingLayout(welcomeLabel.centeringInParent()),
				stack(.vertical, spacing: 12)(
					nameField.sizing(toHeight: 44),
					loginButton.sizing(toHeight: 44)
				).insetting(
					leftBy: 12,
					rightBy: 12,
					topBy: 0,
					bottomBy: 0
				).centeringVerticallyInParent(),
				UIView()
			).fillingParent()
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

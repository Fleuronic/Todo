import UIKit
import Layoutless

extension Welcome {
	final class View: UI.View {
		private let welcomeLabel = UILabel(style: .welcome)
		private let nameField = UITextField(style: .name)
		private let loginButton = UIButton(style: .login)

		init(screen: some ScreenProxy<Screen>) {
			super.init(frame: .zero)

			screen.name ~> nameField
			screen.nameTextEdited <~ nameField.reactive.editedText
			screen.canLogIn ~> loginButton.reactive.isEnabled
			screen.canLogIn.map { $0 ? .full : .disabled } ~> loginButton.reactive.opacity
			screen.loginTapped <~ loginButton.reactive.tap
		}

		required init(coder: NSCoder) {
			fatalError()
		}

		override var subviewsLayout: AnyLayout {
			stack(.vertical) {
				UIView().addingLayout(welcomeLabel.centeringInParent())
				stack(.vertical, spacing: .element) {
					nameField.sizing(toHeight: .element)
					loginButton.sizing(toHeight: .element)
				}.insetBy(horizontalInsets: .element).centeringVerticallyInParent()
				UIView()
			}.fillingParent()
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

// MARK: -
private extension Style where View == UILabel {
	static let welcome = Self {
		$0.text = "Welcome! Please Enter Your Name"
	}.centered
}

// MARK: -
private extension Style where View == UITextField {
	static let name = Self {
		$0.backgroundColor = Color.Background.TextField.name.color
	}
}

// MARK: -
private extension Style where View == UIButton {
	static let login = Self {
		$0.setTitle("Login", for: .normal)
	}.adding(.primary)
}

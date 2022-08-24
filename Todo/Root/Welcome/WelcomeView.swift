import UIKit
import Layoutless

extension Welcome {
	final class View: ReactiveView<Screen> {
		override func layout(with screen: some ScreenProxy<Screen>) -> AnyLayout {
			let promptLabel = UILabel(style: .welcome)
			let nameField = UITextField(style: .name)
			let loginButton = UIButton(style: .login)

			screen.name ~> nameField
			screen.nameTextEdited <~ nameField.reactive.editedText
			screen.canLogIn ~> loginButton.reactive.isEnabled
			screen.canLogIn.map { $0 ? .full : .disabled } ~> loginButton.reactive.opacity
			screen.loginTapped <~ loginButton.reactive.tap

			return stack(.vertical) {
				spacer().addingLayout(promptLabel.centeringInParent())
				stack(.vertical, spacing: .element) {
					nameField.sizing(toHeight: .element)
					loginButton.sizing(toHeight: .element)
				}.insetBy(horizontalInsets: .element).centeringVerticallyInParent()
				spacer()
			}.fillingParent()
		}
	}
}

// MARK: -
extension Welcome.Screen: ReactiveScreen {
	typealias View = Welcome.View
}

// MARK: -
private extension Style where View == UILabel {
	static let welcome = Self {
		$0.text = Strings.Welcome.prompt
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
		$0.setTitle(Strings.Welcome.Title.Button.login, for: .normal)
	}.adding(.primary)
}

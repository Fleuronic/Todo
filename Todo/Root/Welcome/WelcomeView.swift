import UIKit
import Layoutless
import Geometric

extension Welcome {
	final class View: UIView {}
}

// MARK: -
extension Welcome.View: Stacking {
	typealias Screen = Welcome.Screen

	@VerticallyStacked<Self> func content(screen: some ScreenProxy<Screen>) -> Layout<UIStackView> {
		spacer().addingLayout(
			UILabel
				.text(screen.prompt)
				.centered
				.centeringInParent()
		)
		stack(.vertical, spacing: .element) {
			UITextField
				.text(screen.name)
				.edited(screen.nameTextEdited)
				.backgroundColor { $0.TextField.name }
				.sizing(toHeight: .element)
			UIButton
				.tap(screen.loginTapped)
				.title(screen.loginTitle)
				.enabled(screen.canLogIn)
				.opacity(screen.canLogIn.map { $0 ? .full : .disabled })
				.style(.primary)
				.sizing(toHeight: .element)
		}.insetBy(horizontalInsets: .element).centeringVerticallyInParent()
		spacer()
	}
}

// MARK: -
extension Welcome.Screen: ReactiveScreen {
	typealias View = Welcome.View
}

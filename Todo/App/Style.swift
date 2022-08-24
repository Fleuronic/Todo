import UIKit

extension UIButton {
	enum Style {
		case primary
	}

	func style(_ style: Style) -> Self {
		switch style {
		case .primary:
			return background { $0.Button.primary }
		}
	}
}

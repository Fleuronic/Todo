import UIKit
import Metric

typealias LocalizableString = (Strings.Type) -> String

extension ColorAsset: Metric.ColorAsset {}

// MARK: -
extension UIView {
	func backgroundColor(_ color: (Colors.Background.Type) -> ColorAsset) -> Self {
		backgroundColorAsset(color)
	}

	func borderColor(_ color: (Colors.Border.Type) -> ColorAsset) -> Self {
		borderColorAsset(color)
	}
}

// MARK: -
extension UIButton {
	enum Style {
		case primary
	}

	func style(_ style: Style) -> Self {
		switch style {
		case .primary:
			return backgroundColor { $0.Button.primary }
		}
	}
}

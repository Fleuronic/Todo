// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UILabel
import class UIKit.UIFont
import class Telemetric.Label
import struct Telemetric.Styled

public enum Text {}

// MARK: -
public extension Text {
	enum Style {
		case header
		case prompt
		case emptyState
		case error
	}
}

// MARK: -
public extension UILabel {
	static func style(_ style: Text.Style) -> Styled<Label> {
		let styled: Styled<Label> = .init().font(style.font)

		switch style {
		case .header, .prompt:
			return styled
				.centered
				.multiline
		case .emptyState:
			return styled
				.textColor { $0.secondary }
		case .error:
			return styled
				.centered
				.multiline
				.textColor { $0.error }
		}
	}
}

// MARK: -
private extension Text.Style {
	var font: UIFont {
		switch self {
		case .header:
			return
				.size(.large)
				.weight(.semibold)
				.design(.rounded)
		case .emptyState:
			return
				.size(.large)
				.weight(.light)
				.italic
		case .prompt, .error:
			return
				.size(.small)
		}
	}
}

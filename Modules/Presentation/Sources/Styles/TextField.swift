// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UITextField
import class Telemetric.TextField
import struct Model.Username
import struct Telemetric.Styled

public extension UITextField {
	enum Style {
		case username
		case phoneNumber
		case title
	}
}

// MARK: -
public extension UITextField {
	static func style(_ style: Style) -> Styled<TextField> {
		switch style {
		case .username:
			return .init()
				.autocorrectionType(.no)
				.autocapitalizationType(.none)
				.acceptedCharacter(Username.regex)
				.backgroundColor { $0.TextField.info }
				.borderStyle(.roundedRect)
		case .phoneNumber:
			return .init()
				.keyboardType(.emailAddress)
				.autocorrectionType(.no)
				.autocapitalizationType(.none)
				.backgroundColor { $0.TextField.info }
				.borderStyle(.roundedRect)
		case .title:
			return .init()
				.borderWidth(.field)
				.borderColor { $0.TextField.primary }
		}
	}
}

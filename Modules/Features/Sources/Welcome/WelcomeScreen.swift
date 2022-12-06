// Copyright © Fleuronic LLC. All rights reserved.

import enum Assets.Strings
import typealias Ergo.Event

public extension Welcome {
	struct Screen {
		let username: String
		let phoneNumber: String
		let isVerifyingEmail: Bool
		let hasInvalidEmail: Bool
 		let errorMessage: String?
		let usernameTextEdited: Event<String>
		let phoneNumberTextEdited: Event<String>
		let submitTapped: Event<Void>
	}
}

// MARK: -
extension Welcome.Screen {
	public typealias Strings = Assets.Strings.Welcome

	var header: ScreenString {
		{ $0.header }
	}

	var prompt: ScreenString {
		{ $0.prompt }
	}

	var usernamePlaceholder: ScreenString {
		{ $0.Placeholder.username }
	}

	var phoneNumberPlaceholder: ScreenString {
		{ $0.Placeholder.phoneNumber }
	}

	var submitTitle: ScreenString {
		{ $0.Title.submit }
	}

	var invalidEmailErrorMessage: ScreenString {
		{ $0.Error.email }
	}

	var canSubmit: Bool {
		!username.isEmpty && !phoneNumber.isEmpty && !isVerifyingEmail && !hasInvalidEmail
	}
}

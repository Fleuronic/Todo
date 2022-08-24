extension Welcome {
	struct Screen {
		let name: String
		let nameTextEdited: Event<String>
		let loginTapped: Event<Void>
	}
}

extension Welcome.Screen {
	var prompt: LocalizableString {
		{ $0.Welcome.prompt }
	}

	var loginTitle: LocalizableString {
		{ $0.Welcome.Title.login }
	}

	var canLogIn: Bool {
		!name.isEmpty
	}
}

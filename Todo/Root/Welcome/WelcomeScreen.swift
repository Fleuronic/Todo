import ReactiveKit

extension Welcome {
	struct Screen {
		let name: String
		let nameTextEdited: Event<String>
		let loginTapped: Event<Void>
	}
}

extension Welcome.Screen {
	var canLogIn: Bool {
		!name.isEmpty
	}
}

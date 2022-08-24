extension Todo.List {
	struct Screen {
		let todoTitles: [String]
		let rowSelected: Event<Int>
	}
}

extension Todo.List.Screen {
	var prompt: LocalizableString {
		{ $0.Todo.List.prompt }
	}
}

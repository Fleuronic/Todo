extension Todo.Edit {
	struct Screen {
		let title: String
		let note: String
		let titleTextEdited: Event<String>
		let noteTextEdited: Event<String>
	}
}

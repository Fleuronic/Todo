import UIKit
import Layoutless

extension Todo.Edit {
	final class View: UI.View {
		private let titleField = UITextField()
		private let noteField = UITextView()

		init(screen: some ScreenProxy<Screen>) {
			super.init(frame: .zero)

			titleField <~ screen.reactive.title
			titleField.reactive.editedText ~> screen.reactive.titleTextEdited
			titleField.textAlignment = .center
			titleField.layer.borderWidth = 1
			titleField.layer.borderColor = UIColor.black.cgColor

			noteField <~ screen.reactive.note
			noteField.reactive.editedText ~> screen.reactive.noteTextEdited
			noteField.layer.borderWidth = 1
			noteField.layer.borderColor = UIColor.gray.cgColor
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError()
		}

		override var subviewsLayout: AnyLayout {
			stack(.vertical, spacing: .element) {
				titleField.sizing(toHeight: .element)
				noteField
			}.fillingParent()
		}
	}
}

// MARK: -
extension Todo.Edit.View: ReactiveView {
	typealias Screen = Todo.Edit.Screen
}

// MARK: -
extension Todo.Edit.Screen: ReactiveScreen {
	typealias View = Todo.Edit.View
}

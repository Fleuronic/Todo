import UIKit
import Layoutless

extension Todo.Edit {
	final class View: ReactiveView<Screen> {
		override func layout(with screen: some ScreenProxy<Screen>) -> AnyLayout {
			let titleField = UITextField(style: .title)
			let noteField = UITextView(style: .note)

			screen.title ~> titleField
			screen.titleTextEdited <~ titleField.reactive.editedText
			screen.note ~> noteField
			screen.noteTextEdited <~ noteField.reactive.editedText

			return stack(.vertical, spacing: .element) {
				titleField.sizing(toHeight: .element)
				noteField
			}.fillingParent()
		}
	}
}

// MARK: -
extension Todo.Edit.Screen: ReactiveScreen {
	typealias View = Todo.Edit.View
}

// MARK: -
private extension Style where View == UITextField {
	static let title = Self {
		$0.borderWidth = Border.Width.field
		$0.layer.borderColor = Color.Border.TextField.primary.color.cgColor
	}.centered
}

// MARK: -
private extension Style where View == UITextView {
	static let note = Self {
		$0.borderWidth = Border.Width.field
		$0.layer.borderColor = Color.Border.TextField.secondary.color.cgColor
	}
}

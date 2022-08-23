import UIKit
import Layoutless

extension Todo.Edit {
	final class View: UI.View {
		private let titleField = UITextField(style: .title)
		private let noteField = UITextView(style: .note)

		init(screen: some ScreenProxy<Screen>) {
			super.init(frame: .zero)

			screen.title ~> titleField
			screen.titleTextEdited <~ titleField.reactive.editedText
			screen.note ~> noteField
			screen.noteTextEdited <~ noteField.reactive.editedText
		}

		required init(coder: NSCoder) {
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

// MARK: -
private extension Style where View == UITextField {
	static let title = Self {
		$0.borderWidth = BorderWidth.field
		$0.layer.borderColor = Color.Border.TextField.primary.color.cgColor
	}.centered
}

// MARK: -
private extension Style where View == UITextView {
	static let note = Self {
		$0.borderWidth = BorderWidth.field
		$0.layer.borderColor = Color.Border.TextField.secondary.color.cgColor
	}
}

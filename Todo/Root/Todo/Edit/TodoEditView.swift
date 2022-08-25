import UIKit
import Layoutless
import Metric

extension Todo.Edit {
	final class View: UIView {}
}

extension Todo.Edit.View: Stacking {
	typealias Screen = Todo.Edit.Screen

	static var verticalSpacing: Spacing.Vertical { .element }

	@VerticallyStacked<Self> func content(screen: some ScreenProxy<Screen>) -> Layout<UIStackView> {
		UITextField
			.text(screen.title)
			.edited(screen.titleTextEdited)
			.borderWidth { $0.field }
			.borderColor { $0.TextField.primary }
			.centered
			.sizing(toHeight: .element)
		UITextView
			.text(screen.note)
			.edited(screen.noteTextEdited)
			.borderWidth { $0.field }
			.borderColor { $0.TextField.secondary }
	}
}

// MARK: -
extension Todo.Edit.Screen: ReactiveScreen {
	typealias View = Todo.Edit.View
}

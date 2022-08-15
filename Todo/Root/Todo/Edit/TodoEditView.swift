import UIKit
import ReactiveSwift

extension Todo.Edit {
	final class View: UIView {
		private lazy var titleField: UITextField = {
			let textField = UITextField()
			textField.textAlignment = .center
			textField.layer.borderColor = UIColor.black.cgColor
			textField.layer.borderWidth = 1
			addSubview(textField)
			return textField
		}()

		private lazy var noteField: UITextView = {
			let textView = UITextView()
			textView.layer.borderColor = UIColor.gray.cgColor
			textView.layer.borderWidth = 1
			addSubview(textView)
			return textView
		}()

		init<T: ScreenProxy>(screen: T) where T.Screen == Screen {
			super.init(frame: .zero)

			titleField.reactive.text <~ screen.reactive.title
			noteField.reactive.text <~ screen.reactive.note
			screen.reactive.titleTextEdited <~ titleField.reactive.editedText
			screen.reactive.noteTextEdited <~ noteField.reactive.editedText
		}

		required init?(coder aDecoder: NSCoder) {
			fatalError()
		}

		override public func layoutSubviews() {
			super.layoutSubviews()

			let titleHeight: CGFloat = 44
			let spacing: CGFloat = 8
			let widthInset: CGFloat = 8

			var yOffset = bounds.minY

			titleField.frame = CGRect(
				x: bounds.minX,
				y: yOffset,
				width: bounds.maxX,
				height: titleHeight
			).insetBy(dx: widthInset, dy: 0)

			yOffset += titleHeight + spacing

			noteField.frame = CGRect(
				x: bounds.minX,
				y: yOffset,
				width: bounds.maxX,
				height: bounds.maxY - yOffset
			).insetBy(dx: widthInset, dy: 0)
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

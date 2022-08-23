import UIKit
import ReactiveKit

extension ReactiveExtensions where Base: UITextField {
	public var editedText: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

extension ReactiveExtensions where Base: UITextView {
	public var editedText: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

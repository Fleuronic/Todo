import UIKit
import ReactiveKit
import Bond

extension ReactiveExtensions where Base: UIView {
	public var opacity: Bond<Opacity> {
		bond { $0.opacity = $1 }
	}
}

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

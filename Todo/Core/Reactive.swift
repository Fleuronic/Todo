import UIKit
import ReactiveSwift

extension Reactive where Base: UIControl {
	var tap: Signal<Void, Never> {
		controlEvents(.touchUpInside).map { _ in }
	}
}

extension Reactive where Base: UITextField {
	var editedText: Signal<String, Never> {
		continuousTextValues.skipRepeats()
	}
}

extension Reactive where Base: UITextView {
	var editedText: Signal<String, Never> {
		continuousTextValues.skipRepeats()
	}
}

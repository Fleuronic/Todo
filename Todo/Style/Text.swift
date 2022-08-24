import UIKit
import ReactiveKit
import Bond

typealias LocalizableString = (Strings.Type) -> String

extension UILabel {
	var centered: Self {
		textAlignment = .center
		return self
	}

	static func text<Source: SignalProtocol>(_ source: Source) -> UILabel where Source.Element == LocalizableString, Source.Error == Never {
		let label = UILabel()
		_ = source.map { $0(Strings.self) }.bind(to: label.reactive.text)
		return label
	}
}

extension UITextField {
	var centered: Self {
		textAlignment = .center
		return self
	}

	func edited<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == String {
		_ = target.bind(signal: reactive.editedText)
		return self
	}

	static func text<Source: SignalProtocol>(_ source: Source) -> UITextField where Source.Element == String, Source.Error == Never {
		let textField = UITextField()
		_ = source.bind(to: textField.reactive.text)
		return textField
	}
}

extension UITextView {
	var centered: Self {
		textAlignment = .center
		return self
	}

	func edited<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == String {
		_ = target.bind(signal: reactive.editedText)
		return self
	}

	static func text<Source: SignalProtocol>(_ source: Source) -> UITextView where Source.Element == String, Source.Error == Never {
		let textView = UITextView()
		_ = source.bind(to: textView.reactive.text)
		return textView
	}
}

private extension ReactiveExtensions where Base: UITextField {
	var editedText: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

private extension ReactiveExtensions where Base: UITextView {
	var editedText: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

import UIKit
import ReactiveKit

extension UIButton {
	func title<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == LocalizableString, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: reactive.title)
		return self
	}

	func enabled<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Bool, Source.Error == Never {
		_ = source.bind(to: reactive.isEnabled)
		return self
	}

	static func tap<Target: BindableProtocol>(_ target: Target) -> UIButton where Target.Element == Void {
		let button = UIButton()
		_ = target.bind(signal: button.reactive.tap)
		return button
	}
}

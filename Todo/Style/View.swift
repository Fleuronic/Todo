import UIKit
import ReactiveKit
import Bond

extension UIView {
	func background(_ color: (Colors.Background.Type) -> ColorAsset) -> Self {
		backgroundColor = color(Colors.Background.self).color
		return self
	}

	func opacity<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Opacity, Source.Error == Never {
		_ = source.bind(to: reactive.opacity)
		return self
	}
}

private extension ReactiveExtensions where Base: UIView {
	var opacity: Bond<Opacity> {
		bond { $0.opacity = $1 }
	}
}

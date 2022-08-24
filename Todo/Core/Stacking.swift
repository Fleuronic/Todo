import UIKit
import Layoutless

protocol Stacking: Layoutable {
	static var verticalSpacing: Spacing.Vertical { get }

	@VerticallyStacked<Self> func content(screen: some ScreenProxy<Screen>) -> Layout<UIStackView>
}

extension Stacking {
	static var verticalSpacing: Spacing.Vertical { .zero }

	func layout(with screen: some ScreenProxy<Screen>) -> AnyLayout {
		content(screen: screen).fillingParent()
	}
}

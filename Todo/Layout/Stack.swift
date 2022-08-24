import UIKit
import Layoutless

public func stack(
	_ axis: NSLayoutConstraint.Axis,
	@LayoutBuilder layout: () -> [AnyLayout],
	configure: @escaping (UIStackView) -> Void = { _ in }
) -> Layout<UIStackView> {
	stack(
		axis,
		spacing: .zero,
		layout: layout,
		configure: configure
	)
}

public func stack(
	_ axis: NSLayoutConstraint.Axis,
	spacing: Spacing.Vertical,
	@LayoutBuilder layout: () -> [AnyLayout],
	configure: @escaping (UIStackView) -> Void = { _ in }
) -> Layout<UIStackView> {
	stack(
		axis,
		spacing: spacing.value,
		layout: layout,
		configure: configure
	)
}

public func stack(
	_ axis: NSLayoutConstraint.Axis,
	spacing: CGFloat,
	@LayoutBuilder layout: () -> [AnyLayout],
	configure: @escaping (UIStackView) -> Void = { _ in }
) -> Layout<UIStackView> {
	stack(
		layout(),
		axis: axis,
		spacing: spacing,
		distribution: .fill,
		alignment: .fill,
		configure: configure
	)
}

@resultBuilder struct VerticallyStacked<T: Stacking> {
	static func buildBlock(_ layouts: AnyLayout?...) -> Layout<UIStackView> {
		stack(
			layouts.compactMap { $0 },
			axis: .vertical,
			spacing: T.verticalSpacing.value,
			distribution: .fill,
			alignment: .fill,
			configure: { _ in }
		)
	}
}

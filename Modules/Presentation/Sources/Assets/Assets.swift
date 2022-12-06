// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UIView
import class UIKit.UILabel
import class UIKit.UIButton
import class UIKit.UIColor
import struct Metric.Percentage
import struct Metric.Opacity
import struct Telemetric.Styled
import protocol Telemetric.TextStylable

public typealias SharedString = (Strings.Type) -> String

// MARK: -
public extension Styled where Value: UIView {
	func backgroundColor(color: (Colors.Background.Type) -> UIColor) -> Self {
		backgroundColorAsset(color)
	}

	func borderColor(color: (Colors.Border.Type) -> UIColor) -> Self {
		borderColorAsset(color)
	}
}

// MARK: -
public extension Styled where Value: UIButton {
	func titleColor(color: @escaping (Colors.Text.Type) -> UIColor) -> Self {
		titleColorAsset(color)
	}

	func backgroundColor(
		darkenedBy percentage: Percentage,
		fadedTo opacity: Opacity,
		color: @escaping (Colors.Background.Button.Type) -> UIColor
	) -> Self {
		backgroundColorAsset(
			darkenedBy: percentage,
			fadedTo: opacity,
			color: color
		)
	}
}

// MARK: -
public extension Styled where Value: TextStylable {
	func textColor(color: @escaping (Colors.Text.Type) -> UIColor) -> Self {
		textColorAsset(color)
	}
}

import UIKit
import Layoutless

extension Style where View == UIButton {
	static let primary = Self {
		$0.backgroundColor = Color.tint.color
	}
}

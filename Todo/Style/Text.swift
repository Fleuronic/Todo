import UIKit
import Layoutless

extension Style where View == UILabel {
	var centered: Self {
		modifying { $0.textAlignment = .center }
	}
}

extension Style where View == UITextField {
	var centered: Self {
		modifying { $0.textAlignment = .center }
	}
}

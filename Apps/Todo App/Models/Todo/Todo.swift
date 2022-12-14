// Copyright © Fleuronic LLC. All rights reserved.

import struct Model.Todo

extension [Model.Todo] {
	enum Configuration: String {
		case single
		case many
	}
}

// MARK: -
extension [Model.Todo] {
	static var initial: Self {
		switch Configuration.initialTodos {
		case .none:
			return []
		case .single:
			return [
				.init(
					title: "Beep",
					note: "Beep"
				)
			]
		case .many:
			return [
				.init(
					title: "Beep",
					note: "Beep"
				),
				.init(
					title: "Beep",
					note: "Beep"
				),
				.init(
					title: "Beep",
					note: "Beep"
				)
			]
		}
	}
}

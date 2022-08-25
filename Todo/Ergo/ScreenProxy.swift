// Copyright © Fleuronic LLC. All rights reserved.

import WorkflowUI
import ReactiveKit
import Bond

@dynamicMemberLookup protocol ScreenProxy<Screen> {
	associatedtype Screen: WorkflowUI.Screen

	subscript<T>(dynamicMember keyPath: KeyPath<Screen, T>) -> SafeSignal<T> { get }
	subscript<T>(dynamicMember keyPath: KeyPath<Screen, Event<T>>) -> Bond<T> { get }
}

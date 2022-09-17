// Copyright © Fleuronic LLC. All rights reserved.

import class Stores.AnySingleObjectStore
import class Stores.SingleUserDefaultsStore
import class Stores.SingleKeychainStore

public protocol Keyed<Key> {
	associatedtype Key: RawRepresentable<String> & Codable & CaseIterable

	var key: Key { get }

	static var usesSecureStorage: Bool { get }
}

// MARK: -
public extension Keyed {
	static var usesSecureStorage: Bool { false }
}

// MARK: -
public extension Storable where Self: Keyed {
	static func stored(key: Key) -> Self? {
		store(for: key).object()
	}

	// MARK: Storable
	@discardableResult
	func store() -> Self {
		try! Self.store(for: key).save(self)
		return self
	}

	@discardableResult
	func removeFromStorage() -> Self {
		try? Self.store(for: key).remove()
		return self
	}

	static func removeFromStorage() {
		for key in Key.allCases {
			try? store(for: key).remove()
		}
	}
}

// MARK: -
private extension Storable where Self: Keyed {
	static func store(for key: Key) -> AnySingleObjectStore<Self> {
		let identifier = key.rawValue
		return usesSecureStorage ?
			SingleKeychainStore<Self>(identifier: identifier).eraseToAnyStore() :
			SingleUserDefaultsStore<Self>(identifier: identifier).eraseToAnyStore()
	}
}

// MARK: -
public extension Prestored where Self: Keyed {
	// MARK: Storable
	static func stored(key: Key) -> Self? {
		store[key.rawValue]
	}

	@discardableResult
	func store() -> Self {
		universalStore[key.rawValue] = self
		return self
	}

	@discardableResult
	func removeFromStorage() -> Self {
		universalStore.removeValue(forKey: key.rawValue)
		return self
	}

	static func removeFromStorage() {
		for key in Key.allCases {
			universalStore.removeValue(forKey: key.rawValue)
		}
	}
}
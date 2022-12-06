// Copyright © Fleuronic LLC. All rights reserved.

import protocol Coffin.Storable

public struct User {
	public let username: Username
	public let phoneNumber: String

	public init(
		username: Username,
		phoneNumber: String
	) {
		self.username = username
		self.phoneNumber = phoneNumber
	}
}

// MARK: -
extension User: Equatable {}

extension User: Codable {}

extension User: Storable {}

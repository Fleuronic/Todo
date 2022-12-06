// Copyright © Fleuronic LLC. All rights reserved.


import enum EmailableAPI.Emailable
import struct Model.User
import struct Model.Username
import struct Ergo.RequestWorker
import struct Ergo.DelayedWorker
import struct Workflow.Sink
import class Workflow.RenderContext
import protocol Workflow.Workflow
import protocol Workflow.WorkflowAction

public extension Welcome {
	struct Workflow {
		private let api: Emailable.API
		private let initialUsername: Username
		private let initialPhoneNumber: String

		public init(
			api: Emailable.API,
			initialUsername: Username? = nil,
			initialPhoneNumber: String? = nil
		) {
			self.api = api
			self.initialUsername = initialUsername ?? .empty
			self.initialPhoneNumber = initialPhoneNumber ?? .init()
		}
	}
}

// MARK: -
extension Welcome.Workflow: Workflow {
	public typealias Rendering = Welcome.Screen

	public struct State {
		var username: Username
		var phoneNumber: String
		var invalidEmails: [String] = []
		var emailVerificationState: Emailable.Email.Verification.State = .idle
	}

	public enum Output {
		case user(User)
	}

	public func makeInitialState() -> State {
		.init(
			username: initialUsername,
			phoneNumber: initialPhoneNumber
		)
	}

	public func render(state: State, context: RenderContext<Self>) -> Rendering {
		context.run(
			state
				.emailVerificationWorker(using: api)?
				.mapOutput(Action.finishEmailVerification),
			state
				.emailVerificationResetWorker?
				.mapOutput(Action.resetEmailVerification)
		)

		return screen(
			state: state,
			sink: context.makeSink(of: Action.self)
		)
	}
}

// MARK: -
extension Welcome.Workflow {
	enum Action: WorkflowAction {
		case updateUsername(Username)
		case updatePhoneNumber(String)
		case verifyEmail
		case finishEmailVerification(Emailable.Email.Verification.Result)
		case resetEmailVerification(Void)
	}
}

// MARK: -
private extension Welcome.Workflow {
	func screen(state: State, sink: Sink<Action>) -> Welcome.Screen {
		.init(
			username: state.username.displayValue,
			phoneNumber: state.phoneNumber,
			isVerifyingEmail: state.isVerifyingEmail,
			hasInvalidEmail: state.hasInvalidEmail,
			errorMessage: state.errorMessage,
			usernameTextEdited: { sink.send(.updateUsername(.init(rawValue: $0))) },
			phoneNumberTextEdited: { sink.send(.updatePhoneNumber($0)) },
			submitTapped: { sink.send(.verifyEmail) }
		)
	}
}

// MARK: -
extension Welcome.Workflow.Action {
	typealias WorkflowType = Welcome.Workflow

	func apply(toState state: inout Welcome.Workflow.State) -> Welcome.Workflow.Output? {
		switch self {
		case let .updateUsername(username):
			state.username = username
		case let .updatePhoneNumber(phoneNumber):
			state.phoneNumber = phoneNumber
			fallthrough
		case .resetEmailVerification:
			state.emailVerificationState = .idle
		case .verifyEmail:
			state.emailVerificationState = .requesting
		case let .finishEmailVerification(.success(verification)) where
			verification.reason == .acceptedEmail:
			state.emailVerificationState = .retrieved(verification)
			return .user(state.user.store())
		case let .finishEmailVerification(.success(verification)) where verification.reason == .invalidDomain:
			state.invalidEmails.append(verification.email)
			state.emailVerificationState = .retrieved(verification)
		case let .finishEmailVerification(.failure(error)):
			state.emailVerificationState = .failed(error)
		default:
			break
		}
		return nil
	}
}

// MARK: -
private extension Welcome.Workflow.State {
	var user: User {
		.init(
			username: username,
			phoneNumber: phoneNumber
		)
	}

	var isVerifyingEmail: Bool {
		emailVerificationState.isRequesting
	}

	var hasInvalidEmail: Bool {
		invalidEmails.contains(phoneNumber.lowercased())
	}

	var errorMessage: String? {
		emailVerificationState.mapError(\.message)
	}

	var emailVerificationResetWorker: DelayedWorker? {
		emailVerificationState.mapError(.init(delay: .reset))
	}

	func emailVerificationWorker(using api: Emailable.API) -> RequestWorker<Emailable.Email.Verification.Result>? {
		emailVerificationState.mapRequesting(.init { await api.verify(phoneNumber) })
	}
}

// MARK: -
extension Welcome.Workflow.Output: Equatable {}

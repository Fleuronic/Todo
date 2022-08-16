import ReactiveKit

infix operator ~>
@discardableResult
public func ~><S: SignalProtocol, B: BindableProtocol>(source: S, target: B) -> Disposable where S.Error == Never, S.Element == B.Element {
	return target.bind(signal: source.toSignal())
}

@discardableResult
public func ~><S: SignalProtocol, B: BindableProtocol>(source: S, target: B) -> Disposable where S.Error == Never, B.Element: OptionalProtocol, B.Element.Wrapped == S.Element {
	return source.map { B.Element($0) }.bind(to: target)
}

infix operator <~
@discardableResult
public func <~<S: SignalProtocol, B: BindableProtocol>(target: B, source: S) -> Disposable where S.Error == Never, S.Element == B.Element {
	return target.bind(signal: source.toSignal())
}

@discardableResult
public func <~<S: SignalProtocol, B: BindableProtocol>(target: B, source: S) -> Disposable where S.Error == Never, B.Element: OptionalProtocol, B.Element.Wrapped == S.Element {
	return source.map { B.Element($0) }.bind(to: target)
}

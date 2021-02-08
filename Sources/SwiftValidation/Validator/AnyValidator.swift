/// Type erasure idiom for Validator protocol.
public struct AnyValidator<Value>: Validator {
    private let validation: Validation

    public init<V: Validator>(_ validator: V) where V.Value == Value {
        self.validation = validator.validate(_:)
    }

    public func validate(_ value: Value) throws {
        try validation(value)
    }

    public func eraseToAnyValidator() -> AnyValidator<Value> { self }
}

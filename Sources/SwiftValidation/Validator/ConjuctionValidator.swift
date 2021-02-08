/// Complex validator implemented the conjunction semantic of validation: to accept the value it should be accepted by all the inner validators.
/// To add a new validator to the new validators use the method `extended` that creates a new validator with same behaviour and appended new validator.
/// In case of inner validators are empty does nothing.
public struct ConjunctionValidator<Value>: ExtendableValidator {
    public typealias Element = Value
    public let validators: [AnyValidator<Value>]

    /// Create validator with the conjunction semantic of validation.
    /// - Parameter validators: Inner validators
    public init(_ validators: [AnyValidator<Value>]) {
        self.validators = validators
    }

    public func validate(_ value: Value) throws {
        for validator in validators {
            try validator(value)
        }
    }

    public func extended<V>(with validator: V) -> ConjunctionValidator<Value> where V: Validator, Element == V.Value {
        ConjunctionValidator(validators + [validator.eraseToAnyValidator()])
    }
}

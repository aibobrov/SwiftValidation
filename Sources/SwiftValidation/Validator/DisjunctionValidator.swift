/// Complex validator implemented the disjunction semantics of validation: to accept the value it should be accepted at least by one of the inner validator.
/// To add a new validator to the new validators use the method `extended` that creates a new validator with same behaviour and appended new validator.
/// In case of inner validators are empty does nothing.
public struct DisjunctionValidator<Value>: ExtendableValidator {
    public typealias Element = Value
    public let validators: [AnyValidator<Value>]

    /// Create validator with the disjunction semantics of validation.
    /// - Parameter validators: Inner validators
    public init(_ validators: [AnyValidator<Value>]) {
        self.validators = validators
    }

    public func validate(_ value: Value) throws {
        guard !validators.isEmpty else {
            return
        }

        var errors: [Error] = []
        for validator in validators {
            do {
                try validator(value)
                return
            } catch {
                errors.append(error)
            }
        }

        throw DisjunctionValidatorError(errors: errors)
    }

    public func extended<V>(with validator: V) -> DisjunctionValidator<Value> where V: Validator, Element == V.Value {
        DisjunctionValidator(validators + [validator.eraseToAnyValidator()])
    }
}

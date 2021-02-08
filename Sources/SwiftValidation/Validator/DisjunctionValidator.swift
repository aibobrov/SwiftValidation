public struct DisjunctionValidator<Value>: ExtendableValidator {
    public typealias Element = Value
    public let validators: [AnyValidator<Value>]

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

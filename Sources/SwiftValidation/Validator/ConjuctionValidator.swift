public struct ConjuctionValidator<Value>: ExtendableValidator {
    public typealias Element = Value
    public let validators: [AnyValidator<Value>]

    public init(_ validators: [AnyValidator<Value>]) {
        self.validators = validators
    }

    public func validate(_ value: Value) throws {
        for validator in validators {
            try validator(value)
        }
    }

    public func extended<V>(with validator: V) -> ConjuctionValidator<Value> where V: Validator, Element == V.Value {
        ConjuctionValidator(validators + [validator.eraseToAnyValidator()])
    }
}

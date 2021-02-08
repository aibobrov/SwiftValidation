public struct AnyExtendableValidator<Value, Element>: ExtendableValidator {
    public typealias Extender = (AnyValidator<Element>) -> AnyExtendableValidator<Value, Element>
    private let validation: Validation
    private let extender: Extender

    public init<V: ExtendableValidator>(_ validator: V) where V.Value == Value, V.Element == Element {
        self.validation = validator.validate(_:)
        self.extender = { validator.extended(with: $0).eraseToAnyExtendableValidator() }
    }

    public func validate(_ value: Value) throws {
        try validation(value)
    }

    public func extended<V: Validator>(with validator: V) -> Self where Element == V.Value {
        extender(validator.eraseToAnyValidator())
    }

    public func eraseToAnyExtendableValidator() -> AnyExtendableValidator<Value, Element> {
        self
    }
}

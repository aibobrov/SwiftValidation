public protocol Validator {
    associatedtype Value

    typealias Validation = (Value) throws -> Void

    func validate(_ value: Value) throws

    func eraseToAnyValidator() -> AnyValidator<Value>
}

public extension Validator {
    func callAsFunction(_ value: Value) throws {
        try validate(value)
    }

    func eraseToAnyValidator() -> AnyValidator<Value> {
        AnyValidator(self)
    }
}

public protocol ExtendableValidator: Validator {
    associatedtype Element

    func extended<V: Validator>(with validator: V) -> Self where V.Value == Element

    func eraseToAnyExtendableValidator() -> AnyExtendableValidator<Value, Element>
}

public extension ExtendableValidator {
    func eraseToAnyExtendableValidator() -> AnyExtendableValidator<Value, Element> {
        AnyExtendableValidator(self)
    }
}

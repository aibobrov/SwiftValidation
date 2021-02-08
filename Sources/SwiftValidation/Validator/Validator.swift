/// Base validator. Can validate the object.
/// Validation can throw an error in case of the validator cannot accept the given value.
public protocol Validator {
    associatedtype Value

    /// Validation closure type to check the given value.
    typealias Validation = (Value) throws -> Void

    /// Validates the given value
    /// - Parameter value: Value to validate.
    /// - Throws: An error in case of validator cannot accept the value.
    func validate(_ value: Value) throws

    /// Type erase idiom member function.
    /// - Returns: Type erasure object of self.
    func eraseToAnyValidator() -> AnyValidator<Value>
}

public extension Validator {
    /// Validate the value using function call syntax.
    /// - Parameter value: Value to validate.
    func callAsFunction(_ value: Value) throws {
        try validate(value)
    }

    func eraseToAnyValidator() -> AnyValidator<Value> {
        AnyValidator(self)
    }
}

/// Validator the can be extended with another validator.
/// Used for support of dot notation declaration of validator.
public protocol ExtendableValidator: Validator {
    associatedtype Element

    /// Extendes the validator using the new `validator`
    func extended<V: Validator>(with validator: V) -> Self where V.Value == Element

    /// Type erase idiom member function.
    /// - Returns: Type erasure object of self.
    func eraseToAnyExtendableValidator() -> AnyExtendableValidator<Value, Element>
}

public extension ExtendableValidator {
    func eraseToAnyExtendableValidator() -> AnyExtendableValidator<Value, Element> {
        AnyExtendableValidator(self)
    }
}

/// Validator checks predicate on the given value.
/// Throws an error in case of predicate returns *false*.
public struct PredicateValidator<Value>: Validator {
    public typealias Predicate = (Value) throws -> Bool

    private let predicate: Predicate

    /// Validator that fails in case of predicate returns *false* on the given value.
    /// - Parameter predicate: Predicate to check value on.
    public init(_ predicate: @escaping Predicate) {
        self.predicate = predicate
    }

    public func validate(_ value: Value) throws {
        if try !predicate(value) {
            throw PredicateValidationError()
        }
    }
}

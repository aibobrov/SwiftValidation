public struct PredicateValidator<Value>: Validator {
    public typealias Predicate = (Value) throws -> Bool

    private let predicate: Predicate

    public init(_ predicate: @escaping Predicate) {
        self.predicate = predicate
    }

    public func validate(_ value: Value) throws {
        if try !predicate(value) {
            throw PredicateValidationError()
        }
    }
}

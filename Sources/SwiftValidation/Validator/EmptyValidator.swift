public struct EmptyValidator<Value>: Validator {
    public func validate(_ value: Value) throws {
    }
}

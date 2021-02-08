/// Validator that checks for errors inside `action`.
public struct NoThrowValidator<Value>: Validator {
    public typealias Action = (Value) throws -> Void

    private let action: Action

    /// Checks for errors inside `action` using given value.
    /// Throws an error in case of action throw the error.
    public init(_ action: @escaping (Value) throws -> Void) {
        self.action = action
    }

    public func validate(_ value: Value) throws {
        do {
            try action(value)
        } catch {
            throw UnexpectedExceptionError(reason: error)
        }
    }
}

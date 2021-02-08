public struct PartialValidationError: ValidationError {
    public let field: String?
    public let reason: ValidationError

    public var propertyName: String? {
        return sequence(first: self, next: { $0.reason as? PartialValidationError })
            .map { $0.field ?? "_" }
            .joined(separator: ".")
    }
}

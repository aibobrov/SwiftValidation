/// Error that can be throw when validating the propery of the value.
public struct PartialValidationError: ValidationError {
    /// Name of the property.
    public let property: String?
    /// Reason of the error.
    public let reason: ValidationError

    /// Collected the property name.
    public var propertyName: String? {
        return sequence(first: self, next: { $0.reason as? PartialValidationError })
            .map { $0.property ?? "_" }
            .joined(separator: ".")
    }
}

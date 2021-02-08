/// Validator validates the property created from value using `mapper` closure.
public struct PartialValidator<Value, Part>: Validator {
    public typealias Mapper = (Value) throws -> Part

    private let mapper: Mapper
    private let partName: String?
    private let validator: AnyValidator<Part>

    /// Validates the property created from given value using `mapper` closure.
    /// - Parameters:
    ///   - mapper: Mapping the value to fetch the property for validation.
    ///   - partName: Name of the fetched property. Used for errors only.
    ///   - validator: Validator of the fetched property.
    public init(_ mapper: @escaping Mapper, partName: String?, validator: AnyValidator<Part>) {
        self.mapper = mapper
        self.partName = partName
        self.validator = validator
    }

    public func validate(_ value: Value) throws {
        let part = try mapper(value)
        do {
            try validator(part)
        } catch let error as ValidationError {
            throw PartialValidationError(property: partName, reason: error)
        }
    }
}

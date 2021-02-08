/// Combines the behaviour PartialValidator and `ExtendableValidator`.
/// Validator validates the property created from value using `mapper` closure and can be extended with new validator.
/// To add a new validator to the new validators use the method `extended` that creates a new validator with same behaviour and appended new validator.
public struct ExtendablePartialValidator<Value, Part>: ExtendableValidator {
    public typealias Element = Part

    public typealias Mapper = (Value) throws -> Part

    private let mapper: Mapper
    private let partName: String?
    private let validator: AnyExtendableValidator<Part, Part>

    /// Creates new validator that combines the behaviour PartialValidator and `ExtendableValidator`.
    /// Validator validates the property created from value using `mapper` closure and can be extended with new validator.
    /// - Parameters:
    ///   - mapper: Mapping the value to fetch the property for validation.
    ///   - partName: Name of the fetched property. Used for errors only.
    ///   - validator: Validator of the fetched property.
    public init(_ mapper: @escaping Mapper, partName: String?, validator: AnyExtendableValidator<Part, Part>) {
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

    public func extended<V: Validator>(with newValidator: V) -> Self where V.Value == Part {
        ExtendablePartialValidator(mapper,
                                   partName: partName,
                                   validator: validator.extended(with: newValidator.eraseToAnyValidator()))
    }
}

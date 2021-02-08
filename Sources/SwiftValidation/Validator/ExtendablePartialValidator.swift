public struct ExtendablePartialValidator<Value, Part>: ExtendableValidator {
    public typealias Element = Part

    public typealias Mapper = (Value) throws -> Part

    private let mapper: Mapper
    private let partName: String?
    private let validator: AnyExtendableValidator<Part, Part>

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
            throw PartialValidationError(field: partName, reason: error)
        }
    }

    public func extended<V: Validator>(with newValidator: V) -> Self where V.Value == Part {
        ExtendablePartialValidator(mapper,
                                   partName: partName,
                                   validator: validator.extended(with: newValidator.eraseToAnyValidator()))
    }
}

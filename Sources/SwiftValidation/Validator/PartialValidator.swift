public struct PartialValidator<Value, Part>: Validator {
    public typealias Mapper = (Value) throws -> Part

    private let mapper: Mapper
    private let partName: String?
    private let validator: AnyValidator<Part>

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
            throw PartialValidationError(field: partName, reason: error)
        }
    }
}

public func validate<Value>(_ value: Value, @ValidationBuilder<Value> _ builder: () -> [AnyValidator<Value>]) throws {
    let validator = ConjuctionValidator(builder())
    try validator(value)
}

public func validateAny<Value>(
    _ value: Value,
    @ValidationBuilder<Value> _ builder: () -> [AnyValidator<Value>]
) throws {
    let validator = DisjunctionValidator(builder())
    try validator(value)
}

public func validate<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil
) -> ExtendablePartialValidator<Value, Part> {
    ExtendablePartialValidator(mapper,
                               partName: name,
                               validator: ConjuctionValidator([]).eraseToAnyExtendableValidator())
}

public func validateAny<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil
) -> ExtendablePartialValidator<Value, Part> {
    ExtendablePartialValidator(mapper,
                               partName: name,
                               validator: DisjunctionValidator([]).eraseToAnyExtendableValidator())
}

public func validate<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil,
    @ValidationBuilder<Part> _ builder: () -> [AnyValidator<Part>]
) -> PartialValidator<Value, Part> {
    let validator = ConjuctionValidator(builder()).eraseToAnyValidator()
    return PartialValidator(mapper, partName: name, validator: validator)
}

public func validateAny<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil,
    @ValidationBuilder<Part> _ builder: () -> [AnyValidator<Part>]
) -> PartialValidator<Value, Part> {
    let validator = DisjunctionValidator(builder()).eraseToAnyValidator()
    return PartialValidator(mapper, partName: name, validator: validator)
}

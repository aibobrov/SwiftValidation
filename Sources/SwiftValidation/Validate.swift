/// Validate `value` using conjunction validation straregy.
/// - Parameters:
///   - value: Value instance to validate.
///   - builder: DSL closure for inner validators.
/// - Throws: Throws an erron in case of validation is falied.
public func validate<Value>(_ value: Value, @ValidationBuilder<Value> _ builder: () -> [AnyValidator<Value>]) throws {
    let validator = ConjunctionValidator(builder())
    try validator(value)
}

/// Validate `value` using disjunction validation straregy.
/// - Parameters:
///   - value: Value instance to validate.
///   - builder: DSL closure for inner validators.
/// - Throws: Throws an erron in case of validation is falied.
public func validateAny<Value>(
    _ value: Value,
    @ValidationBuilder<Value> _ builder: () -> [AnyValidator<Value>]
) throws {
    let validator = DisjunctionValidator(builder())
    try validator(value)
}

/// Creates the property validator of outer object using `mapper` function. KeyPath are also accepted.
/// The validator uses conjunction validation straregy.
/// - Parameters:
///   - mapper: Function to extract property from outer value.
///   - name: Name of this property. Used to calculate the property name in case of error is occurred.
/// - Returns: The property validator.
public func validate<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil
) -> ExtendablePartialValidator<Value, Part> {
    ExtendablePartialValidator(mapper,
                               partName: name,
                               validator: ConjunctionValidator([]).eraseToAnyExtendableValidator())
}

/// Creates the property validator of outer object using `mapper` function. KeyPath are also accepted.
/// The validator uses disjunction validation straregy.
/// - Parameters:
///   - mapper: Function to extract property from outer value.
///   - name: Name of this property. Used to calculate the property name in case of error is occurred.
/// - Returns: The property validator.
public func validateAny<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil
) -> ExtendablePartialValidator<Value, Part> {
    ExtendablePartialValidator(mapper,
                               partName: name,
                               validator: DisjunctionValidator([]).eraseToAnyExtendableValidator())
}

/// Creates the property validator of outer object using `mapper` function. KeyPath are also accepted.
/// The validator uses disjunction validation straregy.
/// - Parameters:
///   - mapper: Function to extract property from outer value.
///   - name: Name of this property. Used to calculate the property name in case of error is occurred.
///   - builder: DSL closure for inner validators.
/// - Returns: The property validator.
public func validate<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil,
    @ValidationBuilder<Part> _ builder: () -> [AnyValidator<Part>]
) -> PartialValidator<Value, Part> {
    let validator = ConjunctionValidator(builder()).eraseToAnyValidator()
    return PartialValidator(mapper, partName: name, validator: validator)
}

/// Creates the property validator of outer object using `mapper` function with inner validators creared by `builder` DSL. KeyPath are also accepted.
/// The validator uses disjunction validation straregy.
/// - Parameters:
///   - mapper: Function to extract property from outer value.
///   - name: Name of this property. Used to calculate the property name in case of error is occurred.
///   - builder: DSL closure for inner validators.
/// - Returns: The property validator.
public func validateAny<Value, Part>(
    _ mapper: @escaping (Value) throws -> Part,
    name: String? = nil,
    @ValidationBuilder<Part> _ builder: () -> [AnyValidator<Part>]
) -> PartialValidator<Value, Part> {
    let validator = DisjunctionValidator(builder()).eraseToAnyValidator()
    return PartialValidator(mapper, partName: name, validator: validator)
}

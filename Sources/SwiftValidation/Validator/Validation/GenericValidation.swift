/// Function factory with DSL support for inner validators that create the `DisjunctionValidator`
public func any<T>(@ValidationBuilder<T> _ builder: () -> [AnyValidator<T>]) -> DisjunctionValidator<T> {
    DisjunctionValidator(builder())
}

/// Function factory with DSL support for inner validators that create the `ConjunctionValidator`
public func all<T>(@ValidationBuilder<T> _ builder: () -> [AnyValidator<T>]) -> ConjunctionValidator<T> {
    ConjunctionValidator(builder())
}

/// Function factory with predicate that create the `PredicateValidator`
public func check<T>(_ predicate: @escaping PredicateValidator<T>.Predicate) -> PredicateValidator<T> {
    PredicateValidator(predicate)
}

/// Validates that the given value type is `type`
public func isType<T, R>(_ type: R.Type) -> PredicateValidator<T> {
    check { $0 is R }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator {
    /// Function factory with predicate that create the `PredicateValidator`
    func check(_ predicate: @escaping PredicateValidator<Element>.Predicate) -> Self {
        extended(with: SwiftValidation.check(predicate))
    }

    /// Validates that the given value type is `type`
    func isType<R>(_ type: R.Type) -> Self {
        extended(with: SwiftValidation.isType(type))
    }
}

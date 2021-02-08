public func any<T>(@ValidationBuilder<T> _ builder: () -> [AnyValidator<T>]) -> DisjunctionValidator<T> {
    DisjunctionValidator(builder())
}

public func all<T>(@ValidationBuilder<T> _ builder: () -> [AnyValidator<T>]) -> ConjuctionValidator<T> {
    ConjuctionValidator(builder())
}

public func check<T>(_ predicate: @escaping PredicateValidator<T>.Predicate) -> PredicateValidator<T> {
    PredicateValidator(predicate)
}

public func isType<T, R>(_ type: R.Type) -> PredicateValidator<T> {
    check { $0 is R }
}

public extension ExtendableValidator {
    func check(_ predicate: @escaping PredicateValidator<Element>.Predicate) -> Self {
        extended(with: SwiftValidation.check(predicate))
    }

    func isType<R>(_ type: R.Type) -> Self {
        extended(with: SwiftValidation.isType(type))
    }
}

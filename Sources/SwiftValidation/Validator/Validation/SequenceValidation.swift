/// Validates that the all values inside the given sequence value accepted by the `validator`.
public func forEach<S: Sequence, V: Validator>(_ validator: V) -> NoThrowValidator<S> where V.Value == S.Element {
    NoThrowValidator { sequence in
        for element in sequence {
            try validator(element)
        }
    }
}

/// Validates that the all values inside the given sequence value accepted by validators created by DSL syntax.
public func forEach<S: Sequence>(
    @ValidationBuilder<S.Element> _ builder: () -> [AnyValidator<S.Element>]
) -> NoThrowValidator<S> {
    let validator = ConjunctionValidator(builder())
    return forEach(validator)
}

/// Validates that the given sequence value contains an element that satisfies the predicate.
public func contains<S: Sequence>(where predicate: @escaping (S.Element) throws -> Bool) -> PredicateValidator<S> {
    check { try $0.contains(where: predicate) }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element: Sequence {
    /// Validates that the all values inside the given sequence value accepted by the `validator`.
    func forEach<V: Validator>(_ validator: V) -> Self where V.Value == Element.Element {
        extended(with: SwiftValidation.forEach(validator))
    }

    /// Validates that the given sequence value contains an element that satisfies the predicate.
    func contains(where predicate: @escaping (Element.Element) throws -> Bool) -> Self {
        extended(with: SwiftValidation.contains(where: predicate))
    }
}

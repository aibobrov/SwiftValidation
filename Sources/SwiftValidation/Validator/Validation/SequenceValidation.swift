public func forEach<S: Sequence, V: Validator>(_ validator: V) -> NoThrowValidator<S> where V.Value == S.Element {
    NoThrowValidator { sequence in
        for element in sequence {
            try validator(element)
        }
    }
}

public func forEach<S: Sequence>(
    @ValidationBuilder<S.Element> _ builder: () -> [AnyValidator<S.Element>]
) -> NoThrowValidator<S> {
    let validator = ConjuctionValidator(builder())
    return forEach(validator)
}

public func contains<S: Sequence>(where predicate: @escaping (S.Element) throws -> Bool) -> PredicateValidator<S> {
    check { try $0.contains(where: predicate) }
}

public extension ExtendableValidator where Element: Sequence {
    func forEach<V: Validator>(_ validator: V) -> Self where V.Value == Element.Element {
        extended(with: SwiftValidation.forEach(validator))
    }

    func contains(where predicate: @escaping (Element.Element) throws -> Bool) -> Self {
        extended(with: SwiftValidation.contains(where: predicate))
    }
}

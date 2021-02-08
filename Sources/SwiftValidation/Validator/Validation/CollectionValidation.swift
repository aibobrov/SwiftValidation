public func isEmpty<C: Collection>() -> PredicateValidator<C> {
    check { $0.isEmpty }
}

public func isNotEmpty<C: Collection>() -> PredicateValidator<C> {
    check { !$0.isEmpty }
}

extension ExtendableValidator where Element: Collection {
    public func isEmpty() -> Self {
        extended(with: SwiftValidation.isEmpty())
    }

    public func isNotEmpty() -> Self {
        extended(with: SwiftValidation.isNotEmpty())
    }
}

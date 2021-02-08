/// Validates that the collection is empty
public func isEmpty<C: Collection>() -> PredicateValidator<C> {
    check { $0.isEmpty }
}

/// Validates that the collection is not empty
public func isNotEmpty<C: Collection>() -> PredicateValidator<C> {
    check { !$0.isEmpty }
}

/// Extension for support of dot notation syntax.
extension ExtendableValidator where Element: Collection {
    /// Validates that the collection is empty
    public func isEmpty() -> Self {
        extended(with: SwiftValidation.isEmpty())
    }

    /// Validates that the collection is not empty
    public func isNotEmpty() -> Self {
        extended(with: SwiftValidation.isNotEmpty())
    }
}

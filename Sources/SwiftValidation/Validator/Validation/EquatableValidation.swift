/// Validates that the validated value is equals to `value`.
public func equals<T: Equatable>(to value: T) -> PredicateValidator<T> {
    check { $0 == value }
}

/// Validates that the validated value contains in the `sequence`.
public func contains<T: Equatable, S: Sequence>(in sequence: S) -> PredicateValidator<T> where S.Element == T {
    check { sequence.contains($0) }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element: Equatable {
    /// Validates that the validacted value is equals to `value`.
    func equals(to value: Element) -> Self {
        extended(with: SwiftValidation.equals(to: value))
    }

    /// Validates that the validacted value contains in the `sequence`.
    func contains<S: Sequence>(in sequence: S) -> Self where S.Element == Element {
        extended(with: SwiftValidation.contains(in: sequence))
    }
}

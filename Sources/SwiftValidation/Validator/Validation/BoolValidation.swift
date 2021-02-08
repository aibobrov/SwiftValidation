/// Validates that the boolean value is *true*.
public func isTrue() -> PredicateValidator<Bool> {
    check { $0 }
}

/// Validates that the boolean value is *false*.
public func isFalse() -> PredicateValidator<Bool> {
    check { !$0 }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element == Bool {
    /// Validates that the boolean value is *true*.
    func isTrue() -> Self {
        extended(with: SwiftValidation.isTrue())
    }

    /// Validates that the boolean value is *false*.
    func isFalse() -> Self {
        extended(with: SwiftValidation.isFalse())
    }
}

/// Validates that the validated value is equals to 0.
public func isZero<N: FixedWidthInteger>() -> PredicateValidator<N> {
    equals(to: 0)
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element: FixedWidthInteger {
    /// Validates that the validated value is equals to 0.
    func isZero() -> Self {
        extended(with: SwiftValidation.isZero())
    }
}

/// Validates that the validated value is positive (`value > 0`).
public func isPositive<N: SignedNumeric & BinaryInteger>() -> PredicateValidator<N> {
    check { $0 > 0 }
}

/// Validates that the validated value is positive (`value < 0`).
public func isNegative<N: SignedNumeric & BinaryInteger>() -> PredicateValidator<N> {
    check { $0 < 0 }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element: SignedNumeric & BinaryInteger {
    /// Validates that the validated value is positive (`value > 0`).
    func isPositive() -> Self {
        extended(with: SwiftValidation.isPositive())
    }

    /// Validates that the validated value is positive (`value < 0`).
    func isNegative() -> Self {
        extended(with: SwiftValidation.isNegative())
    }
}

/// Validates that the validated value is equals to `value` with `delta`.
/// While `delta` is the maximum difference (delta) between expected and actual for which both numbers are still considered equal.
public func equals<N: BinaryFloatingPoint>(_ value: N, delta: N) -> PredicateValidator<N> {
    check { abs($0 - value) <= delta }
}

/// Validates that the number is not a number.
public func isNan<N: BinaryFloatingPoint>() -> PredicateValidator<N> {
    check { $0.isNaN }
}

/// Extension for support of dot notation syntax.
public extension ExtendableValidator where Element: BinaryFloatingPoint {
    /// Validates that the validated value is equals to `value` with `delta`.
    /// While `delta` is the maximum difference (delta) between expected and actual for which both numbers are still considered equal.
    func equals(_ value: Element, delta: Element) -> Self {
        extended(with: SwiftValidation.equals(value, delta: delta))
    }

    /// Validates that the number is not a number.
    func isNan() -> Self {
        extended(with: SwiftValidation.isNan())
    }
}
